import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

import '../settings_service.dart';

/// App Store product for the one-time Premium unlock. The identifier predates
/// the Premium name and cannot be renamed in App Store Connect.
const String kPremiumProductIdIOS = 'com.appsbay.classicReversi.remove_ads';

/// Google Play product for the same one-time Premium unlock.
const String kPremiumProductIdAndroid = 'com.appsbay.classic_reversi.premium';

/// Daily coach tips available without Premium.
const int kFreeDailyCoachTips = 3;

/// Store product identifier for the running platform.
String premiumProductIdFor(TargetPlatform platform) =>
    platform == TargetPlatform.android
        ? kPremiumProductIdAndroid
        : kPremiumProductIdIOS;

/// Everything a Premium user receives. Used by the Premium screen and by
/// locked controls to explain what an upgrade includes.
enum PremiumFeature {
  adFree,
  unlimitedUndo,
  unlimitedTips,
  hints,
  expertAi,
  gameAnalysis,
  themes,
}

/// User-facing outcome of a buy or restore attempt.
enum PurchaseFeedback {
  success,
  restoreSuccess,
  restoreNothing,
  cancelled,
  pending,
  failed,
  unavailable,
  alreadyOwned,
}

/// Abstract purchase API so screens can be tested with a fake store.
abstract class PurchaseServiceBase extends ChangeNotifier {
  bool get isPremium;
  bool get isAvailable;
  bool get isPurchaseInProgress;
  bool get isSupportedPlatform;
  ProductDetails? get premiumProduct;
  String? get localizedPrice;

  /// Store name shown in restore help, e.g. "App Store" or "Google Play".
  String get storeName;

  Future<void> init();
  Future<void> disposeService();
  Future<void> loadProducts();
  Future<PurchaseFeedback> buyPremium();
  Future<PurchaseFeedback> restorePurchases({bool silent = false});
}

/// StoreKit / Play Billing backed Premium service. On web and desktop this
/// is a no-op shell: ads stay on and the purchase button stays hidden.
class PurchaseService extends PurchaseServiceBase {
  PurchaseService._();

  static final PurchaseService instance = PurchaseService._();

  InAppPurchase? _iap;
  StreamSubscription<List<PurchaseDetails>>? _subscription;
  ProductDetails? _premiumProduct;
  bool _isPremium = false;
  bool _isAvailable = false;
  bool _isPurchaseInProgress = false;
  bool _initialized = false;
  Completer<PurchaseFeedback>? _purchaseCompleter;
  Completer<PurchaseFeedback>? _restoreCompleter;
  bool _sawOwnedDuringRestore = false;

  InAppPurchase get _store {
    return _iap ??= InAppPurchase.instance;
  }

  String get _productId => premiumProductIdFor(defaultTargetPlatform);

  @override
  bool get isPremium => _isPremium;

  @override
  bool get isAvailable => _isAvailable;

  @override
  bool get isPurchaseInProgress => _isPurchaseInProgress;

  @override
  bool get isSupportedPlatform =>
      !kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.iOS ||
          defaultTargetPlatform == TargetPlatform.android);

  @override
  ProductDetails? get premiumProduct => _premiumProduct;

  @override
  String? get localizedPrice => _premiumProduct?.price;

  @override
  String get storeName =>
      defaultTargetPlatform == TargetPlatform.android
          ? 'Google Play'
          : 'App Store';

  @override
  Future<void> init() async {
    if (_initialized) {
      return;
    }
    _initialized = true;

    // Local cache first so Premium users skip ads before the store answers.
    _isPremium = await SettingsService.getPremiumUnlocked();
    notifyListeners();

    if (!isSupportedPlatform) {
      return;
    }

    _subscription = _store.purchaseStream.listen(
      _onPurchaseUpdated,
      onError: (Object error) {
        debugPrint('Purchase stream error: $error');
        _finishPurchaseAttempt(PurchaseFeedback.failed);
      },
    );

    try {
      _isAvailable = await _store.isAvailable();
    } catch (error) {
      debugPrint('IAP availability check failed: $error');
      _isAvailable = false;
    }

    if (_isAvailable) {
      await loadProducts();
      // Reconcile with the store without blocking first launch on the
      // restore stream timeout — fire and forget after local cache is ready.
      unawaited(restorePurchases(silent: true));
    }

    notifyListeners();
  }

  @override
  Future<void> disposeService() async {
    await _subscription?.cancel();
    _subscription = null;
    _initialized = false;
  }

  @override
  Future<void> loadProducts() async {
    if (!isSupportedPlatform || !_isAvailable) {
      // Runs synchronously when called from a widget's initState, so only
      // notify on a real change; listeners may not rebuild during build.
      if (_premiumProduct != null) {
        _premiumProduct = null;
        notifyListeners();
      }
      return;
    }

    try {
      final response = await _store.queryProductDetails({_productId});
      if (response.error != null) {
        debugPrint('queryProductDetails error: ${response.error}');
      }
      _premiumProduct = response.productDetails
          .cast<ProductDetails?>()
          .firstWhere(
            (p) => p?.id == _productId,
            orElse: () => null,
          );
    } catch (error) {
      debugPrint('loadProducts failed: $error');
      _premiumProduct = null;
    }
    notifyListeners();
  }

  @override
  Future<PurchaseFeedback> buyPremium() async {
    if (!isSupportedPlatform) {
      return PurchaseFeedback.unavailable;
    }
    if (_isPremium) {
      return PurchaseFeedback.alreadyOwned;
    }
    if (!_isAvailable || _premiumProduct == null) {
      if (!_isAvailable) {
        try {
          _isAvailable = await _store.isAvailable();
        } catch (error) {
          debugPrint('IAP availability retry failed: $error');
        }
      }
      await loadProducts();
      if (!_isAvailable || _premiumProduct == null) {
        return PurchaseFeedback.unavailable;
      }
    }
    if (_isPurchaseInProgress) {
      return PurchaseFeedback.pending;
    }

    _isPurchaseInProgress = true;
    notifyListeners();

    _purchaseCompleter = Completer<PurchaseFeedback>();
    final purchaseParam = PurchaseParam(productDetails: _premiumProduct!);

    try {
      final started =
          await _store.buyNonConsumable(purchaseParam: purchaseParam);
      if (!started) {
        _finishPurchaseAttempt(PurchaseFeedback.failed);
        return PurchaseFeedback.failed;
      }
    } catch (error) {
      debugPrint('buyPremium failed: $error');
      _finishPurchaseAttempt(PurchaseFeedback.failed);
      return PurchaseFeedback.failed;
    }

    return _purchaseCompleter?.future ?? Future.value(PurchaseFeedback.failed);
  }

  @override
  Future<PurchaseFeedback> restorePurchases({bool silent = false}) async {
    if (!isSupportedPlatform) {
      return PurchaseFeedback.unavailable;
    }
    if (!_isAvailable) {
      return PurchaseFeedback.unavailable;
    }
    // A second tap while a restore is running should observe the same result.
    final pending = _restoreCompleter;
    if (pending != null && !pending.isCompleted) {
      return pending.future;
    }

    if (!silent) {
      _isPurchaseInProgress = true;
      notifyListeners();
    }

    _sawOwnedDuringRestore = false;
    final completer = Completer<PurchaseFeedback>();
    _restoreCompleter = completer;

    try {
      await _store.restorePurchases();
    } catch (error) {
      debugPrint('restorePurchases failed: $error');
      _finishRestoreAttempt(PurchaseFeedback.failed, silent: silent);
      return PurchaseFeedback.failed;
    }

    // Stores may deliver restores asynchronously; give the stream a moment.
    Future<void>.delayed(const Duration(seconds: 2), () {
      if (identical(_restoreCompleter, completer) && !completer.isCompleted) {
        final result = _sawOwnedDuringRestore || _isPremium
            ? PurchaseFeedback.restoreSuccess
            : PurchaseFeedback.restoreNothing;
        _finishRestoreAttempt(result, silent: silent);
      }
    });

    return completer.future;
  }

  Future<void> _onPurchaseUpdated(List<PurchaseDetails> purchases) async {
    for (final purchase in purchases) {
      if (purchase.productID != _productId) {
        if (purchase.pendingCompletePurchase) {
          await _store.completePurchase(purchase);
        }
        continue;
      }

      switch (purchase.status) {
        case PurchaseStatus.purchased:
        case PurchaseStatus.restored:
          if (!await verifyPurchase(purchase)) {
            _finishPurchaseAttempt(PurchaseFeedback.failed);
            break;
          }
          await _grantEntitlement();
          if (purchase.status == PurchaseStatus.restored) {
            _sawOwnedDuringRestore = true;
          }
          // Play purchases are refunded unless acknowledged; StoreKit needs
          // the transaction finished. completePurchase does both.
          if (purchase.pendingCompletePurchase) {
            await _store.completePurchase(purchase);
          }
          if (_purchaseCompleter != null) {
            _finishPurchaseAttempt(
              purchase.status == PurchaseStatus.restored
                  ? PurchaseFeedback.alreadyOwned
                  : PurchaseFeedback.success,
            );
          }
          break;
        case PurchaseStatus.pending:
          // Ask to Buy / slow payment methods. The purchase completes later.
          if (_purchaseCompleter != null) {
            _finishPurchaseAttempt(PurchaseFeedback.pending);
          } else {
            notifyListeners();
          }
          break;
        case PurchaseStatus.error:
          if (purchase.pendingCompletePurchase) {
            await _store.completePurchase(purchase);
          }
          final code = (purchase.error?.code ?? '').toLowerCase();
          final message = (purchase.error?.message ?? '').toLowerCase();
          // Play reports an existing non-consumable as itemAlreadyOwned.
          final alreadyOwned = code.contains('itemalreadyowned') ||
              message.contains('itemalreadyowned') ||
              message.contains('already owned');
          if (alreadyOwned) {
            await _grantEntitlement();
            _finishPurchaseAttempt(PurchaseFeedback.alreadyOwned);
            break;
          }
          final cancelled = code.contains('cancel') ||
              message.contains('cancel');
          _finishPurchaseAttempt(
            cancelled ? PurchaseFeedback.cancelled : PurchaseFeedback.failed,
          );
          break;
        case PurchaseStatus.canceled:
          if (purchase.pendingCompletePurchase) {
            await _store.completePurchase(purchase);
          }
          _finishPurchaseAttempt(PurchaseFeedback.cancelled);
          break;
      }
    }

    // If a restore was waiting and we already saw owned products, finish early.
    final restore = _restoreCompleter;
    if (restore != null && !restore.isCompleted && _sawOwnedDuringRestore) {
      _finishRestoreAttempt(PurchaseFeedback.restoreSuccess);
    }
  }

  Future<void> _grantEntitlement() async {
    if (_isPremium) {
      return;
    }
    _isPremium = true;
    await SettingsService.setPremiumUnlocked(true);
    notifyListeners();
  }

  /// Test-only: set entitlement without talking to the store.
  @visibleForTesting
  Future<void> debugSetPremium(bool value) async {
    _isPremium = value;
    await SettingsService.setPremiumUnlocked(value);
    notifyListeners();
  }

  /// Hook for future server-side receipt validation. Today the store stream
  /// plus local persistence are the source of truth.
  @visibleForTesting
  Future<bool> verifyPurchase(PurchaseDetails purchase) async {
    return purchase.status == PurchaseStatus.purchased ||
        purchase.status == PurchaseStatus.restored;
  }

  void _finishPurchaseAttempt(PurchaseFeedback result) {
    _isPurchaseInProgress = false;
    final completer = _purchaseCompleter;
    _purchaseCompleter = null;
    if (completer != null && !completer.isCompleted) {
      completer.complete(result);
    }
    notifyListeners();
  }

  void _finishRestoreAttempt(PurchaseFeedback result, {bool silent = false}) {
    if (!silent) {
      _isPurchaseInProgress = false;
    }
    final completer = _restoreCompleter;
    _restoreCompleter = null;
    if (completer != null && !completer.isCompleted) {
      completer.complete(result);
    }
    notifyListeners();
  }
}

/// Whether the player owns Premium.
bool get isPremiumUser => PurchaseService.instance.isPremium;

/// Convenience: whether ads should run (platform-agnostic).
bool get shouldShowAds {
  if (kIsWeb) {
    return false;
  }
  return !PurchaseService.instance.isPremium;
}

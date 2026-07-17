import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

import '../settings_service.dart';

/// Product ID for the one-time Remove Ads non-consumable (iOS App Store).
const String kRemoveAdsProductId = 'com.appsbay.classicReversi.remove_ads';

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

/// Abstract purchase API so Android billing can be added later behind the
/// same interface without changing call sites.
abstract class PurchaseServiceBase extends ChangeNotifier {
  bool get isAdsRemoved;
  bool get isAvailable;
  bool get isPurchaseInProgress;
  bool get isSupportedPlatform;
  ProductDetails? get removeAdsProduct;
  String? get localizedPrice;

  Future<void> init();
  Future<void> disposeService();
  Future<void> loadProducts();
  Future<PurchaseFeedback> buyRemoveAds();
  Future<PurchaseFeedback> restorePurchases({bool silent = false});
}

/// iOS StoreKit-backed purchase service. On Android/web this is a no-op
/// shell: ads stay on and purchase UI should stay hidden.
class PurchaseService extends PurchaseServiceBase {
  PurchaseService._();

  static final PurchaseService instance = PurchaseService._();

  InAppPurchase? _iap;
  StreamSubscription<List<PurchaseDetails>>? _subscription;
  ProductDetails? _removeAdsProduct;
  bool _isAdsRemoved = false;
  bool _isAvailable = false;
  bool _isPurchaseInProgress = false;
  bool _initialized = false;
  Completer<PurchaseFeedback>? _purchaseCompleter;
  Completer<PurchaseFeedback>? _restoreCompleter;
  bool _sawOwnedDuringRestore = false;

  InAppPurchase get _store {
    return _iap ??= InAppPurchase.instance;
  }

  @override
  bool get isAdsRemoved => _isAdsRemoved;

  @override
  bool get isAvailable => _isAvailable;

  @override
  bool get isPurchaseInProgress => _isPurchaseInProgress;

  @override
  bool get isSupportedPlatform =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.iOS;

  @override
  ProductDetails? get removeAdsProduct => _removeAdsProduct;

  @override
  String? get localizedPrice => _removeAdsProduct?.price;

  @override
  Future<void> init() async {
    if (_initialized) {
      return;
    }
    _initialized = true;

    // Local cache first so purchased users skip ads before the store answers.
    _isAdsRemoved = await SettingsService.getAdsRemoved();
    notifyListeners();

    if (!isSupportedPlatform) {
      return;
    }

    _subscription = _store.purchaseStream.listen(
      _onPurchaseUpdated,
      onError: (Object error) {
        print('Purchase stream error: $error');
        _finishPurchaseAttempt(PurchaseFeedback.failed);
      },
    );

    try {
      _isAvailable = await _store.isAvailable();
    } catch (error) {
      print('IAP availability check failed: $error');
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
      _removeAdsProduct = null;
      notifyListeners();
      return;
    }

    try {
      final response =
          await _store.queryProductDetails({kRemoveAdsProductId});
      if (response.error != null) {
        print('queryProductDetails error: ${response.error}');
      }
      _removeAdsProduct = response.productDetails
          .cast<ProductDetails?>()
          .firstWhere(
            (p) => p?.id == kRemoveAdsProductId,
            orElse: () => null,
          );
    } catch (error) {
      print('loadProducts failed: $error');
      _removeAdsProduct = null;
    }
    notifyListeners();
  }

  @override
  Future<PurchaseFeedback> buyRemoveAds() async {
    if (!isSupportedPlatform) {
      return PurchaseFeedback.unavailable;
    }
    if (!_isAvailable || _removeAdsProduct == null) {
      await loadProducts();
      if (!_isAvailable || _removeAdsProduct == null) {
        return PurchaseFeedback.unavailable;
      }
    }
    if (_isAdsRemoved) {
      return PurchaseFeedback.alreadyOwned;
    }
    if (_isPurchaseInProgress) {
      return PurchaseFeedback.pending;
    }

    _isPurchaseInProgress = true;
    notifyListeners();

    _purchaseCompleter = Completer<PurchaseFeedback>();
    final purchaseParam = PurchaseParam(productDetails: _removeAdsProduct!);

    try {
      final started =
          await _store.buyNonConsumable(purchaseParam: purchaseParam);
      if (!started) {
        _isPurchaseInProgress = false;
        notifyListeners();
        final result = PurchaseFeedback.failed;
        _purchaseCompleter?.complete(result);
        _purchaseCompleter = null;
        return result;
      }
    } catch (error) {
      print('buyRemoveAds failed: $error');
      _isPurchaseInProgress = false;
      notifyListeners();
      final result = PurchaseFeedback.failed;
      _purchaseCompleter?.complete(result);
      _purchaseCompleter = null;
      return result;
    }

    return _purchaseCompleter!.future;
  }

  @override
  Future<PurchaseFeedback> restorePurchases({bool silent = false}) async {
    if (!isSupportedPlatform) {
      return PurchaseFeedback.unavailable;
    }
    if (!_isAvailable) {
      return PurchaseFeedback.unavailable;
    }

    if (!silent) {
      _isPurchaseInProgress = true;
      notifyListeners();
    }

    _sawOwnedDuringRestore = false;
    _restoreCompleter = Completer<PurchaseFeedback>();

    try {
      await _store.restorePurchases();
    } catch (error) {
      print('restorePurchases failed: $error');
      if (!silent) {
        _isPurchaseInProgress = false;
        notifyListeners();
      }
      final result = PurchaseFeedback.failed;
      _restoreCompleter?.complete(result);
      _restoreCompleter = null;
      return result;
    }

    // StoreKit may deliver restores asynchronously; give the stream a moment.
    Future<void>.delayed(const Duration(seconds: 2), () {
      if (_restoreCompleter != null && !_restoreCompleter!.isCompleted) {
        final result = _sawOwnedDuringRestore || _isAdsRemoved
            ? PurchaseFeedback.restoreSuccess
            : PurchaseFeedback.restoreNothing;
        _finishRestoreAttempt(result, silent: silent);
      }
    });

    return _restoreCompleter!.future;
  }

  Future<void> _onPurchaseUpdated(List<PurchaseDetails> purchases) async {
    for (final purchase in purchases) {
      if (purchase.productID != kRemoveAdsProductId) {
        if (purchase.pendingCompletePurchase) {
          await _store.completePurchase(purchase);
        }
        continue;
      }

      switch (purchase.status) {
        case PurchaseStatus.purchased:
        case PurchaseStatus.restored:
          await _grantEntitlement();
          if (purchase.status == PurchaseStatus.restored) {
            _sawOwnedDuringRestore = true;
          }
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
          // Ask to Buy / approval — keep ads suppressed during purchase.
          notifyListeners();
          break;
        case PurchaseStatus.error:
          if (purchase.pendingCompletePurchase) {
            await _store.completePurchase(purchase);
          }
          final code = purchase.error?.code ?? '';
          final message = purchase.error?.message ?? '';
          final cancelled = code == 'purchase_canceled' ||
              code == 'storekit2_purchase_cancelled' ||
              message.toLowerCase().contains('cancel');
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
    if (_restoreCompleter != null &&
        !_restoreCompleter!.isCompleted &&
        _sawOwnedDuringRestore) {
      _finishRestoreAttempt(PurchaseFeedback.restoreSuccess);
    }
  }

  Future<void> _grantEntitlement() async {
    if (_isAdsRemoved) {
      return;
    }
    _isAdsRemoved = true;
    await SettingsService.setAdsRemoved(true);
    notifyListeners();
  }

  /// Test-only: set entitlement without talking to the store.
  @visibleForTesting
  Future<void> debugSetAdsRemoved(bool value) async {
    _isAdsRemoved = value;
    await SettingsService.setAdsRemoved(value);
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
    if (_purchaseCompleter != null && !_purchaseCompleter!.isCompleted) {
      _purchaseCompleter!.complete(result);
    }
    _purchaseCompleter = null;
    notifyListeners();
  }

  void _finishRestoreAttempt(PurchaseFeedback result, {bool silent = false}) {
    if (!silent) {
      _isPurchaseInProgress = false;
    }
    if (_restoreCompleter != null && !_restoreCompleter!.isCompleted) {
      _restoreCompleter!.complete(result);
    }
    _restoreCompleter = null;
    notifyListeners();
  }
}

/// Convenience: whether ads should run (platform-agnostic).
bool get shouldShowAds {
  if (kIsWeb) {
    return false;
  }
  return !PurchaseService.instance.isAdsRemoved;
}

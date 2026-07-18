import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'ads_ids_debug.dart';
import 'ads_ids_release.dart';
import 'purchase_service.dart';

class AdsManager {
  static bool disableAllAdsForScreenshot = false;
  static bool _mobileAdsInitialized = false;

  /// Whether any ads should initialize, load, or show.
  static bool get adsEnabled => !disableAllAdsForScreenshot && shouldShowAds;

  static bool get mobileAdsInitialized => _mobileAdsInitialized;

  static void markMobileAdsInitialized() {
    _mobileAdsInitialized = true;
  }

  static TargetPlatform get _targetPlatform => defaultTargetPlatform;

  static String get bannerAdUnitId {
    if (!adsEnabled) {
      return "";
    }
    if (_targetPlatform == TargetPlatform.android) {
      return kDebugMode
          ? AdsIdsDebug.bannerAdUnitIdAndroid
          : AdsIdsRelease.bannerAdUnitIdAndroid;
    } else if (_targetPlatform == TargetPlatform.iOS) {
      return kDebugMode
          ? AdsIdsDebug.bannerAdUnitIdIOS
          : AdsIdsRelease.bannerAdUnitIdIOS;
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get openAdUnitID {
    if (!adsEnabled) {
      return "";
    }
    if (_targetPlatform == TargetPlatform.android) {
      return kDebugMode
          ? AdsIdsDebug.openAdUnitIdAndroid
          : AdsIdsRelease.openAdUnitIdAndroid;
    } else if (_targetPlatform == TargetPlatform.iOS) {
      return kDebugMode
          ? AdsIdsDebug.openAdUnitIdIOS
          : AdsIdsRelease.openAdUnitIdIOS;
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get rewardedAdUnitId {
    if (_targetPlatform == TargetPlatform.android) {
      if (kDebugMode) {
        return AdsIdsDebug.rewardedAdUnitIdAndroid;
      }
      final id = AdsIdsRelease.rewardedAdUnitIdAndroid;
      return id.isEmpty ? AdsIdsDebug.rewardedAdUnitIdAndroid : id;
    } else if (_targetPlatform == TargetPlatform.iOS) {
      if (kDebugMode) {
        return AdsIdsDebug.rewardedAdUnitIdIOS;
      }
      final id = AdsIdsRelease.rewardedAdUnitIdIOS;
      return id.isEmpty ? AdsIdsDebug.rewardedAdUnitIdIOS : id;
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static void debugPrintID() {
    print("bannerAdUnitId: ${AdsManager.bannerAdUnitId}");
    // print("openAdUnitID: ${AdsManager.openAdUnitID}");
  }
}

/// Loads and shows a rewarded ad. If ads are removed via IAP, grants the
/// reward immediately without showing an ad.
class RewardedAdHelper {
  RewardedAd? _ad;
  Completer<bool>? _loadCompleter;
  bool _showing = false;

  bool get isReady => _ad != null;

  /// True when the user can earn rewards without watching an ad.
  static bool get grantsWithoutAd =>
      !AdsManager.adsEnabled || PurchaseService.instance.isAdsRemoved;

  Future<bool> load({Duration timeout = const Duration(seconds: 12)}) async {
    if (grantsWithoutAd) {
      return true;
    }
    if (_ad != null) {
      return true;
    }
    if (_loadCompleter != null) {
      return _loadCompleter!.future.timeout(timeout, onTimeout: () => false);
    }

    final adUnitId = AdsManager.rewardedAdUnitId;
    if (adUnitId.isEmpty) {
      return false;
    }

    final completer = Completer<bool>();
    _loadCompleter = completer;

    try {
      await RewardedAd.load(
        adUnitId: adUnitId,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (ad) {
            _ad = ad;
            _loadCompleter = null;
            if (!completer.isCompleted) {
              completer.complete(true);
            }
          },
          onAdFailedToLoad: (error) {
            print('RewardedAd failed to load: $error');
            _loadCompleter = null;
            if (!completer.isCompleted) {
              completer.complete(false);
            }
          },
        ),
      );
    } catch (error) {
      print('RewardedAd load threw: $error');
      _loadCompleter = null;
      if (!completer.isCompleted) {
        completer.complete(false);
      }
    }

    return completer.future.timeout(timeout, onTimeout: () {
      _loadCompleter = null;
      return false;
    });
  }

  /// Returns true when the user earned the reward (or ads are removed).
  Future<bool> show({required VoidCallback onUserEarnedReward}) async {
    if (grantsWithoutAd) {
      onUserEarnedReward();
      return true;
    }
    if (_showing) {
      return false;
    }

    final ready = _ad != null || await load();
    final ad = _ad;
    if (!ready || ad == null) {
      return false;
    }

    _showing = true;
    final completer = Completer<bool>();
    var earned = false;

    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        _ad = null;
        _showing = false;
        load();
        if (!completer.isCompleted) {
          completer.complete(earned);
        }
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        print('RewardedAd failed to show: $error');
        ad.dispose();
        _ad = null;
        _showing = false;
        load();
        if (!completer.isCompleted) {
          completer.complete(false);
        }
      },
    );

    try {
      await ad.show(
        onUserEarnedReward: (ad, reward) {
          earned = true;
          onUserEarnedReward();
        },
      );
    } catch (error) {
      print('RewardedAd show threw: $error');
      ad.dispose();
      _ad = null;
      _showing = false;
      load();
      return false;
    }

    _ad = null;
    return completer.future;
  }

  void dispose() {
    _ad?.dispose();
    _ad = null;
    _showing = false;
    if (_loadCompleter != null && !_loadCompleter!.isCompleted) {
      _loadCompleter!.complete(false);
    }
    _loadCompleter = null;
  }
}

class AppOpenAdManager {
  AppOpenAd? _appOpenAd;
  bool _isShowingAd = false;
  bool _isLoadingAd = false;
  bool _showWhenLoaded = false;
  int _loadRequestId = 0;

  /// Maximum duration allowed between loading and showing the ad.
  final Duration maxCacheDuration = Duration(hours: 4);

  /// Keep track of load time so we don't show an expired ad.
  DateTime? _appOpenLoadTime;

  /// Load an AppOpenAd.
  void loadAd() {
    if (!AdsManager.adsEnabled) {
      dispose();
      return;
    }
    if (_appOpenAd != null || _isLoadingAd) {
      return;
    }
    final adUnitId = AdsManager.openAdUnitID;
    if (adUnitId.isEmpty) {
      return;
    }
    _isLoadingAd = true;
    final requestId = ++_loadRequestId;
    unawaited(
      AppOpenAd.load(
        adUnitId: adUnitId,
        request: AdRequest(),
        adLoadCallback: AppOpenAdLoadCallback(
          onAdLoaded: (ad) {
            if (requestId != _loadRequestId || !AdsManager.adsEnabled) {
              ad.dispose();
              return;
            }
            _isLoadingAd = false;
            print('$ad loaded');
            _appOpenLoadTime = DateTime.now();
            _appOpenAd = ad;
            if (_showWhenLoaded) {
              _showWhenLoaded = false;
              showAdIfAvailable();
            }
          },
          onAdFailedToLoad: (error) {
            if (requestId != _loadRequestId) {
              return;
            }
            _isLoadingAd = false;
            _showWhenLoaded = false;
            print('AppOpenAd failed to load: $error');
          },
        ),
      ).catchError((Object error) {
        if (requestId == _loadRequestId) {
          _isLoadingAd = false;
          _showWhenLoaded = false;
        }
        print('AppOpenAd load threw: $error');
      }),
    );
  }

  /// Whether an ad is available to be shown.
  bool get isAdAvailable {
    return _appOpenAd != null;
  }

  @visibleForTesting
  bool get hasPendingShow => _showWhenLoaded;

  void showAdIfAvailable() {
    if (!AdsManager.adsEnabled) {
      dispose();
      return;
    }
    // Don't interrupt an in-progress purchase with an app-open ad.
    if (PurchaseService.instance.isPurchaseInProgress) {
      _showWhenLoaded = false;
      print('Skipping app open ad while purchase is in progress.');
      return;
    }
    if (!isAdAvailable) {
      print('Tried to show ad before available.');
      _showWhenLoaded = true;
      loadAd();
      return;
    }
    if (_isShowingAd) {
      print('Tried to show ad while already showing an ad.');
      return;
    }
    if (_appOpenLoadTime != null &&
        DateTime.now().subtract(maxCacheDuration).isAfter(_appOpenLoadTime!)) {
      print('Maximum cache duration exceeded. Loading another ad.');
      _appOpenAd?.dispose();
      _appOpenAd = null;
      _appOpenLoadTime = null;
      _showWhenLoaded = true;
      loadAd();
      return;
    }

    // Set the fullScreenContentCallback and show the ad.
    _appOpenAd?.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {
        _isShowingAd = true;
        print('$ad onAdShowedFullScreenContent');
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        _isShowingAd = false;
        ad.dispose();
        _appOpenAd = null;
        _appOpenLoadTime = null;
        loadAd();
      },
      onAdDismissedFullScreenContent: (ad) {
        print('$ad onAdDismissedFullScreenContent');
        _isShowingAd = false;
        ad.dispose();
        _appOpenAd = null;
        _appOpenLoadTime = null;
        loadAd();
      },
    );
    _appOpenAd?.show();
  }

  /// Prevent a delayed load callback from showing after the app was sent back
  /// to the background.
  void cancelPendingShow() {
    _showWhenLoaded = false;
  }

  void dispose() {
    _loadRequestId++;
    _appOpenAd?.dispose();
    _appOpenAd = null;
    _appOpenLoadTime = null;
    _isLoadingAd = false;
    _isShowingAd = false;
    _showWhenLoaded = false;
  }
}

/// Listens for app foreground events and shows app open ads.
class AppLifecycleReactor extends WidgetsBindingObserver {
  final AppOpenAdManager appOpenAdManager;
  bool _isListening = false;
  bool _wasInBackground = false;

  AppLifecycleReactor({required this.appOpenAdManager});

  void listenToAppStateChanges() {
    if (!AdsManager.adsEnabled || _isListening) {
      return;
    }
    WidgetsBinding.instance.addObserver(this);
    _isListening = true;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
      case AppLifecycleState.hidden:
      case AppLifecycleState.detached:
        _wasInBackground = true;
        appOpenAdManager.cancelPendingShow();
        break;
      case AppLifecycleState.resumed:
        if (_wasInBackground && AdsManager.adsEnabled) {
          _wasInBackground = false;
          appOpenAdManager.showAdIfAvailable();
        }
        break;
      case AppLifecycleState.inactive:
        // Transient interruptions and full-screen ads can make the app
        // inactive without actually backgrounding it.
        break;
    }
  }

  void dispose() {
    if (_isListening) {
      WidgetsBinding.instance.removeObserver(this);
      _isListening = false;
    }
    _wasInBackground = false;
    appOpenAdManager.cancelPendingShow();
  }
}

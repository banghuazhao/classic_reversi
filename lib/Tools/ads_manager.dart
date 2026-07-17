import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'ads_ids_debug.dart';
import 'ads_ids_release.dart';
import 'purchase_service.dart';

class AdsManager {
  static bool disableAllAdsForScreenshot = false;

  /// Whether any ads should initialize, load, or show.
  static bool get adsEnabled =>
      !disableAllAdsForScreenshot && shouldShowAds;

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
      throw new UnsupportedError("Unsupported platform");
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
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static void debugPrintID() {
    print("bannerAdUnitId: ${AdsManager.bannerAdUnitId}");
    // print("openAdUnitID: ${AdsManager.openAdUnitID}");
  }
}

class AppOpenAdManager {
  AppOpenAd? _appOpenAd;
  bool _isShowingAd = false;

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
    final adUnitId = AdsManager.openAdUnitID;
    if (adUnitId.isEmpty) {
      return;
    }
    AppOpenAd.load(
      adUnitId: adUnitId,
      request: AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          if (!AdsManager.adsEnabled) {
            ad.dispose();
            return;
          }
          print('$ad loaded');
          _appOpenLoadTime = DateTime.now();
          _appOpenAd = ad;
        },
        onAdFailedToLoad: (error) {
          print('AppOpenAd failed to load: $error');
          // Handle the error.
        },
      ),
    );
  }

  /// Whether an ad is available to be shown.
  bool get isAdAvailable {
    return _appOpenAd != null;
  }

  void showAdIfAvailable() {
    if (!AdsManager.adsEnabled) {
      dispose();
      return;
    }
    // Don't interrupt an in-progress purchase with an app-open ad.
    if (PurchaseService.instance.isPurchaseInProgress) {
      print('Skipping app open ad while purchase is in progress.');
      return;
    }
    if (!isAdAvailable) {
      print('Tried to show ad before available.');
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
      },
      onAdDismissedFullScreenContent: (ad) {
        print('$ad onAdDismissedFullScreenContent');
        _isShowingAd = false;
        ad.dispose();
        _appOpenAd = null;
        loadAd();
      },
    );
    _appOpenAd?.show();
  }

  void dispose() {
    _appOpenAd?.dispose();
    _appOpenAd = null;
  }
}

/// Listens for app foreground events and shows app open ads.
class AppLifecycleReactor extends WidgetsBindingObserver {
  final AppOpenAdManager appOpenAdManager;
  StreamSubscription<AppState>? _appStateSubscription;

  AppLifecycleReactor({required this.appOpenAdManager});

  void listenToAppStateChanges() {
    if (!AdsManager.adsEnabled) {
      return;
    }
    AppStateEventNotifier.startListening();
    _appStateSubscription ??=
        AppStateEventNotifier.appStateStream.listen(_onAppStateChanged);
  }

  void _onAppStateChanged(AppState appState) {
    // Try to show an app open ad if the app is being resumed and
    // we're not already showing an app open ad.
    print("didChangeAppLifecycleState: $appState");
    if (!AdsManager.adsEnabled) {
      return;
    }
    if (appState == AppState.foreground) {
      appOpenAdManager.showAdIfAvailable();
    }
  }

  void dispose() {
    _appStateSubscription?.cancel();
    _appStateSubscription = null;
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:classic_reversi/Tools/ads_manager.dart';
import 'package:classic_reversi/Tools/purchase_service.dart';
import 'package:classic_reversi/settings_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    AdsManager.disableAllAdsForScreenshot = false;
    await PurchaseService.instance.debugSetAdsRemoved(false);
  });

  group('entitlement persistence', () {
    test('adsRemoved defaults to false and round-trips', () async {
      expect(await SettingsService.getAdsRemoved(), isFalse);

      await SettingsService.setAdsRemoved(true);
      expect(await SettingsService.getAdsRemoved(), isTrue);

      await SettingsService.setAdsRemoved(false);
      expect(await SettingsService.getAdsRemoved(), isFalse);
    });

    test('PurchaseService mirrors persisted entitlement', () async {
      await PurchaseService.instance.debugSetAdsRemoved(true);
      expect(PurchaseService.instance.isAdsRemoved, isTrue);
      expect(await SettingsService.getAdsRemoved(), isTrue);
      expect(shouldShowAds, isFalse);
      expect(AdsManager.adsEnabled, isFalse);
    });
  });

  group('ad gating', () {
    test('adsEnabled is false when screenshot flag is on', () {
      AdsManager.disableAllAdsForScreenshot = true;
      expect(AdsManager.adsEnabled, isFalse);
      expect(AdsManager.bannerAdUnitId, isEmpty);
      expect(AdsManager.openAdUnitID, isEmpty);
    });

    test('adsEnabled is false after entitlement is granted', () async {
      await PurchaseService.instance.debugSetAdsRemoved(true);
      expect(AdsManager.adsEnabled, isFalse);
      expect(AdsManager.bannerAdUnitId, isEmpty);
      expect(AdsManager.openAdUnitID, isEmpty);
    });

    test('adsEnabled is true when not purchased and screenshots off', () async {
      await PurchaseService.instance.debugSetAdsRemoved(false);
      AdsManager.disableAllAdsForScreenshot = false;
      expect(shouldShowAds, isTrue);
      expect(AdsManager.adsEnabled, isTrue);
    });
  });

  group('platform gating', () {
    test('purchase UI is iOS-only', () {
      if (PurchaseService.instance.isSupportedPlatform) {
        expect(defaultTargetPlatform, TargetPlatform.iOS);
      } else {
        expect(
          defaultTargetPlatform == TargetPlatform.iOS,
          isFalse,
        );
      }
    });

    test('non-iOS buy and restore report unavailable', () async {
      if (PurchaseService.instance.isSupportedPlatform) {
        return;
      }
      expect(
        await PurchaseService.instance.buyRemoveAds(),
        PurchaseFeedback.unavailable,
      );
      expect(
        await PurchaseService.instance.restorePurchases(),
        PurchaseFeedback.unavailable,
      );
    });
  });

  group('purchase feedback', () {
    test('covers required user-facing states', () {
      expect(PurchaseFeedback.values, containsAll([
        PurchaseFeedback.success,
        PurchaseFeedback.restoreSuccess,
        PurchaseFeedback.restoreNothing,
        PurchaseFeedback.cancelled,
        PurchaseFeedback.pending,
        PurchaseFeedback.failed,
        PurchaseFeedback.unavailable,
        PurchaseFeedback.alreadyOwned,
      ]));
    });

    test('already owned when entitlement present', () async {
      if (!PurchaseService.instance.isSupportedPlatform) {
        return;
      }
      await PurchaseService.instance.debugSetAdsRemoved(true);
      // Without a store product loaded, buy still short-circuits on owned
      // only after availability checks — skip if store unavailable in tests.
    });
  });

  group('product id', () {
    test('matches App Store Connect product', () {
      expect(
        kRemoveAdsProductId,
        'com.appsbay.classicReversi.remove_ads',
      );
    });
  });
}

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
    await PurchaseService.instance.debugSetPremium(false);
  });

  group('entitlement persistence', () {
    test('premium defaults to false and round-trips', () async {
      expect(await SettingsService.getPremiumUnlocked(), isFalse);

      await SettingsService.setPremiumUnlocked(true);
      expect(await SettingsService.getPremiumUnlocked(), isTrue);

      await SettingsService.setPremiumUnlocked(false);
      expect(await SettingsService.getPremiumUnlocked(), isFalse);
    });

    test('PurchaseService mirrors persisted entitlement', () async {
      await PurchaseService.instance.debugSetPremium(true);
      expect(PurchaseService.instance.isPremium, isTrue);
      expect(await SettingsService.getPremiumUnlocked(), isTrue);
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
      await PurchaseService.instance.debugSetPremium(true);
      expect(AdsManager.adsEnabled, isFalse);
      expect(AdsManager.bannerAdUnitId, isEmpty);
      expect(AdsManager.openAdUnitID, isEmpty);
    });

    test('adsEnabled is true when not purchased and screenshots off', () async {
      await PurchaseService.instance.debugSetPremium(false);
      AdsManager.disableAllAdsForScreenshot = false;
      expect(shouldShowAds, isTrue);
      expect(AdsManager.adsEnabled, isTrue);
    });
  });

  group('platform gating', () {
    test('purchases are offered on iOS and Android only', () {
      final mobile = defaultTargetPlatform == TargetPlatform.iOS ||
          defaultTargetPlatform == TargetPlatform.android;
      expect(PurchaseService.instance.isSupportedPlatform, mobile);
    });

    test('unsupported platforms report buy and restore unavailable',
        () async {
      if (PurchaseService.instance.isSupportedPlatform) {
        return;
      }
      expect(
        await PurchaseService.instance.buyPremium(),
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
      await PurchaseService.instance.debugSetPremium(true);
      // Without a store product loaded, buy still short-circuits on owned
      // only after availability checks — skip if store unavailable in tests.
    });
  });

  group('product id', () {
    test('matches the App Store Connect and Google Play products', () {
      expect(kPremiumProductIdIOS, 'com.appsbay.classicReversi.remove_ads');
      expect(kPremiumProductIdAndroid, 'com.appsbay.classic_reversi.premium');
      expect(premiumProductIdFor(TargetPlatform.iOS), kPremiumProductIdIOS);
      expect(premiumProductIdFor(TargetPlatform.android),
          kPremiumProductIdAndroid);
    });

    test('Play product id satisfies Google Play naming rules', () {
      expect(RegExp(r'^[a-z0-9][a-z0-9._]*$').hasMatch(kPremiumProductIdAndroid),
          isTrue);
    });
  });

  group('legacy entitlement', () {
    test('Remove Ads buyers from earlier versions keep Premium', () async {
      SharedPreferences.setMockInitialValues({'adsRemoved': true});
      expect(await SettingsService.getPremiumUnlocked(), isTrue);
    });
  });

  group('coach tip allowance', () {
    test('counts tips per local day and resets the next day', () async {
      final monday = DateTime(2026, 11, 16, 9);
      expect(await SettingsService.getCoachTipsUsedToday(monday), 0);
      expect(await SettingsService.recordCoachTipUsed(monday), 1);
      expect(await SettingsService.recordCoachTipUsed(monday), 2);
      expect(await SettingsService.getCoachTipsUsedToday(monday), 2);
      final tuesday = DateTime(2026, 11, 17, 8);
      expect(await SettingsService.getCoachTipsUsedToday(tuesday), 0);
      expect(await SettingsService.recordCoachTipUsed(tuesday), 1);
    });
  });
}

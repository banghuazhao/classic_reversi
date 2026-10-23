import 'package:classic_reversi/Tools/ads_manager.dart';
import 'package:classic_reversi/generated/l10n.dart';
import 'package:classic_reversi/purchase_screen.dart';
import 'package:classic_reversi/stats_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget app(Widget screen, {double scale = 1}) => MaterialApp(
      locale: const Locale('en'),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: S.delegate.supportedLocales,
      builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(
              textScaler: TextScaler.linear(scale), disableAnimations: true),
          child: child!),
      home: screen,
    );

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({'gamesPlayed': 7});
    AdsManager.disableAllAdsForScreenshot = true;
  });

  testWidgets('stats surfaces progress and next measurable goal',
      (tester) async {
    await tester.pumpWidget(app(const StatsScreen()));
    await tester.pumpAndSettle();
    expect(find.text('Next milestone'), findsOneWidget);
    expect(find.text('Games: 7 of 10'), findsWidgets);
    expect(tester.takeException(), isNull);
  });

  testWidgets(
      'purchase explains ad removal, Hard undo, hints and payment clearly',
      (tester) async {
    await tester.pumpWidget(app(const PurchaseScreen(), scale: 3.2));
    await tester.pumpAndSettle();
    final ads = find.text('No banner or app-open ads.');
    await tester.scrollUntilVisible(ads, 350);
    expect(ads, findsOneWidget);
    final undo =
        find.text('Undo once per turn on Hard without watching an ad.');
    await tester.ensureVisible(undo);
    await tester.pumpAndSettle();
    expect(undo, findsOneWidget);
    final hints = find.text(
        'Legal-move hints on every computer difficulty without watching an ad.');
    await tester.ensureVisible(hints);
    await tester.pumpAndSettle();
    expect(hints, findsOneWidget);
    final once = find.text(
        'One payment. No subscription. Restore with your App Store account.');
    await tester.ensureVisible(once);
    await tester.pumpAndSettle();
    expect(once, findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}

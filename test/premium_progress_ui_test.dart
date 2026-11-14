import 'package:classic_reversi/Tools/ads_manager.dart';
import 'package:classic_reversi/generated/l10n.dart';
import 'package:classic_reversi/premium_screen.dart';
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

  testWidgets('premium explains every benefit and the one-time payment',
      (tester) async {
    await tester.pumpWidget(app(const PremiumScreen(), scale: 3.2));
    await tester.pumpAndSettle();
    for (final text in [
      'Ad-free play',
      'No banner, app-open, or rewarded ads.',
      'Unlimited undo',
      'Unlimited coach tips',
      'Legal-move hints everywhere',
      'Expert opponent',
      'Full game analysis',
      'Exclusive board themes',
    ]) {
      final finder = find.text(text);
      await tester.scrollUntilVisible(finder, 300,
          scrollable: find.byType(Scrollable).first);
      await tester.pumpAndSettle();
      expect(finder, findsOneWidget, reason: text);
    }
    expect(tester.takeException(), isNull);
  });
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:classic_reversi/Tools/ads_manager.dart';
import 'package:classic_reversi/Tools/purchase_service.dart';
import 'package:classic_reversi/app_theme.dart';
import 'package:classic_reversi/feedback_service.dart';
import 'package:classic_reversi/game_board.dart';
import 'package:classic_reversi/game_model.dart';
import 'package:classic_reversi/game_review_screen.dart';
import 'package:classic_reversi/game_settings.dart';
import 'package:classic_reversi/generated/l10n.dart';
import 'package:classic_reversi/main.dart';
import 'package:classic_reversi/premium_screen.dart';
import 'package:classic_reversi/settings_service.dart';
import 'package:classic_reversi/start_screen.dart';
import 'package:classic_reversi/strategy_coach.dart';
import 'package:classic_reversi/theme_controller.dart';

Widget _localized(Widget home) => MaterialApp(
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      locale: const Locale('en'),
      home: home,
    );

const _friendSettings =
    GameSettings(difficulty: Difficulty.easy, twoPlayerMode: true);

List<GameModel> _fullGame() {
  final history = [GameModel.initial()];
  while (!history.last.gameIsOver) {
    final model = history.last;
    final move = model.board.getMovesForPlayer(model.player).first;
    history.add(model.updateForMove(move.x, move.y)!);
  }
  return history;
}

/// Lets isolate work (coach analysis) finish under the fake test clock.
Future<void> _settleIsolates(WidgetTester tester, bool Function() done) async {
  for (var attempt = 0; attempt < 200 && !done(); attempt++) {
    await tester
        .runAsync(() => Future<void>.delayed(const Duration(milliseconds: 20)));
    await tester.pump();
  }
  await tester.pumpAndSettle();
}

Finder _tipButton() => find.byWidgetPredicate((widget) =>
    widget is Tooltip && (widget.message ?? '').startsWith('Coach tip'));

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({
      'soundEnabled': false,
      'hapticsEnabled': false,
      'reduceMotion': true,
    });
    AdsManager.disableAllAdsForScreenshot = true;
    await PurchaseService.instance.debugSetPremium(false);
    await FeedbackService.instance.setSoundEnabled(false);
    await FeedbackService.instance.setHapticsEnabled(false);
    await FeedbackService.instance.setReduceMotion(true);
    final messenger =
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
    messenger.setMockMethodCallHandler(
        const MethodChannel('xyz.luan/audioplayers'), (_) async => null);
    messenger.setMockMethodCallHandler(
        const MethodChannel('xyz.luan/audioplayers.global'),
        (_) async => null);
  });

  tearDown(() async {
    await PurchaseService.instance.debugSetPremium(false);
  });

  group('game analysis', () {
    test('report agrees with the turning point and counts every decision',
        () async {
      final history = _fullGame();
      final analysis =
          await StrategyCoach.analyzeGame(history, player: PieceType.black);
      final point = await StrategyCoach.findTurningPoint(history,
          player: PieceType.black);
      expect(analysis.turningPoint?.index, point?.index);
      expect(analysis.players.keys, [PieceType.black]);
      final black = analysis.players[PieceType.black]!;
      expect(black.moves, greaterThan(0));
      expect(black.accuracy, inInclusiveRange(0, 100));
      expect(analysis.keyMoments.length, lessThanOrEqualTo(3));
      for (final moment in analysis.keyMoments) {
        expect(moment.player, PieceType.black);
        expect(moment.quality,
            anyOf(MoveQuality.inaccuracy, MoveQuality.mistake));
      }
      final indexes = analysis.keyMoments.map((m) => m.index).toList();
      expect(indexes, [...indexes]..sort());
    });

    test('quality thresholds classify score gaps', () {
      expect(StrategyCoach.qualityFor(500, sameMove: true), MoveQuality.best);
      expect(StrategyCoach.qualityFor(0, sameMove: false), MoveQuality.best);
      expect(StrategyCoach.qualityFor(StrategyCoach.goodGap, sameMove: false),
          MoveQuality.good);
      expect(
          StrategyCoach.qualityFor(StrategyCoach.inaccuracyGap,
              sameMove: false),
          MoveQuality.inaccuracy);
      expect(
          StrategyCoach.qualityFor(StrategyCoach.inaccuracyGap + 1,
              sameMove: false),
          MoveQuality.mistake);
    });

    testWidgets('review offers analysis as a Premium unlock', (tester) async {
      await tester.pumpWidget(_localized(GameReviewScreen(
        history: _fullGame(),
        gameAnalyzer: (history, {player}) async =>
            GameAnalysis(players: const {}, keyMoments: const [], turningPoint: null),
      )));
      await _settleIsolates(
          tester,
          () => find
              .text('Looking for a useful position to explore…')
              .evaluate()
              .isEmpty);
      final unlock = find.byKey(const ValueKey('analysis-unlock'));
      await tester.ensureVisible(unlock);
      expect(unlock, findsOneWidget);
      await tester.tap(unlock);
      await tester.pumpAndSettle();
      expect(find.byType(PremiumScreen), findsOneWidget);
    });

    testWidgets('Premium review shows accuracy and jumps to key moments',
        (tester) async {
      await PurchaseService.instance.debugSetPremium(true);
      final history = _fullGame();
      final moment = MoveAssessment(
        index: 4,
        player: PieceType.black,
        played: const Position(0, 0),
        suggested: const Position(1, 1),
        gap: 300,
        quality: MoveQuality.mistake,
      );
      await tester.pumpWidget(_localized(GameReviewScreen(
        history: history,
        settings: const GameSettings(
            difficulty: Difficulty.hard, twoPlayerMode: false),
        positionAnalyzer: (_) async => null,
        gameAnalyzer: (history, {player}) async => GameAnalysis(
          players: {
            PieceType.black: const PlayerAccuracy(
                player: PieceType.black,
                best: 8,
                good: 2,
                inaccuracies: 1,
                mistakes: 1),
          },
          keyMoments: [moment],
          turningPoint: null,
        ),
      )));
      await tester.pumpAndSettle();
      expect(find.text('Game analysis'), findsOneWidget);
      expect(find.text('86%'), findsOneWidget);
      expect(find.text('You · Black'), findsOneWidget);
      final row = find.byKey(const ValueKey('analysis-moment-4'));
      await tester.ensureVisible(row);
      expect(find.text('Move 5: A1 played, B2 was stronger'), findsOneWidget);
      await tester.tap(row);
      await tester.pumpAndSettle();
      expect(find.text('Move 4 of ${history.length - 1}'), findsWidgets);
    });
  });

  group('themes', () {
    test('Premium themes need Premium and fall back to Classic without it',
        () async {
      final themes = ThemeController.instance;
      await themes.setTheme(BoardThemeId.classic);
      expect(await themes.setTheme(BoardThemeId.royal), isFalse);
      expect(themes.themeId, BoardThemeId.classic);

      await PurchaseService.instance.debugSetPremium(true);
      expect(await themes.setTheme(BoardThemeId.royal), isTrue);
      expect(themes.themeId, BoardThemeId.royal);
      expect(await SettingsService.getBoardTheme(), BoardThemeId.royal);

      await PurchaseService.instance.debugSetPremium(false);
      expect(themes.themeId, BoardThemeId.classic);
      await PurchaseService.instance.debugSetPremium(true);
      expect(themes.themeId, BoardThemeId.royal);
      await themes.setTheme(BoardThemeId.classic);
    });
  });

  group('Expert difficulty', () {
    testWidgets('setup locks Expert without Premium and opens Premium',
        (tester) async {
      await tester.pumpWidget(_localized(const StartScreen()));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Play'));
      await tester.pumpAndSettle();
      final expert = find.text('Expert');
      await tester.ensureVisible(expert);
      expect(expert, findsOneWidget);
      await tester.tap(expert);
      await tester.pumpAndSettle();
      expect(find.byType(PremiumScreen), findsOneWidget);
    });

    testWidgets('Premium players can choose Expert', (tester) async {
      await PurchaseService.instance.debugSetPremium(true);
      await tester.pumpWidget(_localized(const StartScreen()));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Play'));
      await tester.pumpAndSettle();
      await tester.ensureVisible(find.text('Expert'));
      await tester.tap(find.text('Expert'));
      await tester.pumpAndSettle();
      expect(find.byType(PremiumScreen), findsNothing);
      expect(find.text(S.current.ExpertSetupNote), findsOneWidget);
    });
  });

  group('undo', () {
    testWidgets('free players get one undo per turn', (tester) async {
      await tester.pumpWidget(
          _localized(const GameScreen(settings: _friendSettings)));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('cell-4-2')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('cell-3-2')));
      await tester.pumpAndSettle();
      await tester.tap(find.byTooltip('Undo'));
      await tester.pumpAndSettle();
      final undo = tester.widget<ElevatedButton>(find.descendant(
          of: find.byTooltip('Undo'), matching: find.byType(ElevatedButton)));
      expect(undo.onPressed, isNull);
    });

    testWidgets('Premium players can step back through every move',
        (tester) async {
      await PurchaseService.instance.debugSetPremium(true);
      await tester.pumpWidget(
          _localized(const GameScreen(settings: _friendSettings)));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('cell-4-2')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('cell-3-2')));
      await tester.pumpAndSettle();
      final undo = find.byTooltip('Undo · unlimited');
      await tester.tap(undo);
      await tester.pumpAndSettle();
      await tester.tap(undo);
      await tester.pumpAndSettle();
      // Back to the opening: two discs each.
      expect(find.text('2'), findsNWidgets(2));
    });
  });

  group('coach tips', () {
    testWidgets('free tips mark a legal square and count down',
        (tester) async {
      await tester.pumpWidget(
          _localized(const GameScreen(settings: _friendSettings)));
      await tester.pumpAndSettle();
      expect(find.byTooltip('Coach tip · 3 free today'), findsOneWidget);
      await tester.tap(_tipButton());
      await _settleIsolates(
          tester,
          () => find
              .byWidgetPredicate((widget) =>
                  widget.key is ValueKey<String> &&
                  (widget.key as ValueKey<String>)
                      .value
                      .startsWith('coach-tip-'))
              .evaluate()
              .isNotEmpty);
      expect(
          find.byWidgetPredicate((widget) =>
              widget.key is ValueKey<String> &&
              (widget.key as ValueKey<String>).value.startsWith('coach-tip-')),
          findsOneWidget);
      expect(find.textContaining('Coach tip: try'), findsOneWidget);
      expect(find.byTooltip('Coach tip · 2 free today'), findsOneWidget);
      expect(await tester.runAsync(SettingsService.getCoachTipsUsedToday), 1);
    });

    testWidgets('after the daily allowance a tip offers an ad or Premium',
        (tester) async {
      SharedPreferences.setMockInitialValues({
        'reduceMotion': true,
        'coachTipsDate': SettingsService.todayKey(),
        'coachTipsUsed': kFreeDailyCoachTips,
      });
      await tester.pumpWidget(
          _localized(const GameScreen(settings: _friendSettings)));
      await tester.pumpAndSettle();
      expect(find.byTooltip('Coach tip · watch an ad'), findsOneWidget);
      await tester.tap(_tipButton());
      await tester.pumpAndSettle();
      expect(find.text("Today's free tips are used"), findsOneWidget);
      await tester.tap(find.text('Go Premium'));
      await tester.pumpAndSettle();
      expect(find.byType(PremiumScreen), findsOneWidget);
    });

    testWidgets('Premium tips are unlimited and do not use the allowance',
        (tester) async {
      await PurchaseService.instance.debugSetPremium(true);
      await tester.pumpWidget(
          _localized(const GameScreen(settings: _friendSettings)));
      await tester.pumpAndSettle();
      expect(find.byTooltip('Coach tip'), findsOneWidget);
      await tester.tap(_tipButton());
      await _settleIsolates(tester,
          () => find.textContaining('Coach tip: try').evaluate().isNotEmpty);
      expect(find.textContaining('Coach tip: try'), findsOneWidget);
      expect(await tester.runAsync(SettingsService.getCoachTipsUsedToday), 0);
    });
  });

  group('board', () {
    test('Premium themes are complete palettes', () {
      for (final id in BoardThemeId.values) {
        final palette = AppTheme.forId(id);
        expect(palette.pieceGradients.keys,
            containsAll(PieceType.values), reason: id.name);
      }
      expect(BoardThemeId.royal.requiresPremium, isTrue);
      expect(BoardThemeId.ember.requiresPremium, isTrue);
      expect(BoardThemeId.classic.requiresPremium, isFalse);
    });
  });
}

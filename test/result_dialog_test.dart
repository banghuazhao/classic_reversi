import 'package:classic_reversi/achievements_service.dart';
import 'package:classic_reversi/app_theme.dart';
import 'package:classic_reversi/game_model.dart';
import 'package:classic_reversi/game_over_sheet.dart';
import 'package:classic_reversi/game_settings.dart';
import 'package:classic_reversi/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

GameModel _finishedGame() {
  var model = GameModel.initial(boardSize: 6);
  while (!model.gameIsOver) {
    final move = model.board.getMovesForPlayer(model.player).first;
    model = model.updateForMove(move.x, move.y)!;
  }
  return model;
}

void main() {
  testWidgets('the final score is announced while its visual count animates',
      (tester) async {
    final semantics = tester.ensureSemantics();
    final model = _finishedGame();
    await tester.pumpWidget(MaterialApp(
      locale: const Locale('en'),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      home: Builder(
          builder: (context) => Scaffold(
                body: TextButton(
                  child: const Text('Open'),
                  onPressed: () => showGameOverSheet(
                    context: context,
                    model: model,
                    settings: const GameSettings(
                        difficulty: Difficulty.superEasy, twoPlayerMode: false),
                    theme: AppTheme.classic,
                    newAchievements: const [],
                    reduceMotion: false,
                    feedbackScale: 1,
                    celebrateWin: false,
                    onRematch: () {},
                    onHome: () {},
                    onReview: () {},
                  ),
                ),
              )),
    ));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Open'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 250));
    expect(
        find.bySemanticsLabel(
            'Black ${model.blackScore}  ·  White ${model.whiteScore}'),
        findsOneWidget);
    expect(tester.takeException(), isNull);
    await tester.pumpAndSettle();
    await tester.pumpWidget(const SizedBox());
    await tester.pumpAndSettle();
    semantics.dispose();
  });

  for (final scenario in [
    (size: const Size(320, 568), locale: const Locale('en'), scale: 3.2),
    (size: const Size(568, 320), locale: const Locale('ru'), scale: 2.0),
    (size: const Size(375, 812), locale: const Locale('vi'), scale: 1.3),
    (size: const Size(1024, 768), locale: const Locale('ja'), scale: 3.2),
  ]) {
    testWidgets('result actions remain usable in $scenario', (tester) async {
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = scenario.size;
      addTearDown(tester.view.resetDevicePixelRatio);
      addTearDown(tester.view.resetPhysicalSize);
      var rematches = 0;
      final model = _finishedGame();
      await tester.pumpWidget(MaterialApp(
        locale: scenario.locale,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        builder: (context, child) => MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: TextScaler.linear(scenario.scale),
              padding: const EdgeInsets.only(top: 44, bottom: 34),
              disableAnimations: true,
            ),
            child: child!),
        home: Builder(
            builder: (context) => Scaffold(
                  body: TextButton(
                    child: const Text('Open'),
                    onPressed: () => showGameOverSheet(
                      context: context,
                      model: model,
                      settings: const GameSettings(
                          difficulty: Difficulty.superEasy,
                          twoPlayerMode: false),
                      theme: AppTheme.classic,
                      newAchievements: AchievementId.values,
                      reduceMotion: true,
                      feedbackScale: 1,
                      celebrateWin: true,
                      onRematch: () => rematches++,
                      onHome: () {},
                      onReview: () {},
                    ),
                  ),
                )),
      ));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      final rematch = find.text(S.current.Rematch);
      await tester.scrollUntilVisible(rematch, 250,
          scrollable: find.byType(Scrollable).last, maxScrolls: 60);
      await tester.pumpAndSettle();
      await tester.tap(rematch);
      await tester.pumpAndSettle();
      expect(rematches, 1);
      expect(find.text('Open'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }
}

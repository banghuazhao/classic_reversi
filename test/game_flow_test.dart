import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:classic_reversi/Tools/ads_manager.dart';
import 'package:classic_reversi/feedback_service.dart';
import 'package:classic_reversi/daily_challenge.dart';
import 'package:classic_reversi/game_board.dart';
import 'package:classic_reversi/game_materials.dart';
import 'package:classic_reversi/game_model.dart';
import 'package:classic_reversi/game_session.dart';
import 'package:classic_reversi/game_settings.dart';
import 'package:classic_reversi/generated/l10n.dart';
import 'package:classic_reversi/main.dart';
import 'package:classic_reversi/settings_screen.dart';

Widget localized(Widget home) => MaterialApp(
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

const friendSettings = GameSettings(
  difficulty: Difficulty.easy,
  twoPlayerMode: true,
);

Future<void> openSetup(WidgetTester tester) async {
  await tester.tap(find.text('Play'));
  await tester.pumpAndSettle();
}

Future<void> leaveForHome(WidgetTester tester) async {
  await tester.tap(find.byTooltip('Home'));
  await tester.pumpAndSettle();
}

// Persistence is scheduled from widget callbacks. Pump its microtasks before
// awaiting the queued operation in Flutter's fake asynchronous test clock.
Future<T> flushStorage<T>(WidgetTester tester, Future<T> operation) async {
  late T result;
  Object? failure;
  var complete = false;
  operation.then((value) {
    result = value;
    complete = true;
  }, onError: (Object error) {
    failure = error;
    complete = true;
  });
  await tester.pump();
  expect(complete, isTrue,
      reason: 'Storage operation should complete without a timer');
  if (failure != null) throw failure!;
  return result;
}

Future<GameSession?> loadSession(WidgetTester tester) =>
    flushStorage(tester, GameSessionService.load());

List<GameModel> fullGame() {
  final history = [GameModel.initial()];
  while (!history.last.gameIsOver) {
    final model = history.last;
    final move = model.board.getMovesForPlayer(model.player).first;
    history.add(model.updateForMove(move.x, move.y)!);
  }
  return history;
}

Position placedBetween(GameModel before, GameModel after) {
  for (var y = 0; y < before.board.size; y++) {
    for (var x = 0; x < before.board.size; x++) {
      if (before.board.rows[y][x] == PieceType.empty &&
          after.board.rows[y][x] != PieceType.empty) {
        return Position(x, y);
      }
    }
  }
  throw StateError('No move in history');
}

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({
      'soundEnabled': false,
      'hapticsEnabled': false,
      'reduceMotion': true,
    });
    AdsManager.disableAllAdsForScreenshot = true;
    await FeedbackService.instance.setSoundEnabled(false);
    await FeedbackService.instance.setHapticsEnabled(false);
    await FeedbackService.instance.setReduceMotion(true);
  });

  testWidgets('home reveals game options only when starting a game',
      (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();
    expect(find.text('Play'), findsOneWidget);
    expect(find.text('Difficulty'), findsNothing);
    await openSetup(tester);
    expect(find.text('Difficulty'), findsOneWidget);
    expect(find.text('Easy'), findsOneWidget);
    final friendMode = find.text('Play against a friend on this device');
    await tester.tap(friendMode);
    await tester.pumpAndSettle();
    expect(find.text('Difficulty'), findsNothing);
    await tester.tap(find.text('Computer'));
    await tester.pumpAndSettle();
    expect(find.text('Difficulty'), findsOneWidget);
  });

  testWidgets('play, Home, relaunch, Continue and Undo preserve the match',
      (tester) async {
    await tester
        .pumpWidget(localized(const GameScreen(settings: friendSettings)));
    await tester.pumpAndSettle();
    expect(find.text('2'), findsNWidgets(2));
    await tester.tap(find.byKey(const ValueKey('cell-4-2')));
    await tester.pumpAndSettle();
    var session = await loadSession(tester);
    expect(session!.model.blackScore, 4);
    expect(session.model.whiteScore, 1);
    expect(session.timeline, hasLength(2));
    await leaveForHome(tester);
    expect(find.text('Continue game'), findsOneWidget);

    // Discard the widget tree as a real process relaunch would.
    await tester.pumpWidget(const SizedBox());
    await tester.pumpAndSettle();
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();
    await tester.tap(find.text('Continue game'));
    await tester.pumpAndSettle();
    expect(find.text('4'), findsOneWidget);
    expect(find.text('1'), findsOneWidget);
    await tester.tap(find.byTooltip('Undo'));
    await tester.pumpAndSettle();
    expect(find.text('2'), findsNWidgets(2));
    session = await loadSession(tester);
    expect(session!.timeline, hasLength(1));
    expect(session.canUndo, isFalse);
  });

  testWidgets(
      'new game requires confirmation before replacing an unfinished board',
      (tester) async {
    final opening = GameModel.initial();
    final next = opening.updateForMove(4, 2)!;
    await flushStorage(
        tester,
        GameSessionService.save(GameSession(
          settings: friendSettings,
          timeline: [opening, next],
          undoHistory: [opening],
          canUndo: true,
          lastMove: const Position(4, 2),
        )));
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();
    await tester.tap(find.text('New game'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Start Game'));
    await tester.tap(find.text('Start Game'));
    await tester.pumpAndSettle();
    expect(find.text('Start a new game?'), findsOneWidget);
    await tester.tap(find.text('Keep playing'));
    await tester.pumpAndSettle();
    expect((await loadSession(tester))!.model.blackScore, 4);
    expect(find.text('Continue game'), findsOneWidget);
  });

  testWidgets(
      'restart confirmation protects progress and saves the new opening',
      (tester) async {
    await tester
        .pumpWidget(localized(const GameScreen(settings: friendSettings)));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('cell-4-2')));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Restart game'));
    await tester.pumpAndSettle();
    expect(find.text('Restart this game?'), findsOneWidget);
    await tester.tap(find.text('Keep playing'));
    await tester.pumpAndSettle();
    expect(find.text('4'), findsOneWidget);
    await tester.tap(find.byTooltip('Restart game'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(TextButton, 'Restart game'));
    await tester.pumpAndSettle();
    expect(find.text('2'), findsNWidgets(2));
    expect((await loadSession(tester))!.timeline, hasLength(1));
  });

  testWidgets('super easy uses a smaller board and readable player labels',
      (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();
    await openSetup(tester);
    await tester.tap(find.text('Super Easy'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Start Game'));
    await tester.tap(find.text('Start Game'));
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('cell-5-5')), findsOneWidget);
    expect(find.byKey(const ValueKey('cell-6-0')), findsNothing);
    expect(find.text('You · Black'), findsOneWidget);
    expect(find.text('Computer · White'), findsOneWidget);
    expect(find.text('Your turn'), findsOneWidget);
  });

  testWidgets('leaving while the computer thinks resumes exactly one reply',
      (tester) async {
    const settings =
        GameSettings(difficulty: Difficulty.easy, twoPlayerMode: false);
    await tester.pumpWidget(localized(const GameScreen(settings: settings)));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('cell-4-2')));
    await tester.pump();
    await tester.tap(find.byTooltip('Home'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 800));
    await tester.pumpAndSettle();
    var session = await loadSession(tester);
    expect(session!.model.player, PieceType.white);
    expect(session.timeline, hasLength(2));
    await tester.tap(find.text('Continue game'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 800));
    await tester.pumpAndSettle();
    session = await loadSession(tester);
    expect(session!.model.player, PieceType.black);
    expect(session.timeline, hasLength(3));
    expect(session.model.blackScore + session.model.whiteScore, 6);
  });

  testWidgets('the live board exposes coordinates and keyboard activation',
      (tester) async {
    final semantics = tester.ensureSemantics();
    await tester
        .pumpWidget(localized(const GameScreen(settings: friendSettings)));
    await tester.pumpAndSettle();
    expect(find.bySemanticsLabel('E3, Empty, Legal move'), findsOneWidget);
    final focus = tester.widget<Focus>(find
        .ancestor(of: find.byType(MaterialBoard), matching: find.byType(Focus))
        .first);
    focus.focusNode!.requestFocus();
    await tester.pump();
    for (var i = 0; i < 4; i++) {
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowRight);
    }
    for (var i = 0; i < 2; i++) {
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);
    }
    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    await tester.pumpAndSettle();
    expect((await loadSession(tester))!.model.blackScore, 4);
    semantics.dispose();
  });

  testWidgets('an automatic pass is explained and announced', (tester) async {
    final rows = List.generate(6, (_) => List.filled(6, PieceType.black));
    rows[0][0] = PieceType.empty;
    rows[0][1] = PieceType.white;
    rows[2][0] = PieceType.empty;
    rows[2][1] = PieceType.white;
    final before = GameModel(board: GameBoard.fromRows(rows));
    const move = Position(0, 0);
    await tester.pumpWidget(localized(GameScreen(
        settings: GameSettings(
      difficulty: Difficulty.easy,
      twoPlayerMode: true,
      initialBoard: before.board,
      initialPlayer: before.player,
    ))));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(ValueKey('cell-${move.x}-${move.y}')));
    await tester.pumpAndSettle();
    expect(find.textContaining('has no legal moves.'), findsOneWidget);
    expect((await loadSession(tester))!.model.player, before.player);
  });

  testWidgets(
      'completed game clears its save and opens replay above the result',
      (tester) async {
    final history = fullGame();
    final before = history[history.length - 2];
    final move = placedBetween(before, history.last);
    await tester.pumpWidget(localized(GameScreen(
        settings: GameSettings(
      difficulty: Difficulty.easy,
      twoPlayerMode: true,
      initialBoard: before.board,
      initialPlayer: before.player,
    ))));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(ValueKey('cell-${move.x}-${move.y}')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 250));
    await tester.pump(const Duration(milliseconds: 250));
    await tester.pumpAndSettle();
    expect(await loadSession(tester), isNull);
    await tester.tap(find.text('Review game'));
    await tester.pumpAndSettle();
    expect(find.text('Final position'), findsOneWidget);
    await tester.tap(find.byTooltip('Go to start'));
    await tester.pumpAndSettle();
    expect(find.text('Starting position'), findsOneWidget);
    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();
    expect(find.text('Rematch'), findsOneWidget);
    expect(await loadSession(tester), isNull);
  });

  testWidgets(
      'restarting a finished board cancels its pending result presentation',
      (tester) async {
    final history = fullGame();
    final before = history[history.length - 2];
    final move = placedBetween(before, history.last);
    await tester.pumpWidget(localized(GameScreen(
        settings: GameSettings(
      difficulty: Difficulty.easy,
      twoPlayerMode: true,
      initialBoard: before.board,
      initialPlayer: before.player,
    ))));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(ValueKey('cell-${move.x}-${move.y}')));
    await tester.pump();
    await tester.tap(find.byTooltip('Restart game'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 600));
    await tester.pumpAndSettle();
    expect(find.text('Rematch'), findsNothing);
    expect((await loadSession(tester))!.timeline, hasLength(1));
  });

  testWidgets(
      'opening review during celebration never covers it with a result dialog',
      (tester) async {
    final history = fullGame();
    final before = history[history.length - 2];
    final move = placedBetween(before, history.last);
    await tester.pumpWidget(localized(GameScreen(
        settings: GameSettings(
      difficulty: Difficulty.easy,
      twoPlayerMode: true,
      initialBoard: before.board,
      initialPlayer: before.player,
    ))));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(ValueKey('cell-${move.x}-${move.y}')));
    await tester.pump();
    await tester.tap(find.byTooltip('Review game'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pumpAndSettle();
    expect(find.text('Final position'), findsOneWidget);
    expect(find.text('Rematch'), findsNothing);
  });

  testWidgets('Continue revalidates an expired daily save cached by Home',
      (tester) async {
    final settings = DailyChallenge.settingsForToday();
    final model = GameModel.initial(
        board: settings.initialBoard, player: settings.initialPlayer);
    await flushStorage(
        tester,
        GameSessionService.save(GameSession(
          settings: settings,
          timeline: [model],
        )));
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();
    expect(find.text('Continue game'), findsOneWidget);
    await flushStorage(
        tester,
        GameSessionService.save(GameSession(
          settings: settings,
          timeline: [model],
          savedAt: DateTime.now().subtract(const Duration(days: 1)),
        )));
    await tester.tap(find.text('Continue game'));
    await tester.pumpAndSettle();
    expect(find.text('Play'), findsOneWidget);
    expect(find.text('Continue game'), findsNothing);
    expect(await loadSession(tester), isNull);
  });

  for (final size in [
    const Size(375, 667),
    const Size(812, 375),
    const Size(1024, 1366),
    const Size(375, 812),
  ]) {
    testWidgets('home, setup, settings and board fit $size with large text',
        (tester) async {
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = size;
      tester.platformDispatcher.textScaleFactorTestValue =
          size.height == 812 ? 3.2 : 2;
      addTearDown(tester.view.resetDevicePixelRatio);
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      await tester.ensureVisible(find.text('Play'));
      await openSetup(tester);
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(localized(const SettingsScreen()));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      await tester
          .pumpWidget(localized(const GameScreen(settings: friendSettings)));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    });
  }
}

import 'dart:async';

import 'package:classic_reversi/accessible_board.dart';
import 'package:classic_reversi/game_board.dart';
import 'package:classic_reversi/game_model.dart';
import 'package:classic_reversi/game_review_screen.dart';
import 'package:classic_reversi/game_settings.dart';
import 'package:classic_reversi/gameplay_activity.dart';
import 'package:classic_reversi/generated/l10n.dart';
import 'package:classic_reversi/strategy_coach.dart';
import 'package:classic_reversi/strategy_practice_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget _app(Widget child, {double scale = 1}) => MaterialApp(
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
      home: child,
    );

List<GameModel> _history() {
  final first = GameModel.initial(boardSize: 4);
  final move = first.board.getMovesForPlayer(first.player).first;
  final second = first.updateForMove(move.x, move.y)!;
  final reply = second.board.getMovesForPlayer(second.player).first;
  return [first, second, second.updateForMove(reply.x, reply.y)!];
}

Future<void> _tap(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

Future<void> _waitForCoach(WidgetTester tester) async {
  for (var attempt = 0; attempt < 100; attempt++) {
    if (find
        .text('Looking for a useful position to explore…')
        .evaluate()
        .isEmpty) {
      return;
    }
    await tester
        .runAsync(() => Future<void>.delayed(const Duration(milliseconds: 20)));
    await tester.pumpAndSettle();
  }
  fail('Coach analysis did not finish');
}

StrategyAdvice _facts(GameModel model, {bool last = false}) {
  final legal = model.board.getMovesForPlayer(model.player);
  final move = last ? legal.last : legal.first;
  final board = model.board.updateForMove(move.x, move.y, model.player);
  return StrategyAdvice(
      move: move,
      player: model.player,
      opponentReplies:
          board.getMovesForPlayer(getOpponent(model.player)).length,
      flippedCount: GameBoard.flippedPositions(model.board, board, move).length,
      reasons: const [StrategyReason.replies],
      score: 0);
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUp(() {
    SharedPreferences.setMockInitialValues({
      'activeGameSession': 'existing-active-match',
      'completedMatchLibrary': 'existing-library',
      'wins': 7,
      'gamesPlayed': 12,
    });
    final messenger =
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
    for (final name in [
      'xyz.luan/audioplayers.global',
      'xyz.luan/audioplayers.global/events'
    ]) {
      messenger.setMockMethodCallHandler(
          MethodChannel(name), (_) async => null);
    }
    messenger.setMockMethodCallHandler(
        const MethodChannel('xyz.luan/audioplayers'), (call) async {
      if (call.method == 'create') {
        final playerId = (call.arguments as Map)['playerId'];
        messenger.setMockMethodCallHandler(
            MethodChannel('xyz.luan/audioplayers/events/$playerId'),
            (_) async => null);
      }
      return null;
    });
  });

  testWidgets(
      'coordinate axes align with cells in practice and review at large text',
      (tester) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(320, 568);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);
    await tester.pumpWidget(_app(
        StrategyPracticeScreen(position: GameModel.initial(boardSize: 4)),
        scale: 2));
    await tester.pumpAndSettle();
    await _waitForCoach(tester);
    for (final x in [0, 3]) {
      final column = String.fromCharCode(65 + x);
      expect(
          tester.getCenter(find.byKey(ValueKey('board-column-$column'))).dx,
          closeTo(
              tester.getCenter(find.byKey(ValueKey('accessible-cell-$x-0'))).dx,
              0.01));
    }
    for (final y in [0, 3]) {
      expect(
          tester.getCenter(find.byKey(ValueKey('board-row-${y + 1}'))).dy,
          closeTo(
              tester.getCenter(find.byKey(ValueKey('accessible-cell-0-$y'))).dy,
              0.01));
    }
    expect(tester.takeException(), isNull);
    await tester
        .pumpWidget(_app(GameReviewScreen(history: _history()), scale: 2));
    await tester.pumpAndSettle();
    await _waitForCoach(tester);
    expect(find.byKey(const ValueKey('board-column-D')), findsOneWidget);
    expect(find.byKey(const ValueKey('board-row-4')), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets(
      'review suggests a position, jumps to it, and opens independent practice',
      (tester) async {
    final history = _history();
    await tester.pumpWidget(_app(GameReviewScreen(
        history: history,
        settings: const GameSettings(
            difficulty: Difficulty.easy, twoPlayerMode: false))));
    await tester.pumpAndSettle();
    await _waitForCoach(tester);
    expect(find.text('A position worth revisiting'), findsOneWidget);
    await _tap(tester, find.byKey(const ValueKey('coach-jump')));
    await _waitForCoach(tester);
    expect(tester.widget<Slider>(find.byType(Slider)).value, 0);
    expect(find.text('Ideas for Black'), findsOneWidget);
    await _tap(tester, find.byKey(const ValueKey('coach-practice')));
    await _waitForCoach(tester);
    expect(find.byType(StrategyPracticeScreen), findsOneWidget);
    expect(
        find.text('Practice is separate from your saved game and statistics.'),
        findsOneWidget);
    final board =
        tester.widget<AccessibleBoard>(find.byType(AccessibleBoard).last);
    expect(board.board.rows, history.first.board.rows);
    expect(board.legalMoves, isNotEmpty);
    await tester.pumpWidget(const SizedBox());
    await tester.pumpAndSettle();
    expect(GameplayActivity.isPlaying, isFalse);
  });

  testWidgets(
      'practice plays and resets without changing any saved game, library, or statistics',
      (tester) async {
    final position = GameModel.initial(boardSize: 4);
    await tester.pumpWidget(_app(StrategyPracticeScreen(position: position)));
    await tester.pumpAndSettle();
    await _waitForCoach(tester);
    final initial =
        tester.widget<AccessibleBoard>(find.byType(AccessibleBoard));
    final move = initial.legalMoves.first;
    await _tap(
        tester, find.byKey(ValueKey('accessible-cell-${move.x}-${move.y}')));
    await _waitForCoach(tester);
    final played = tester.widget<AccessibleBoard>(find.byType(AccessibleBoard));
    expect(played.board.getPieceAtLocation(move.x, move.y), PieceType.black);
    expect(played.legalMoves, isEmpty);
    expect(find.text('Discs flipped: 1'), findsOneWidget);
    await _tap(tester, find.byKey(const ValueKey('practice-reset')));
    await _waitForCoach(tester);
    expect(
        tester.widget<AccessibleBoard>(find.byType(AccessibleBoard)).board.rows,
        position.board.rows);
    final stored = await tester.runAsync(() async {
      final preferences = await SharedPreferences.getInstance();
      return {
        for (final key in preferences.getKeys()) key: preferences.get(key)
      };
    });
    expect(stored, {
      'activeGameSession': 'existing-active-match',
      'completedMatchLibrary': 'existing-library',
      'wins': 7,
      'gamesPlayed': 12,
    });
    expect(position.blackScore, 2);
    expect(position.whiteScore, 2);
  });

  testWidgets(
      'stale position analyses cannot replace advice after slider navigation or disposal',
      (tester) async {
    final requests = <Completer<StrategyAdvice?>>[];
    final history = _history();
    await tester.pumpWidget(_app(GameReviewScreen(
        history: history,
        positionAnalyzer: (model) {
          final request = Completer<StrategyAdvice?>();
          requests.add(request);
          return request.future;
        })));
    await tester.pumpAndSettle();
    await _waitForCoach(tester);
    final slider = tester.widget<Slider>(find.byType(Slider));
    slider.onChanged!(0);
    await tester.pumpAndSettle();
    expect(requests, isEmpty,
        reason:
            'Scrubbing should not spawn analysis for each intermediate move');
    tester.widget<Slider>(find.byType(Slider)).onChangeEnd!(0);
    await tester.pumpAndSettle();
    await _tap(tester, find.byKey(const ValueKey('review-next')));
    expect(requests, hasLength(2));
    final current = _facts(history[1]);
    requests[1].complete(current);
    await tester.pumpAndSettle();
    expect(
        find.text('Suggested move: ${StrategyCoach.coordinate(current.move)}'),
        findsOneWidget);
    requests[0].complete(_facts(history[0], last: true));
    await tester.pumpAndSettle();
    expect(
        find.text('Suggested move: ${StrategyCoach.coordinate(current.move)}'),
        findsOneWidget);
    await _tap(tester, find.byKey(const ValueKey('review-first')));
    expect(requests, hasLength(3));
    await tester.pumpWidget(const SizedBox());
    requests[2].complete(_facts(history[0]));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    expect(GameplayActivity.isPlaying, isFalse);
  });

  testWidgets(
      'practice terminal positions are noninteractive and handle large text',
      (tester) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(320, 568);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);
    final terminal = GameModel(
        board: GameBoard.fromRows(
            List.generate(4, (_) => List.filled(4, PieceType.black))),
        player: PieceType.empty);
    await tester
        .pumpWidget(_app(StrategyPracticeScreen(position: terminal), scale: 2));
    await tester.pumpAndSettle();
    await _waitForCoach(tester);
    expect(find.text('This side has no legal move in this position.'),
        findsOneWidget);
    expect(tester.widget<AccessibleBoard>(find.byType(AccessibleBoard)).onMove,
        isNull);
    expect(tester.takeException(), isNull);
  });
}

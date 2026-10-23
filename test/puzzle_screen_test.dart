import 'dart:async';

import 'package:classic_reversi/accessible_board.dart';
import 'package:classic_reversi/gameplay_activity.dart';
import 'package:classic_reversi/generated/l10n.dart';
import 'package:classic_reversi/puzzle_progress.dart';
import 'package:classic_reversi/puzzle_screen.dart';
import 'package:classic_reversi/puzzles.dart';
import 'package:classic_reversi/puzzles_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
// Simulate delayed and failing native preferences without a plugin process.
// ignore: depend_on_referenced_packages
import 'package:shared_preferences_platform_interface/shared_preferences_platform_interface.dart';

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues(
        {'activeGameSession': 'untouched', 'wins': 9});
    await PuzzleProgressService.loadCompletedIds();
  });

  testWidgets(
      'wrong attempts, graded hints, restart and success stay independent',
      (tester) async {
    final puzzle = curatedPuzzles.first;
    await tester.pumpWidget(_app(PuzzleScreen(puzzle: puzzle)));
    await tester.pumpAndSettle();
    expect(GameplayActivity.isPlaying, isTrue);
    final wrong = puzzle.initialModel.board
        .getMovesForPlayer(puzzle.player)
        .firstWhere((move) => !puzzle.solvesObjective(move));
    await _tapMove(tester, wrong.x, wrong.y);
    expect(find.text(S.current.PuzzleTryAgain), findsOneWidget);
    expect(await PuzzleProgressService.loadCompletedIds(), isEmpty);
    await tester.ensureVisible(find.byKey(const ValueKey('puzzle-restart')));
    await tester.tap(find.byKey(const ValueKey('puzzle-restart')));
    await tester.pumpAndSettle();
    for (var level = 1; level <= 3; level++) {
      await tester.ensureVisible(find.byKey(const ValueKey('puzzle-hint')));
      await tester.tap(find.byKey(const ValueKey('puzzle-hint')));
      await tester.pumpAndSettle();
      expect(find.text(S.current.PuzzleHint(level)), findsOneWidget);
    }
    expect(
        find.text(
            S.current.PuzzleHintCoordinate(puzzle.solutionCoordinates.first)),
        findsOneWidget);
    final solution = puzzle.solutions.first;
    await _tapMove(tester, solution.x, solution.y);
    expect(find.text(S.current.PuzzleCornerSuccess), findsOneWidget);
    expect(await PuzzleProgressService.loadCompletedIds(), {puzzle.id});
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.get('activeGameSession'), 'untouched');
    expect(prefs.get('wins'), 9);
    await tester.pumpWidget(const SizedBox.shrink());
    expect(GameplayActivity.isPlaying, isFalse);
  });

  testWidgets('losing endgame choice never completes the lesson',
      (tester) async {
    final puzzle =
        curatedPuzzles.firstWhere((p) => p.skill == PuzzleSkill.endgame);
    await tester.pumpWidget(_app(PuzzleScreen(puzzle: puzzle)));
    await tester.pumpAndSettle();
    final losing = puzzle.initialModel.board
        .getMovesForPlayer(puzzle.player)
        .firstWhere((move) => !puzzle.solvesObjective(move));
    await _tapMove(tester, losing.x, losing.y);
    expect(find.text(S.current.PuzzleEndgameTryAgain), findsOneWidget);
    expect(await PuzzleProgressService.loadCompletedIds(), isEmpty);
    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('endgame must be won through all best replies before completion',
      (tester) async {
    final puzzle = curatedPuzzles.last;
    final solver = ExactEndgameSolver();
    var model = puzzle.initialModel;
    await tester.pumpWidget(_app(PuzzleScreen(puzzle: puzzle)));
    await tester.pumpAndSettle();
    while (!model.gameIsOver) {
      final move = solver.bestMove(model, puzzle.player)!;
      expect(model.player, puzzle.player);
      await _tapMove(tester, move.x, move.y);
      model = model.updateForMove(move.x, move.y)!;
      while (!model.gameIsOver && model.player != puzzle.player) {
        final reply = solver.bestMove(model, puzzle.player)!;
        model = model.updateForMove(reply.x, reply.y)!;
      }
      final board =
          tester.widget<AccessibleBoard>(find.byType(AccessibleBoard));
      expect(board.board.rows, model.board.rows);
      if (!model.gameIsOver) {
        expect(await PuzzleProgressService.loadCompletedIds(), isEmpty);
      }
    }
    expect(find.text(S.current.PuzzleEndgameSuccess), findsOneWidget);
    expect(await PuzzleProgressService.loadCompletedIds(), {puzzle.id});
    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('archive searches skills and shows completed markers',
      (tester) async {
    await PuzzleProgressService.complete('corner-1');
    await tester.pumpWidget(_app(const PuzzlesScreen()));
    await tester.pumpAndSettle();
    expect(find.text(S.current.PuzzleProgress(1, 9)), findsOneWidget);
    await tester.ensureVisible(find.byKey(const ValueKey('puzzle-search')));
    await tester.enterText(
        find.byKey(const ValueKey('puzzle-search')), 'endgame');
    await tester.pumpAndSettle();
    expect(find.text(S.current.PuzzleCornerSkill), findsNothing);
    expect(find.text(S.current.PuzzleEndgameSkill), findsOneWidget);
    expect(find.text(S.current.PuzzleNumber(7)), findsOneWidget);
    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets(
      'a save failure from a restarted attempt cannot corrupt the new attempt',
      (tester) async {
    final store = _ControlledPuzzleStore();
    SharedPreferencesStorePlatform.instance = store;
    final puzzle = curatedPuzzles.first;
    final solution = puzzle.solutions.first;
    await tester.pumpWidget(_app(PuzzleScreen(puzzle: puzzle)));
    await tester.pumpAndSettle();
    await _tapMove(tester, solution.x, solution.y);
    expect(store.writes, hasLength(1));
    await tester.ensureVisible(find.byKey(const ValueKey('puzzle-restart')));
    await tester.tap(find.byKey(const ValueKey('puzzle-restart')));
    await tester.pumpAndSettle();
    store.writes.first.complete(false);
    await tester.pumpAndSettle();
    expect(find.text(S.current.PuzzleCompletionSaveFailed), findsNothing);
    expect(find.byKey(const ValueKey('puzzle-next')), findsNothing);
    final board = tester.widget<AccessibleBoard>(find.byType(AccessibleBoard));
    expect(board.board.rows, puzzle.initialModel.board.rows);

    await _tapMove(tester, solution.x, solution.y);
    expect(store.writes, hasLength(2));
    expect(
        tester
            .widget<ElevatedButton>(find.byKey(const ValueKey('puzzle-next')))
            .onPressed,
        isNull);
    store.writes.last.complete(true);
    await tester.pumpAndSettle();
    expect(
        tester
            .widget<ElevatedButton>(find.byKey(const ValueKey('puzzle-next')))
            .onPressed,
        isNotNull);
    expect(find.text(S.current.PuzzleCompletionSaveFailed), findsNothing);
    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets(
      'failed progress loads show retry instead of an empty progress count',
      (tester) async {
    final store = _ReadFailurePuzzleStore()..failReads = true;
    SharedPreferences.resetStatic();
    SharedPreferencesStorePlatform.instance = store;
    await tester.pumpWidget(_app(const PuzzlesScreen()));
    await tester.pumpAndSettle();
    expect(find.text(S.current.PuzzleProgressLoadFailed), findsOneWidget);
    expect(find.text(S.current.PuzzleProgress(0, 9)), findsNothing);
    store.failReads = false;
    await tester
        .ensureVisible(find.byKey(const ValueKey('puzzle-progress-retry')));
    await tester.tap(find.byKey(const ValueKey('puzzle-progress-retry')));
    await tester.pumpAndSettle();
    expect(find.text(S.current.PuzzleProgressLoadFailed), findsNothing);
    expect(await PuzzleProgressService.loadCompletedIds(), {'corner-1'});
    // ensureVisible aligned the retry button near the top. The shorter
    // successful card can then sit outside the lazy list's built region.
    await tester.drag(find.byType(ListView), const Offset(0, 600));
    await tester.pumpAndSettle();
    expect(find.text(S.current.PuzzleProgress(1, 9)), findsOneWidget);
    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('puzzle coordinates stay aligned on narrow screens',
      (tester) async {
    tester.view.physicalSize = const Size(320, 568);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(
        _app(PuzzleScreen(puzzle: curatedPuzzles.first), textScale: 2));
    await tester.pumpAndSettle();
    for (final x in [0, 5]) {
      final column = String.fromCharCode(65 + x);
      expect(
          tester.getCenter(find.byKey(ValueKey('board-column-$column'))).dx,
          closeTo(
              tester.getCenter(find.byKey(ValueKey('accessible-cell-$x-0'))).dx,
              0.01));
    }
    for (final y in [0, 5]) {
      expect(
          tester.getCenter(find.byKey(ValueKey('board-row-${y + 1}'))).dy,
          closeTo(
              tester.getCenter(find.byKey(ValueKey('accessible-cell-0-$y'))).dy,
              0.01));
    }
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('small and landscape screens support 320 percent text',
      (tester) async {
    for (final size in [const Size(375, 812), const Size(812, 375)]) {
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1;
      await tester.pumpWidget(
          _app(PuzzleScreen(puzzle: curatedPuzzles.first), textScale: 3.2));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      expect(find.byKey(const ValueKey('puzzle-objective')), findsOneWidget);
      expect(
          find.text(S.current.PuzzleCornerObjective(
              S.current.Black, curatedPuzzles.first.targetCorner!)),
          findsOneWidget);
      await tester.ensureVisible(find.byKey(const ValueKey('puzzle-hint')));
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox.shrink());
    }
    tester.view.resetPhysicalSize();
    tester.view.resetDevicePixelRatio();
  });
}

Widget _app(Widget home, {double textScale = 1}) => MaterialApp(
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      locale: const Locale('en'),
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaler: TextScaler.linear(textScale),
          disableAnimations: true,
        ),
        child: child!,
      ),
      home: home,
    );

Future<void> _tapMove(WidgetTester tester, int x, int y) async {
  final cell = find.byKey(ValueKey('accessible-cell-$x-$y'));
  await tester.ensureVisible(cell);
  await tester.tap(cell);
  await tester.pumpAndSettle();
}

class _ControlledPuzzleStore extends InMemorySharedPreferencesStore {
  _ControlledPuzzleStore()
      : super.withData({
          'flutter.activeGameSession': 'untouched',
          'flutter.wins': 9,
        });
  final writes = <Completer<bool>>[];

  @override
  Future<bool> setValue(String valueType, String key, Object value) async {
    final gate = Completer<bool>();
    writes.add(gate);
    if (!await gate.future) return false;
    return super.setValue(valueType, key, value);
  }
}

class _ReadFailurePuzzleStore extends InMemorySharedPreferencesStore {
  _ReadFailurePuzzleStore()
      : super.withData({
          'flutter.${PuzzleProgressService.storageKey}': ['corner-1'],
        });
  bool failReads = false;

  @override
  Future<Map<String, Object>> getAll() {
    if (failReads) throw StateError('Simulated read failure');
    return super.getAll();
  }
}

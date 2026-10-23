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

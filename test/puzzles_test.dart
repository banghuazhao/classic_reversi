import 'package:classic_reversi/game_board.dart';
import 'package:classic_reversi/game_model.dart';
import 'package:classic_reversi/puzzle_progress.dart';
import 'package:classic_reversi/puzzles.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
// Exercise the existing plugin's failed backend write contract.
// ignore: depend_on_referenced_packages
import 'package:shared_preferences_platform_interface/shared_preferences_platform_interface.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});

  group('curated positions', () {
    test('nine stable, ascending lessons cover all three skills', () {
      expect(curatedPuzzles, hasLength(9));
      expect(curatedPuzzles.map((p) => p.id).toSet(), hasLength(9));
      expect(curatedPuzzles.map((p) => p.number),
          orderedEquals(List.generate(9, (i) => i + 1)));
      for (final skill in PuzzleSkill.values) {
        expect(curatedPuzzles.where((p) => p.skill == skill), hasLength(3));
      }
      expect(
          curatedPuzzles
              .where((p) => p.skill == PuzzleSkill.endgame)
              .map((p) => p.initialModel.board.getPieceCount(PieceType.empty)),
          [3, 4, 6]);
    });

    for (final puzzle in curatedPuzzles) {
      test(
          '${puzzle.id} is an authentic position with exact verified solutions',
          () {
        var replay = GameModel.initial(boardSize: GameBoard.compactSize);
        for (final coordinate in puzzle.openingLine.split(' ')) {
          final move = puzzlePosition(coordinate);
          expect(
              replay.board.isLegalMove(move.x, move.y, replay.player), isTrue,
              reason: '${puzzle.id}: illegal provenance move $coordinate');
          replay = replay.updateForMove(move.x, move.y)!;
        }
        final initial = puzzle.initialModel;
        expect(initial.board.rows, replay.board.rows);
        expect(initial.player, replay.player);
        final legal = initial.board.getMovesForPlayer(initial.player);
        expect(legal.length, greaterThan(1));
        final verified =
            legal.where(puzzle.solvesObjective).map(puzzleCoordinate).toSet();
        expect(verified, puzzle.solutionCoordinates.toSet());
        expect(verified, isNotEmpty);
        expect(legal.any((move) => !puzzle.solvesObjective(move)), isTrue,
            reason: 'Every lesson must include an incorrect legal alternative');
        for (final solution in puzzle.solutions) {
          final next = initial.updateForMove(solution.x, solution.y)!;
          switch (puzzle.skill) {
            case PuzzleSkill.corner:
              expect(solution.x == 0 || solution.x == initial.board.size - 1,
                  isTrue);
              expect(solution.y == 0 || solution.y == initial.board.size - 1,
                  isTrue);
              expect(puzzleCoordinate(solution), puzzle.targetCorner);
            case PuzzleSkill.forcedPass:
              expect(next.player, initial.player);
              expect(next.gameIsOver, isFalse);
              expect(next.board.getMovesForPlayer(getOpponent(initial.player)),
                  isEmpty);
            case PuzzleSkill.endgame:
              expect(ExactEndgameSolver().score(next, initial.player),
                  greaterThan(0));
          }
        }
        expect(puzzle.solvesObjective(const Position(-1, 0)), isFalse);
      });
    }
  });

  group('exact endgame solver', () {
    test('verifies winning, drawing, and losing alternatives independently',
        () {
      final expected = [
        {'E1': -4, 'F1': 4, 'E5': 4},
        {'E4': -8, 'C6': 4, 'E6': -10, 'F6': -4},
        {'A1': 4, 'B1': 0, 'E3': 13},
      ];
      final puzzles =
          curatedPuzzles.where((p) => p.skill == PuzzleSkill.endgame).toList();
      for (var i = 0; i < puzzles.length; i++) {
        final puzzle = puzzles[i];
        final solver = ExactEndgameSolver();
        for (final entry in expected[i].entries) {
          final move = puzzlePosition(entry.key);
          expect(
              solver.score(puzzle.initialModel.updateForMove(move.x, move.y)!,
                  puzzle.player),
              entry.value);
        }
      }
    });

    test('normalizes forced passes and counts terminal discs', () {
      final puzzle =
          curatedPuzzles.where((p) => p.skill == PuzzleSkill.forcedPass).last;
      final move = puzzle.solutions.first;
      final after = puzzle.initialModel.updateForMove(move.x, move.y)!;
      final passed =
          GameModel(board: after.board, player: getOpponent(after.player));
      final solver = ExactEndgameSolver();
      expect(passed.board.getMovesForPlayer(passed.player), isEmpty);
      expect(solver.score(passed, puzzle.player),
          solver.score(after, puzzle.player));
      final terminal = GameModel(
        board: GameBoard.fromRows(
            List.generate(4, (_) => List.filled(4, PieceType.black))),
        player: PieceType.empty,
      );
      expect(solver.score(terminal, PieceType.black), 16);
      expect(solver.score(terminal, PieceType.white), -16);
      expect(solver.bestMove(terminal, PieceType.black), isNull);
    });

    test('strictly bounds full-game searches', () {
      expect(
          () =>
              ExactEndgameSolver().score(GameModel.initial(), PieceType.black),
          throwsArgumentError);
    });

    test('optimal replies lead each winning exercise to a terminal win', () {
      for (final puzzle
          in curatedPuzzles.where((p) => p.skill == PuzzleSkill.endgame)) {
        final solver = ExactEndgameSolver();
        var model = puzzle.initialModel;
        var moves = 0;
        while (!model.gameIsOver) {
          final move = solver.bestMove(model, puzzle.player)!;
          model = model.updateForMove(move.x, move.y)!;
          expect(++moves, lessThanOrEqualTo(6));
        }
        expect(solver.score(model, puzzle.player), greaterThan(0));
      }
    });
  });

  group('independent progress', () {
    setUp(() async {
      await PuzzleProgressService.loadCompletedIds();
      SharedPreferences.setMockInitialValues(
          {'activeGameSession': 'untouched', 'wins': 17});
    });

    test('concurrent completion is idempotent and preserves match data',
        () async {
      final results = await Future.wait([
        PuzzleProgressService.complete('corner-1'),
        PuzzleProgressService.complete('corner-1'),
        PuzzleProgressService.complete('pass-1'),
      ]);
      expect(results, [true, false, true]);
      final completed = await PuzzleProgressService.loadCompletedIds();
      expect(completed, {'corner-1', 'pass-1'});
      expect(() => completed.add('endgame-1'), throwsUnsupportedError);
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.get('activeGameSession'), 'untouched');
      expect(prefs.get('wins'), 17);
    });

    for (final throwsFromPlatform in [false, true]) {
      test(
          'failed completion (${throwsFromPlatform ? 'exception' : 'false'}) '
          'rolls back cache and retries the backend without manual reload',
          () async {
        final store = _FailingPuzzlePreferencesStore();
        SharedPreferencesStorePlatform.instance = store;
        expect(await PuzzleProgressService.complete('corner-1'), isTrue);
        store.failWrites = true;
        store.throwOnFailure = throwsFromPlatform;

        await expectLater(
            PuzzleProgressService.complete('corner-2'), throwsStateError);
        expect(await PuzzleProgressService.loadCompletedIds(), {'corner-1'});
        expect(store.writeAttempts, 2);

        // A second attempt must try the backend again, rather than mistake
        // the rejected cache entry for a completed puzzle.
        await expectLater(
            PuzzleProgressService.complete('corner-2'), throwsStateError);
        expect(store.writeAttempts, 3);
        expect(await PuzzleProgressService.loadCompletedIds(), {'corner-1'});

        store.failWrites = false;
        expect(await PuzzleProgressService.complete('corner-2'), isTrue);
        expect(store.writeAttempts, 4);
        expect(await PuzzleProgressService.complete('corner-2'), isFalse);
        expect(store.writeAttempts, 4);
        expect(await PuzzleProgressService.loadCompletedIds(),
            {'corner-1', 'corner-2'});
        final backend = await store.getAll();
        expect(backend['flutter.${PuzzleProgressService.storageKey}'],
            ['corner-1', 'corner-2']);
        expect(backend['flutter.activeGameSession'], 'untouched');
        expect(backend['flutter.wins'], 17);
      });
    }

    test('unknown IDs and malformed persisted data cannot inflate progress',
        () async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(PuzzleProgressService.storageKey,
          ['corner-1', 'corner-1', 'unknown', 'endgame-3']);
      expect(await PuzzleProgressService.loadCompletedIds(),
          {'corner-1', 'endgame-3'});
      await prefs.setInt(PuzzleProgressService.storageKey, 123);
      expect(await PuzzleProgressService.loadCompletedIds(), isEmpty);
      await expectLater(
          PuzzleProgressService.complete('unknown'), throwsArgumentError);
      expect(await PuzzleProgressService.complete('corner-2'), isTrue);
      expect(await PuzzleProgressService.loadCompletedIds(), {'corner-2'});
    });
  });
}

class _FailingPuzzlePreferencesStore extends InMemorySharedPreferencesStore {
  _FailingPuzzlePreferencesStore()
      : super.withData({
          'flutter.activeGameSession': 'untouched',
          'flutter.wins': 17,
        });

  bool failWrites = false;
  bool throwOnFailure = false;
  int writeAttempts = 0;

  @override
  Future<bool> setValue(String valueType, String key, Object value) async {
    writeAttempts++;
    if (failWrites) {
      if (throwOnFailure) throw StateError('Simulated platform write failure');
      return false;
    }
    return super.setValue(valueType, key, value);
  }
}

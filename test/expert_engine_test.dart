import 'dart:math';

import 'package:classic_reversi/expert_engine.dart';
import 'package:classic_reversi/game_board.dart';
import 'package:classic_reversi/game_board_scorer.dart';
import 'package:classic_reversi/game_model.dart';
import 'package:classic_reversi/move_finder.dart';
import 'package:classic_reversi/puzzles.dart';
import 'package:flutter_test/flutter_test.dart';

/// Plays [moves] random legal plies from the opening, following passes.
GameModel _randomPosition(Random random, int moves) {
  var model = GameModel.initial();
  for (var i = 0; i < moves && !model.gameIsOver; i++) {
    final legal = model.board.getMovesForPlayer(model.player);
    final move = legal[random.nextInt(legal.length)];
    model = model.updateForMove(move.x, move.y)!;
  }
  return model;
}

bool _contains(List<Position> moves, Position move) =>
    moves.any((m) => m.x == move.x && m.y == move.y);

/// The full-width minimax Hard used before alpha-beta pruning was added.
ScoredMove? _referenceSearch(GameBoard board, PieceType scoringPlayer,
    PieceType player, int pliesRemaining) {
  final moves = board.getMovesForPlayer(player);
  if (moves.isEmpty) return null;
  ScoredMove? best;
  for (final move in moves) {
    final next = board.updateForMove(move.x, move.y, player);
    int score;
    if (pliesRemaining > 0 &&
        next.getMovesForPlayer(getOpponent(player)).isNotEmpty) {
      score = _referenceSearch(next, scoringPlayer, getOpponent(player),
                  pliesRemaining - 1)
              ?.score ??
          0;
    } else if (pliesRemaining > 0 &&
        next.getMovesForPlayer(player).isNotEmpty) {
      score =
          _referenceSearch(next, scoringPlayer, player, pliesRemaining - 1)
                  ?.score ??
              0;
    } else {
      score = GameBoardScorer(next).getScore(scoringPlayer);
    }
    if (best == null ||
        (score > best.score && scoringPlayer == player) ||
        (score < best.score && scoringPlayer != player)) {
      best = ScoredMove(score, move);
    }
  }
  return best;
}

void main() {
  test('expert search always returns a legal move', () {
    final random = Random(7);
    for (var sample = 0; sample < 25; sample++) {
      final model = _randomPosition(random, random.nextInt(50));
      if (model.gameIsOver) continue;
      final result = searchExpertMove(ExpertSearchRequest(
        board: model.board,
        player: model.player,
        budget: const Duration(milliseconds: 60),
        seed: sample,
      ));
      expect(result, isNotNull);
      expect(
          _contains(model.board.getMovesForPlayer(model.player), result!.move),
          isTrue,
          reason: 'sample $sample');
    }
  });

  test('expert respects its time budget in the opening', () {
    final clock = Stopwatch()..start();
    final result = searchExpertMove(ExpertSearchRequest(
      board: GameModel.initial().board,
      player: PieceType.black,
      budget: const Duration(milliseconds: 200),
    ));
    clock.stop();
    expect(result, isNotNull);
    expect(result!.depth, greaterThanOrEqualTo(1));
    // Generous slack for slow CI machines; the search checks the clock often.
    expect(clock.elapsedMilliseconds, lessThan(1500));
  });

  test('expert evaluation values an available corner', () {
    // Black to move can capture the A1 corner (0,0) along the diagonal.
    final rows = List.generate(8, (_) => List.filled(8, PieceType.empty));
    rows[1][1] = PieceType.white;
    rows[2][2] = PieceType.white;
    rows[3][3] = PieceType.black;
    rows[3][4] = PieceType.white;
    rows[4][3] = PieceType.white;
    rows[4][4] = PieceType.black;
    final board = GameBoard.fromRows(rows);
    expect(board.isLegalMove(0, 0, PieceType.black), isTrue);
    // Deeper searches may delay the corner because it cannot be taken
    // away here; a shallow search shows the evaluation itself prefers it.
    final result = searchExpertMove(ExpertSearchRequest(
      board: board,
      player: PieceType.black,
      budget: const Duration(milliseconds: 300),
      maxDepth: 2,
    ));
    expect(result!.move.x, 0);
    expect(result.move.y, 0);
  });

  test('expert endgames are exact and never throw away a forced win', () {
    final random = Random(11);
    var checked = 0;
    for (var sample = 0; sample < 400 && checked < 12; sample++) {
      final model = _randomPosition(random, 56 + random.nextInt(4));
      if (model.gameIsOver ||
          model.board.getPieceCount(PieceType.empty) >
              ExactEndgameSolver.maxEmptyCells) {
        continue;
      }
      final solver = ExactEndgameSolver();
      final legal = model.board.getMovesForPlayer(model.player);
      final best = legal
          .map((move) =>
              solver.score(model.updateForMove(move.x, move.y)!, model.player))
          .reduce(max);
      final result = searchExpertMove(ExpertSearchRequest(
        board: model.board,
        player: model.player,
        budget: const Duration(seconds: 5),
      ))!;
      if (legal.length > 1) expect(result.exact, isTrue);
      final chosen = solver.score(
          model.updateForMove(result.move.x, result.move.y)!, model.player);
      expect(chosen.sign, best.sign, reason: 'sample $sample');
      checked++;
    }
    expect(checked, greaterThan(5));
  });

  test('alpha-beta Hard chooses exactly what full minimax chooses', () async {
    final random = Random(3);
    for (var sample = 0; sample < 12; sample++) {
      final model = _randomPosition(random, 4 + random.nextInt(40));
      if (model.gameIsOver) continue;
      for (final plies in [2, 3]) {
        final expected = _referenceSearch(
                model.board, model.player, model.player, plies - 1)!
            .move;
        final actual =
            await MoveFinder(model.board).findNextMove(model.player, plies);
        expect('${actual!.x},${actual.y}', '${expected.x},${expected.y}',
            reason: 'sample $sample, $plies plies');
      }
    }
  });
}

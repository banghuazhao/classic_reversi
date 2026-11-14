// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';

import 'expert_engine.dart';
import 'game_board.dart';
import 'game_board_scorer.dart';
import 'game_settings.dart';

class MoveSearchArgs {
  MoveSearchArgs(
      {required this.board, required this.player, required this.numPlies});

  final GameBoard board;
  final PieceType player;
  final int numPlies;
}

/// A move and its score. Used by the minimax algorithm.
class ScoredMove {
  final int score;
  final Position move;

  const ScoredMove(this.score, this.move);
}

// The [compute] function requires a top-level method as its first argument.
// This is that method for [MoveFinder].
Position? _findNextMove(MoveSearchArgs args) {
  final bestMove = _performSearchPly(
    args.board,
    args.player,
    args.player,
    args.numPlies - 1,
    GameBoardScorer.minScore - 1,
    GameBoardScorer.maxScore + 1,
  );
  return bestMove?.move;
}

// Minimax (https://wikipedia.org/wiki/Minimax) with alpha-beta pruning.
// Pruning only skips lines that cannot change the result, and the root keeps
// the first move with the best exact score, so Hard chooses exactly the same
// moves as the original full-width search while visiting far fewer boards.
// [alpha] and [beta] bound the score from [scoringPlayer]'s point of view.
ScoredMove? _performSearchPly(
  GameBoard board,
  PieceType scoringPlayer,
  PieceType player,
  int pliesRemaining,
  int alpha,
  int beta,
) {
  final availableMoves = board.getMovesForPlayer(player);

  if (availableMoves.isEmpty) {
    return null;
  }

  final maximizing = scoringPlayer == player;
  ScoredMove? bestMove;

  for (var i = 0; i < availableMoves.length; i++) {
    final newBoard =
        board.updateForMove(availableMoves[i].x, availableMoves[i].y, player);
    int score;
    if (pliesRemaining > 0 &&
        newBoard.getMovesForPlayer(getOpponent(player)).isNotEmpty) {
      // Opponent has next turn.
      score = _performSearchPly(
            newBoard,
            scoringPlayer,
            getOpponent(player),
            pliesRemaining - 1,
            alpha,
            beta,
          )?.score ??
          0;
    } else if (pliesRemaining > 0 &&
        newBoard.getMovesForPlayer(player).isNotEmpty) {
      // Opponent has no moves; player gets another turn.
      score = _performSearchPly(
            newBoard,
            scoringPlayer,
            player,
            pliesRemaining - 1,
            alpha,
            beta,
          )?.score ??
          0;
    } else {
      // Game is over or the search has reached maximum depth.
      score = GameBoardScorer(newBoard).getScore(scoringPlayer);
    }

    if (bestMove == null ||
        (score > bestMove.score && maximizing) ||
        (score < bestMove.score && !maximizing)) {
      bestMove =
          ScoredMove(score, Position(availableMoves[i].x, availableMoves[i].y));
    }
    if (maximizing) {
      if (score > alpha) alpha = score;
    } else {
      if (score < beta) beta = score;
    }
    if (alpha >= beta) break;
  }

  return bestMove;
}

/// The [MoveFinder] class exists to provide its [findNextMove] method, which
/// uses the minimax algorithm to look for the best available move on
/// [initialBoard] a [GameBoardScorer] to provide the heuristic.
class MoveFinder {
  final GameBoard initialBoard;

  MoveFinder(this.initialBoard);

  /// Searches the tree of possible moves on [initialBoard] to a depth of
  /// [numPlies], looking for the best possible move for [player]. Because the
  /// actual work is done in an isolate, a [Future] is used as the return value.
  Future<Position?> findNextMove(PieceType player, int numPlies) {
    return compute(
      _findNextMove,
      MoveSearchArgs(
        board: initialBoard,
        player: player,
        numPlies: numPlies,
      ),
    );
  }

  /// Picks a move for [player] according to [difficulty]:
  ///  - Super Easy deliberately favors weak, risky moves on a smaller board.
  ///  - Easy plays a uniformly random legal move, so beginners can win.
  ///  - Medium greedily picks whichever move scores best right away, with no
  ///    lookahead, so it's beatable but still plays sensibly.
  ///  - Hard uses a five-ply minimax search with a positional heuristic.
  ///  - Expert (Premium) runs a time-limited iterative-deepening search with
  ///    mobility and frontier evaluation, and solves endgames exactly.
  Future<Position?> findMove(PieceType player, Difficulty difficulty) async {
    final availableMoves = initialBoard.getMovesForPlayer(player);
    if (availableMoves.isEmpty) {
      return null;
    }

    switch (difficulty) {
      case Difficulty.superEasy:
        Position? worstMove;
        var worstScore = GameBoardScorer.maxScore;
        final beforeCount = initialBoard.getPieceCount(player);
        final last = initialBoard.size - 1;

        for (final move in availableMoves) {
          final newBoard = initialBoard.updateForMove(move.x, move.y, player);
          final piecesGained = newBoard.getPieceCount(player) - beforeCount;
          final opponentMobility =
              newBoard.getMovesForPlayer(getOpponent(player)).length;
          final isCorner = (move.x == 0 || move.x == last) &&
              (move.y == 0 || move.y == last);
          final besideCorner = (move.x <= 1 || move.x >= last - 1) &&
              (move.y <= 1 || move.y >= last - 1) &&
              !isCorner;

          // Low scores are intentionally bad: flip as little as possible,
          // give the human lots of replies, avoid safe corners, and prefer
          // the dangerous squares beside an open corner.
          final weakMoveScore = piecesGained * 20 -
              opponentMobility * 5 +
              (isCorner ? 10000 : 0) -
              (besideCorner ? 10000 : 0);
          if (worstMove == null || weakMoveScore < worstScore) {
            worstScore = weakMoveScore;
            worstMove = move;
          }
        }
        return worstMove;
      case Difficulty.easy:
        return availableMoves[Random().nextInt(availableMoves.length)];
      case Difficulty.medium:
        Position? bestMove;
        int bestScore = GameBoardScorer.minScore;
        for (final move in availableMoves) {
          final newBoard = initialBoard.updateForMove(move.x, move.y, player);
          final score = GameBoardScorer(newBoard).getScore(player);
          if (bestMove == null || score > bestScore) {
            bestScore = score;
            bestMove = move;
          }
        }
        return bestMove;
      case Difficulty.hard:
        return findNextMove(player, 5);
      case Difficulty.expert:
        if (initialBoard.size != GameBoard.standardSize) {
          return findNextMove(player, 5);
        }
        return compute(
          findExpertMove,
          ExpertSearchRequest(
            board: initialBoard,
            player: player,
            seed: DateTime.now().microsecondsSinceEpoch,
          ),
        );
    }
  }
}

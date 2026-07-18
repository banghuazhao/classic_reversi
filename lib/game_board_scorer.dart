// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'game_board.dart';

class GameBoardScorer {
  // Values for each position on the board.
  static const _positionValues = [
    [10000, -1000, 100, 100, 100, 100, -1000, 10000],
    [-1000, -1000, 1, 1, 1, 1, -1000, -1000],
    [100, 1, 50, 50, 50, 50, 1, 100],
    [100, 1, 50, 1, 1, 50, 1, 100],
    [100, 1, 50, 1, 1, 50, 1, 100],
    [100, 1, 50, 50, 50, 50, 1, 100],
    [-1000, -1000, 1, 1, 1, 1, -1000, -1000],
    [10000, -1000, 100, 100, 100, 100, -1000, 10000],
  ];

  /// Maximum and minimum values for scores, which are used in the minimax
  /// algorithm in [MoveFinder].
  static const maxScore = 1000 * 1000 * 1000;
  static const minScore = -1 * maxScore;

  final GameBoard board;

  GameBoardScorer(this.board);

  /// Returns the score of the board, as determined by what pieces are in place,
  /// and how valuable their locations are. This is a very simple scoring
  /// heuristic, but it's surprisingly effective.
  int getScore(PieceType player) {
    assert(player != PieceType.empty);
    var opponent = getOpponent(player);
    var score = 0;

    if (board.getMovesForPlayer(PieceType.black).isEmpty &&
        board.getMovesForPlayer(PieceType.white).isEmpty) {
      // Game is over.
      var playerCount = board.getPieceCount(player);
      var opponentCount = board.getPieceCount(getOpponent(player));

      if (playerCount > opponentCount) {
        return maxScore;
      } else if (playerCount < opponentCount) {
        return minScore;
      } else {
        return 0;
      }
    }

    for (var y = 0; y < board.height; y++) {
      for (var x = 0; x < board.width; x++) {
        final positionValue = board.size == GameBoard.standardSize
            ? _positionValues[y][x]
            : _compactPositionValue(x, y);
        if (board.getPieceAtLocation(x, y) == player) {
          score += positionValue;
        } else if (board.getPieceAtLocation(x, y) == opponent) {
          score -= positionValue;
        }
      }
    }

    return score;
  }

  int _compactPositionValue(int x, int y) {
    final last = board.size - 1;
    final onLeftOrRight = x == 0 || x == last;
    final onTopOrBottom = y == 0 || y == last;
    if (onLeftOrRight && onTopOrBottom) {
      return 10000;
    }

    final besideHorizontalEdge = x == 1 || x == last - 1;
    final besideVerticalEdge = y == 1 || y == last - 1;
    if ((besideHorizontalEdge && onTopOrBottom) ||
        (besideVerticalEdge && onLeftOrRight) ||
        (besideHorizontalEdge && besideVerticalEdge)) {
      return -1000;
    }
    if (onLeftOrRight || onTopOrBottom) {
      return 100;
    }
    return 10;
  }
}

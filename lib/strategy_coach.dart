import 'dart:math' as math;

import 'package:flutter/foundation.dart';

import 'game_board.dart';
import 'game_model.dart';

enum StrategyReason {
  corner,
  forcesPass,
  replies,
  avoidsCorner,
  allowsCorner,
  endsGame
}

/// Board facts about one legal move. The score is a bounded heuristic, not a
/// solved-game evaluation; UI explanations deliberately use facts instead.
class StrategyAdvice {
  StrategyAdvice({
    required this.move,
    required this.player,
    required this.opponentReplies,
    required this.flippedCount,
    required List<StrategyReason> reasons,
    required this.score,
  }) : reasons = List.unmodifiable(reasons);

  final Position move;
  final PieceType player;
  final int opponentReplies;
  final int flippedCount;
  final List<StrategyReason> reasons;
  final int score;
}

class StrategyTurningPoint {
  const StrategyTurningPoint(
      {required this.index, required this.actualMove, required this.advice});

  /// Index of the position BEFORE the played move in the supplied chronology.
  final int index;
  final Position actualMove;
  final StrategyAdvice advice;

  bool get offersAlternative =>
      !StrategyCoach.sameMove(actualMove, advice.move);
}

/// Expensive work runs outside the UI isolate. Each root move explores at most
/// eight opponent replies; replay analysis visits at most 64 game positions.
abstract final class StrategyCoach {
  static Future<StrategyAdvice?> analyze(GameModel position,
          {Position? chosenMove}) =>
      compute(_analyze, _AnalysisRequest(position, chosenMove));

  static Future<StrategyTurningPoint?> findTurningPoint(List<GameModel> history,
          {PieceType? player}) =>
      compute(_findTurningPoint, _HistoryRequest(List.of(history), player));

  static String coordinate(Position move) =>
      '${String.fromCharCode(65 + move.x)}${move.y + 1}';

  static bool sameMove(Position a, Position b) => a.x == b.x && a.y == b.y;

  /// Locate an actual placement; flips and automatic passes are not new moves.
  static Position? placedMove(GameBoard before, GameBoard after) {
    if (before.size != after.size) return null;
    for (var y = 0; y < after.size; y++) {
      for (var x = 0; x < after.size; x++) {
        if (before.rows[y][x] == PieceType.empty &&
            after.rows[y][x] != PieceType.empty) {
          return Position(x, y);
        }
      }
    }
    return null;
  }
}

class _AnalysisRequest {
  const _AnalysisRequest(this.model, this.chosenMove);
  final GameModel model;
  final Position? chosenMove;
}

class _HistoryRequest {
  const _HistoryRequest(this.history, this.player);
  final List<GameModel> history;
  final PieceType? player;
}

bool _isCorner(GameBoard board, Position move) =>
    (move.x == 0 || move.x == board.size - 1) &&
    (move.y == 0 || move.y == board.size - 1);

int _cornerCount(GameBoard board, PieceType player) {
  final end = board.size - 1;
  return [
    board.rows[0][0],
    board.rows[0][end],
    board.rows[end][0],
    board.rows[end][end]
  ].where((piece) => piece == player).length;
}

int _adjacentRisk(GameBoard board, PieceType player) {
  var count = 0;
  final end = board.size - 1;
  for (final x in [0, end]) {
    for (final y in [0, end]) {
      if (board.rows[y][x] != PieceType.empty) continue;
      final dx = x == 0 ? 1 : -1;
      final dy = y == 0 ? 1 : -1;
      for (final p in [
        Position(x + dx, y),
        Position(x, y + dy),
        Position(x + dx, y + dy)
      ]) {
        if (board.rows[p.y][p.x] == player) count++;
      }
    }
  }
  return count;
}

int _evaluate(GameBoard board, PieceType player) {
  final opponent = getOpponent(player);
  final ownMoves = board.getMovesForPlayer(player);
  final replies = board.getMovesForPlayer(opponent);
  final discs = board.getPieceCount(player) - board.getPieceCount(opponent);
  if (ownMoves.isEmpty && replies.isEmpty) {
    return discs == 0 ? 0 : discs.sign * 100000 + discs * 100;
  }
  final empties = board.getPieceCount(PieceType.empty);
  return (_cornerCount(board, player) - _cornerCount(board, opponent)) * 220 +
      (ownMoves.length - replies.length) * 9 +
      discs * (empties <= 12 ? 8 : 1) -
      (_adjacentRisk(board, player) - _adjacentRisk(board, opponent)) * 14;
}

int _scoreMove(GameModel model, Position move) {
  final player = model.player;
  final after = model.board.updateForMove(move.x, move.y, player);
  final replies =
      List<Position>.of(after.getMovesForPlayer(getOpponent(player)));
  if (replies.isEmpty) return _evaluate(after, player) + 35;
  // Examine corners first, then a stable coordinate order. The cap bounds
  // work even for unusual boards with many legal replies.
  replies.sort((a, b) {
    final corners =
        (_isCorner(after, b) ? 1 : 0) - (_isCorner(after, a) ? 1 : 0);
    return corners != 0
        ? corners
        : (a.y * after.size + a.x).compareTo(b.y * after.size + b.x);
  });
  var worstReply = 1 << 30;
  for (final reply in replies.take(8)) {
    worstReply = math.min(
        worstReply,
        _evaluate(after.updateForMove(reply.x, reply.y, getOpponent(player)),
            player));
  }
  return worstReply + _evaluate(after, player) ~/ 8;
}

StrategyAdvice _facts(
    GameModel model, Position move, int score, List<Position> legal) {
  final board = model.board;
  final player = model.player;
  final after = board.updateForMove(move.x, move.y, player);
  final replies = after.getMovesForPlayer(getOpponent(player));
  final ownMoves = after.getMovesForPlayer(player);
  final givesCorner = replies.any((reply) => _isCorner(after, reply));
  final avoidsCorner = !givesCorner &&
      legal.any((other) {
        if (StrategyCoach.sameMove(other, move)) return false;
        final alternative = board.updateForMove(other.x, other.y, player);
        return alternative
            .getMovesForPlayer(getOpponent(player))
            .any((reply) => _isCorner(alternative, reply));
      });
  return StrategyAdvice(
    move: move,
    player: player,
    opponentReplies: replies.length,
    flippedCount: GameBoard.flippedPositions(board, after, move).length,
    score: score,
    reasons: [
      if (_isCorner(board, move)) StrategyReason.corner,
      if (replies.isEmpty && ownMoves.isNotEmpty) StrategyReason.forcesPass,
      if (replies.isEmpty && ownMoves.isEmpty) StrategyReason.endsGame,
      if (avoidsCorner) StrategyReason.avoidsCorner,
      if (givesCorner) StrategyReason.allowsCorner,
      if (replies.isNotEmpty) StrategyReason.replies,
    ],
  );
}

StrategyAdvice? _analyze(_AnalysisRequest request) {
  final model = request.model;
  final legal = model.board.getMovesForPlayer(model.player);
  if (legal.isEmpty) return null;
  final chosen = request.chosenMove;
  if (chosen != null) {
    if (!legal.any((move) => StrategyCoach.sameMove(move, chosen))) return null;
    return _facts(model, chosen, _scoreMove(model, chosen), legal);
  }
  Position selected = legal.first;
  var selectedScore = -(1 << 30);
  for (final move in legal) {
    final score = _scoreMove(model, move);
    if (score > selectedScore) {
      selectedScore = score;
      selected = move;
    }
  }
  return _facts(model, selected, selectedScore, legal);
}

StrategyTurningPoint? _findTurningPoint(_HistoryRequest request) {
  StrategyTurningPoint? selected;
  var priority = -(1 << 30);
  for (var index = 0;
      index < request.history.length - 1 && index < 64;
      index++) {
    final model = request.history[index];
    if (request.player != null && model.player != request.player) {
      continue;
    }
    final actual =
        StrategyCoach.placedMove(model.board, request.history[index + 1].board);
    if (actual == null ||
        !model.board
            .getMovesForPlayer(model.player)
            .any((move) => StrategyCoach.sameMove(move, actual))) {
      continue;
    }
    final advice = _analyze(_AnalysisRequest(model, null));
    if (advice == null) continue;
    final different = !StrategyCoach.sameMove(actual, advice.move);
    final gap =
        different ? math.max(0, advice.score - _scoreMove(model, actual)) : 0;
    final noteworthy = advice.reasons.contains(StrategyReason.corner) ||
        advice.reasons.contains(StrategyReason.forcesPass) ||
        advice.reasons.contains(StrategyReason.avoidsCorner);
    final candidatePriority = (different && gap > 0 ? 10000 : 0) +
        math.min(gap, 5000).toInt() +
        (noteworthy ? 50 : 0);
    if (candidatePriority > priority) {
      priority = candidatePriority;
      selected = StrategyTurningPoint(
          index: index, actualMove: actual, advice: advice);
    }
  }
  return selected;
}

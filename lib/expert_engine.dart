import 'dart:math';
import 'dart:typed_data';

import 'game_board.dart';

/// Input for one Expert search. Plain data so it can cross an isolate.
class ExpertSearchRequest {
  const ExpertSearchRequest({
    required this.board,
    required this.player,
    this.budget = const Duration(milliseconds: 1100),
    this.seed = 0,
    this.maxDepth = 64,
  });

  final GameBoard board;
  final PieceType player;

  /// Wall-clock limit. The deepest fully completed iteration is used.
  final Duration budget;

  /// Breaks ties between equally good moves so games do not repeat.
  final int seed;
  final int maxDepth;
}

class ExpertSearchResult {
  const ExpertSearchResult({
    required this.move,
    required this.depth,
    required this.score,
    required this.exact,
  });

  final Position move;

  /// Deepest completed iteration, in plies.
  final int depth;
  final int score;

  /// True when every line was searched to the end of the game.
  final bool exact;
}

/// Isolate entry point used by `MoveFinder` for [Difficulty.expert].
Position? findExpertMove(ExpertSearchRequest request) =>
    searchExpertMove(request)?.move;

ExpertSearchResult? searchExpertMove(ExpertSearchRequest request) {
  if (request.board.size != GameBoard.standardSize ||
      request.player == PieceType.empty) {
    return null;
  }
  return ExpertEngine.fromBoard(request.board).search(
    request.player,
    budget: request.budget,
    seed: request.seed,
    maxDepth: request.maxDepth,
  );
}

class _SearchTimeout implements Exception {
  const _SearchTimeout();
}

/// An 8×8 Reversi searcher on a bordered 10×10 mailbox. Moves are applied and
/// undone in place, so the search allocates almost nothing per node, unlike
/// the immutable [GameBoard] used by the UI. Integer-only and web-safe.
///
/// Evaluation weighs square values (with corner-aware X/C squares), mobility,
/// and frontier discs. Iterative deepening naturally becomes an exact solver
/// once the depth reaches the number of empty squares.
class ExpertEngine {
  ExpertEngine.fromBoard(GameBoard board)
      : assert(board.size == GameBoard.standardSize) {
    _cells.fillRange(0, _cells.length, _wall);
    for (var y = 0; y < 8; y++) {
      for (var x = 0; x < 8; x++) {
        _cells[_square(x, y)] = switch (board.rows[y][x]) {
          PieceType.black => _black,
          PieceType.white => _white,
          PieceType.empty => _empty,
        };
      }
    }
  }

  static const _empty = 0;
  static const _black = 1;
  static const _white = 2;
  static const _wall = 3;
  static const _infinity = 1 << 30;

  /// Terminal positions are worth far more than any heuristic score.
  static const finalScale = 10000;

  static const _directions = [-11, -10, -9, -1, 1, 9, 10, 11];

  static const _table = [
    [100, -20, 10, 5, 5, 10, -20, 100],
    [-20, -50, -2, -2, -2, -2, -50, -20],
    [10, -2, 1, 1, 1, 1, -2, 10],
    [5, -2, 1, 0, 0, 1, -2, 5],
    [5, -2, 1, 0, 0, 1, -2, 5],
    [10, -2, 1, 1, 1, 1, -2, 10],
    [-20, -50, -2, -2, -2, -2, -50, -20],
    [100, -20, 10, 5, 5, 10, -20, 100],
  ];

  static int _square(int x, int y) => (y + 1) * 10 + x + 1;

  static final Int32List _weights = () {
    final weights = Int32List(100);
    for (var y = 0; y < 8; y++) {
      for (var x = 0; x < 8; x++) {
        weights[_square(x, y)] = _table[y][x];
      }
    }
    return weights;
  }();

  /// Playable squares, strongest first. Generating moves in this order puts
  /// corners first and X-squares last, which is good alpha-beta ordering.
  static final List<int> _squares = () {
    final squares = [
      for (var y = 0; y < 8; y++)
        for (var x = 0; x < 8; x++) _square(x, y),
    ];
    squares.sort((a, b) => _weights[b].compareTo(_weights[a]));
    return List<int>.unmodifiable(squares);
  }();

  /// (corner, X-square, C-square, C-square) for each corner.
  static final List<List<int>> _cornerGroups = [
    [_square(0, 0), _square(1, 1), _square(1, 0), _square(0, 1)],
    [_square(7, 0), _square(6, 1), _square(6, 0), _square(7, 1)],
    [_square(0, 7), _square(1, 6), _square(1, 7), _square(0, 6)],
    [_square(7, 7), _square(6, 6), _square(6, 7), _square(7, 6)],
  ];

  final Int8List _cells = Int8List(100);
  final Int32List _flips = Int32List(4096);
  int _flipTop = 0;
  int _nodes = 0;
  final Stopwatch _clock = Stopwatch();
  int _deadlineMicros = 0;

  int get nodes => _nodes;

  static int _code(PieceType player) =>
      player == PieceType.black ? _black : _white;

  static Position _position(int square) =>
      Position(square % 10 - 1, square ~/ 10 - 1);

  bool _isLegal(int square, int player, int opponent) {
    if (_cells[square] != _empty) return false;
    for (final direction in _directions) {
      var cursor = square + direction;
      if (_cells[cursor] != opponent) continue;
      cursor += direction;
      while (_cells[cursor] == opponent) {
        cursor += direction;
      }
      if (_cells[cursor] == player) return true;
    }
    return false;
  }

  List<int> _moves(int player) {
    final opponent = 3 - player;
    final moves = <int>[];
    for (final square in _squares) {
      if (_isLegal(square, player, opponent)) moves.add(square);
    }
    return moves;
  }

  int _mobility(int player) {
    final opponent = 3 - player;
    var count = 0;
    for (final square in _squares) {
      if (_isLegal(square, player, opponent)) count++;
    }
    return count;
  }

  /// Places a disc and flips in place. Returns the number of flipped discs,
  /// which [_undo] needs to restore the previous position.
  int _play(int square, int player) {
    final opponent = 3 - player;
    var flipped = 0;
    for (final direction in _directions) {
      var cursor = square + direction;
      var run = 0;
      while (_cells[cursor] == opponent) {
        cursor += direction;
        run++;
      }
      if (run == 0 || _cells[cursor] != player) continue;
      cursor = square + direction;
      for (var i = 0; i < run; i++) {
        _cells[cursor] = player;
        _flips[_flipTop++] = cursor;
        cursor += direction;
      }
      flipped += run;
    }
    _cells[square] = player;
    return flipped;
  }

  void _undo(int square, int flipped, int player) {
    final opponent = 3 - player;
    for (var i = 0; i < flipped; i++) {
      _cells[_flips[--_flipTop]] = opponent;
    }
    _cells[square] = _empty;
  }

  bool _touchesEmpty(int square) {
    for (final direction in _directions) {
      if (_cells[square + direction] == _empty) return true;
    }
    return false;
  }

  /// Final disc difference for [player], with empty squares awarded to the
  /// winner as in tournament scoring.
  int _finalScore(int player) {
    var own = 0;
    var other = 0;
    for (final square in _squares) {
      final cell = _cells[square];
      if (cell == player) {
        own++;
      } else if (cell != _empty) {
        other++;
      }
    }
    final empties = 64 - own - other;
    var difference = own - other;
    if (difference > 0) {
      difference += empties;
    } else if (difference < 0) {
      difference -= empties;
    }
    return difference * finalScale;
  }

  /// Static evaluation from [player]'s point of view.
  int evaluate(int player) {
    final opponent = 3 - player;
    final ownMobility = _mobility(player);
    final otherMobility = _mobility(opponent);
    if (ownMobility == 0 && otherMobility == 0) return _finalScore(player);

    var positional = 0;
    var ownFrontier = 0;
    var otherFrontier = 0;
    for (final square in _squares) {
      final cell = _cells[square];
      if (cell == _empty) continue;
      final frontier = _touchesEmpty(square);
      if (cell == player) {
        positional += _weights[square];
        if (frontier) ownFrontier++;
      } else {
        positional -= _weights[square];
        if (frontier) otherFrontier++;
      }
    }
    // Once a corner is taken its X- and C-squares stop being liabilities.
    for (final group in _cornerGroups) {
      if (_cells[group[0]] == _empty) continue;
      for (var i = 1; i < group.length; i++) {
        final square = group[i];
        final adjustment = 5 - _weights[square];
        if (_cells[square] == player) {
          positional += adjustment;
        } else if (_cells[square] == opponent) {
          positional -= adjustment;
        }
      }
    }
    return positional * 2 +
        (ownMobility - otherMobility) * 12 +
        (otherFrontier - ownFrontier) * 6;
  }

  int _negamax(int player, int depth, int alpha, int beta, bool passed) {
    if ((++_nodes & 1023) == 0 &&
        _clock.elapsedMicroseconds > _deadlineMicros) {
      throw const _SearchTimeout();
    }
    if (depth <= 0) return evaluate(player);
    final opponent = 3 - player;
    final moves = _moves(player);
    if (moves.isEmpty) {
      if (passed) return _finalScore(player);
      // A pass does not consume depth, so exact searches stay exact.
      return -_negamax(opponent, depth, -beta, -alpha, true);
    }
    var best = -_infinity;
    for (final square in moves) {
      final flipped = _play(square, player);
      final value = -_negamax(opponent, depth - 1, -beta, -alpha, false);
      _undo(square, flipped, player);
      if (value > best) {
        best = value;
        if (value > alpha) {
          alpha = value;
          if (alpha >= beta) break;
        }
      }
    }
    return best;
  }

  int get _emptyCount {
    var count = 0;
    for (final square in _squares) {
      if (_cells[square] == _empty) count++;
    }
    return count;
  }

  /// Iterative deepening within [budget]. Always returns a legal move when one
  /// exists, even if the first iteration cannot finish in time.
  ExpertSearchResult? search(
    PieceType player, {
    Duration budget = const Duration(milliseconds: 1100),
    int seed = 0,
    int maxDepth = 64,
  }) {
    final own = _code(player);
    final opponent = 3 - own;
    final moves = _moves(own)..shuffle(Random(seed));
    if (moves.isEmpty) return null;
    if (moves.length == 1) {
      return ExpertSearchResult(
          move: _position(moves.first), depth: 0, score: 0, exact: false);
    }

    _clock
      ..reset()
      ..start();
    _deadlineMicros = budget.inMicroseconds;
    final empties = _emptyCount;
    final depthLimit = min(maxDepth, empties);
    final scores = <int, int>{for (final move in moves) move: -_infinity};
    var bestMove = moves.first;
    var bestScore = -_infinity;
    var completed = 0;

    for (var depth = 1; depth <= depthLimit; depth++) {
      final ordered = List<int>.of(moves)
        ..sort((a, b) => scores[b]!.compareTo(scores[a]!));
      final snapshot = _flipTop;
      try {
        var alpha = -_infinity;
        var iterationBest = ordered.first;
        var iterationScore = -_infinity;
        for (final square in ordered) {
          final flipped = _play(square, own);
          final value =
              -_negamax(opponent, depth - 1, -_infinity, -alpha, false);
          _undo(square, flipped, own);
          scores[square] = value;
          if (value > iterationScore) {
            iterationScore = value;
            iterationBest = square;
          }
          if (value > alpha) alpha = value;
        }
        bestMove = iterationBest;
        bestScore = iterationScore;
        completed = depth;
      } on _SearchTimeout {
        // The board may be mid-line; this engine is discarded after search.
        _flipTop = snapshot;
        break;
      }
      if (depth >= empties) break;
      // The next iteration typically costs several times this one.
      if (_clock.elapsedMicroseconds * 3 > _deadlineMicros) break;
    }
    _clock.stop();
    return ExpertSearchResult(
      move: _position(bestMove),
      depth: completed,
      score: bestScore,
      exact: completed >= empties,
    );
  }
}

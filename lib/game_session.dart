import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'game_board.dart';
import 'game_model.dart';
import 'game_settings.dart';

/// An unfinished match, including the history needed for undo and review.
class GameSession {
  final GameSettings settings;
  final List<GameModel> timeline;
  final List<GameModel> undoHistory;
  final Position? lastMove;
  final bool canUndo;
  final bool hintsUnlocked;
  final int rewardedUndoCharges;
  final DateTime savedAt;

  GameSession({
    required this.settings,
    required List<GameModel> timeline,
    List<GameModel> undoHistory = const [],
    this.lastMove,
    this.canUndo = false,
    this.hintsUnlocked = false,
    this.rewardedUndoCharges = 0,
    DateTime? savedAt,
  })  : timeline = List.unmodifiable(timeline),
        undoHistory = List.unmodifiable(undoHistory),
        savedAt = savedAt ?? DateTime.now() {
    if (timeline.isEmpty) {
      throw ArgumentError.value(timeline, 'timeline', 'Must not be empty');
    }
  }

  GameModel get model => timeline.last;
}

/// Persists one active match. Operations execute in invocation order, so a
/// delayed save cannot resurrect a match after [clear] has completed.
class GameSessionService {
  GameSessionService._();

  static const _key = 'activeGameSession';
  static const _maxSnapshotLength = 200000;
  static Future<void>? _pending;

  static Future<T> _enqueue<T>(Future<T> Function() operation) {
    final result =
        _pending?.then((_) => operation()) ?? Future<T>.sync(operation);
    // A failed platform write must not block subsequent saves or clearing.
    final tail =
        result.then<void>((_) {}, onError: (Object _, StackTrace __) {});
    _pending = tail;
    // Release the completed queue as well as its asynchronous zone. A fresh
    // operation starts in its caller's zone instead of retaining an old one.
    tail.then((_) {
      if (identical(_pending, tail)) _pending = null;
    });
    return result;
  }

  static Future<GameSession?> load() => _enqueue(() async {
        final preferences = await SharedPreferences.getInstance();
        final stored = preferences.get(_key);
        if (stored == null) return null;
        try {
          if (stored is! String || stored.length > _maxSnapshotLength) {
            throw const FormatException('Invalid session storage');
          }
          final session = GameSessionCodec.decode(
            GameSessionCodec._map(jsonDecode(stored)),
          );
          final now = DateTime.now();
          final saved = session.savedAt.toLocal();
          final expiredDaily = session.settings.isDailyChallenge &&
              (saved.year != now.year ||
                  saved.month != now.month ||
                  saved.day != now.day);
          if (!session.model.gameIsOver && !expiredDaily) return session;
        } on FormatException {
          // Corrupt snapshots should never prevent the home screen from opening.
        }
        await preferences.remove(_key);
        return null;
      });

  static Future<void> save(GameSession session) {
    // Encode now, before waiting on storage, to capture this exact turn.
    final encoded = jsonEncode(GameSessionCodec.encode(session));
    return _enqueue(() async {
      final preferences = await SharedPreferences.getInstance();
      await preferences.setString(_key, encoded);
    });
  }

  static Future<void> clear() => _enqueue(() async {
        final preferences = await SharedPreferences.getInstance();
        await preferences.remove(_key);
      });
}

/// Versioned board and chronology validation shared by active and saved games.
/// The caller decides whether the decoded match must still be in progress.
class GameSessionCodec {
  GameSessionCodec._();

  static const _version = 1;

  static Map<String, Object?> encode(GameSession session) => {
        'version': _version,
        'savedAt': session.savedAt.toIso8601String(),
        'settings': {
          'difficulty': session.settings.difficulty.name,
          'twoPlayerMode': session.settings.twoPlayerMode,
          'humanColor': session.settings.humanColor.name,
          'isDailyChallenge': session.settings.isDailyChallenge,
          'boardSize': session.settings.boardSize,
          'initialBoard': session.settings.initialBoard == null
              ? null
              : _encodeBoard(session.settings.initialBoard!),
          'initialPlayer': session.settings.initialPlayer?.name,
        },
        'timeline': session.timeline.map(_encodeModel).toList(),
        'undoHistory': session.undoHistory.map(_encodeModel).toList(),
        'lastMove': session.lastMove == null
            ? null
            : {'x': session.lastMove!.x, 'y': session.lastMove!.y},
        'canUndo': session.canUndo,
        'hintsUnlocked': session.hintsUnlocked,
        'rewardedUndoCharges': session.rewardedUndoCharges,
      };

  static List<List<String>> _encodeBoard(GameBoard board) =>
      board.rows.map((row) => row.map((piece) => piece.name).toList()).toList();

  static Map<String, Object> _encodeModel(GameModel model) => {
        'board': _encodeBoard(model.board),
        'player': model.player.name,
      };

  static GameSession decode(Map<String, dynamic> data) {
    if (data['version'] is! int || data['version'] != _version) {
      throw const FormatException('Unsupported session version');
    }
    final savedAtValue = data['savedAt'];
    if (savedAtValue is! String || savedAtValue.length > 40) {
      throw const FormatException('Missing save date');
    }
    final savedAt = DateTime.tryParse(savedAtValue);
    if (savedAt == null || savedAt.toIso8601String() != savedAtValue) {
      throw const FormatException('Invalid save date');
    }
    final settingsData = _map(data['settings']);
    final size = settingsData['boardSize'];
    if (size is! int ||
        (size != GameBoard.compactSize && size != GameBoard.standardSize)) {
      throw const FormatException('Unsupported board size');
    }
    final difficulty = _enum(settingsData['difficulty'], Difficulty.values);
    final initialBoard = settingsData['initialBoard'] == null
        ? null
        : _board(settingsData['initialBoard'], size);
    final initialPlayer = settingsData['initialPlayer'] == null
        ? null
        : _player(settingsData['initialPlayer']);
    final settings = GameSettings(
      difficulty: difficulty,
      twoPlayerMode: _bool(settingsData['twoPlayerMode']),
      humanColor: _player(settingsData['humanColor']),
      isDailyChallenge: _bool(settingsData['isDailyChallenge']),
      initialBoard: initialBoard,
      initialPlayer: initialPlayer,
    );
    if (settings.boardSize != size ||
        (settings.isDailyChallenge &&
            (initialBoard == null || initialPlayer == null))) {
      throw const FormatException('Inconsistent starting position');
    }
    final timeline = _models(data['timeline'], size, allowEmpty: false);
    final undoHistory = _models(data['undoHistory'], size, allowEmpty: true);
    final initial = GameModel.initial(
      board: initialBoard,
      player: initialPlayer,
      boardSize: size,
    );
    if (!_sameModel(timeline.first, initial)) {
      throw const FormatException('History has no starting position');
    }
    for (var index = 1; index < timeline.length; index++) {
      if (!_follows(timeline[index - 1], timeline[index])) {
        throw const FormatException('Invalid move history');
      }
    }
    // Undo snapshots may skip CPU turns, but must belong to this timeline.
    var undoIndex = 0;
    for (final previous in timeline.take(timeline.length - 1)) {
      if (undoIndex < undoHistory.length &&
          _sameModel(previous, undoHistory[undoIndex])) {
        undoIndex++;
      }
    }
    if (undoIndex != undoHistory.length) {
      throw const FormatException('Undo history does not match the game');
    }
    final canUndo = _bool(data['canUndo']);
    final charges = data['rewardedUndoCharges'];
    if ((canUndo && undoHistory.isEmpty) ||
        charges is! int ||
        charges < 0 ||
        charges > size * size) {
      throw const FormatException('Invalid undo state');
    }
    Position? lastMove;
    if (data['lastMove'] != null) {
      final move = _map(data['lastMove']);
      final x = move['x'];
      final y = move['y'];
      if (x is! int ||
          y is! int ||
          x < 0 ||
          y < 0 ||
          x >= size ||
          y >= size ||
          timeline.last.board.getPieceAtLocation(x, y) == PieceType.empty ||
          (timeline.length > 1 &&
              timeline[timeline.length - 2].board.getPieceAtLocation(x, y) !=
                  PieceType.empty)) {
        throw const FormatException('Invalid last move');
      }
      lastMove = Position(x, y);
    }
    return GameSession(
      settings: settings,
      timeline: timeline,
      undoHistory: undoHistory,
      lastMove: lastMove,
      canUndo: canUndo,
      hintsUnlocked: _bool(data['hintsUnlocked']),
      rewardedUndoCharges: charges,
      savedAt: savedAt,
    );
  }

  static Map<String, dynamic> _map(Object? value) {
    if (value is! Map<String, dynamic>) {
      throw const FormatException('Expected an object');
    }
    return value;
  }

  static bool _bool(Object? value) {
    if (value is! bool) throw const FormatException('Expected a boolean');
    return value;
  }

  static T _enum<T extends Enum>(Object? value, List<T> values) {
    for (final candidate in values) {
      if (candidate.name == value) return candidate;
    }
    throw const FormatException('Unknown enum value');
  }

  static PieceType _player(Object? value) {
    final player = _enum(value, PieceType.values);
    if (player == PieceType.empty) {
      throw const FormatException('Empty is not a player');
    }
    return player;
  }

  static GameBoard _board(Object? value, int size) {
    if (value is! List || value.length != size) {
      throw const FormatException('Invalid board height');
    }
    final rows = <List<PieceType>>[];
    for (final row in value) {
      if (row is! List || row.length != size) {
        throw const FormatException('Invalid board width');
      }
      rows.add(row.map((cell) => _enum(cell, PieceType.values)).toList());
    }
    return GameBoard.fromRows(rows);
  }

  static List<GameModel> _models(
    Object? value,
    int size, {
    required bool allowEmpty,
  }) {
    if (value is! List ||
        value.length > size * size - 3 ||
        (!allowEmpty && value.isEmpty)) {
      throw const FormatException('Invalid history length');
    }
    return value.map((entry) {
      final data = _map(entry);
      final model = GameModel(
        board: _board(data['board'], size),
        player: _enum(data['player'], PieceType.values),
      );
      if (model.gameIsOver &&
          (model.board.getMovesForPlayer(PieceType.black).isNotEmpty ||
              model.board.getMovesForPlayer(PieceType.white).isNotEmpty)) {
        throw const FormatException('Active player cannot move');
      }
      return model;
    }).toList();
  }

  static bool _sameModel(GameModel left, GameModel right) {
    if (left.player != right.player || left.board.size != right.board.size) {
      return false;
    }
    for (var y = 0; y < left.board.size; y++) {
      for (var x = 0; x < left.board.size; x++) {
        if (left.board.rows[y][x] != right.board.rows[y][x]) return false;
      }
    }
    return true;
  }

  static bool _follows(GameModel previous, GameModel next) {
    if (previous.gameIsOver) return false;
    Position? placed;
    for (var y = 0; y < previous.board.size; y++) {
      for (var x = 0; x < previous.board.size; x++) {
        if (previous.board.rows[y][x] == PieceType.empty &&
            next.board.rows[y][x] != PieceType.empty) {
          if (placed != null) return false;
          placed = Position(x, y);
        }
      }
    }
    if (placed == null) return false;
    final expected = previous.updateForMove(placed.x, placed.y);
    return expected != null && _sameModel(expected, next);
  }
}

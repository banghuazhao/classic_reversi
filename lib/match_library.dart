import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'game_model.dart';
import 'game_session.dart';
import 'game_settings.dart';

/// A completed game with its original setup and every position in order.
class SavedMatch {
  final String id;
  final GameSettings settings;
  final List<GameModel> history;
  final DateTime startedAt;
  final DateTime completedAt;

  SavedMatch({
    required this.id,
    required this.settings,
    required List<GameModel> history,
    required this.startedAt,
    required this.completedAt,
  }) : history = List.unmodifiable(history) {
    if (history.isEmpty) {
      throw ArgumentError.value(history, 'history', 'Must not be empty');
    }
  }

  GameModel get finalModel => history.last;
}

/// A local replay shelf independent of active-game recovery and statistics.
class MatchLibraryService {
  MatchLibraryService._();

  static const maxSavedMatches = 100;
  static const _key = 'completedMatchLibrary';
  static const _version = 1;
  static const _maxEncodedLength = 10000000;
  static Future<void>? _pending;
  static String? _cachedEncoded;
  static List<SavedMatch>? _cachedRecords;

  static Future<T> _enqueue<T>(Future<T> Function() operation) {
    final result =
        _pending?.then((_) => operation()) ?? Future<T>.sync(operation);
    final tail =
        result.then<void>((_) {}, onError: (Object _, StackTrace __) {});
    _pending = tail;
    tail.then((_) {
      if (identical(_pending, tail)) _pending = null;
    });
    return result;
  }

  static Future<void> saveCompleted({
    required GameSettings settings,
    required List<GameModel> history,
    required DateTime startedAt,
    DateTime? completedAt,
  }) async {
    if (history.isEmpty || !history.last.gameIsOver) return;
    final finished = completedAt ?? DateTime.now();
    if (finished.isBefore(startedAt)) {
      throw ArgumentError('Completion must not be before the game started');
    }
    // Capture and validate the chronology before entering the storage queue.
    // This reuses the same safe board/settings codec as active-game recovery.
    final snapshot = GameSessionCodec.encode(GameSession(
      settings: settings,
      timeline: history,
      savedAt: startedAt,
    ));
    final validated = GameSessionCodec.decode(snapshot);
    final record = SavedMatch(
      id: _idFor(settings, startedAt),
      settings: validated.settings,
      history: validated.timeline,
      startedAt: startedAt,
      completedAt: finished,
    );
    await _enqueue(() async {
      final preferences = await SharedPreferences.getInstance();
      final records = _read(preferences);
      // The terminal turn may be observed by more than one lifecycle callback.
      // Retain its original completion time rather than moving it up the shelf.
      if (records.any((saved) => saved.id == record.id)) return;
      records.add(record);
      _sort(records);
      await _write(preferences, records.take(maxSavedMatches).toList());
    });
  }

  static Future<List<SavedMatch>> load() => _enqueue(() async {
        final preferences = await SharedPreferences.getInstance();
        return List<SavedMatch>.unmodifiable(_read(preferences));
      });

  static Future<void> remove(String id) => _enqueue(() async {
        final preferences = await SharedPreferences.getInstance();
        final records = _read(preferences)
          ..removeWhere((record) => record.id == id);
        await _write(preferences, records);
      });

  static Future<void> clear() => _enqueue(() async {
        final preferences = await SharedPreferences.getInstance();
        await _persist(preferences, () => preferences.remove(_key),
            'Could not clear the match library');
        _cachedEncoded = null;
        _cachedRecords = null;
      });

  static String _idFor(GameSettings settings, DateTime startedAt) =>
      '${startedAt.microsecondsSinceEpoch}-${settings.boardSize}-'
      '${settings.difficulty.name}-${settings.humanColor.name}-'
      '${settings.isDailyChallenge ? 'daily' : settings.twoPlayerMode ? 'two' : 'cpu'}';

  static void _sort(List<SavedMatch> records) {
    records.sort((left, right) {
      final order = right.completedAt.compareTo(left.completedAt);
      return order == 0 ? right.id.compareTo(left.id) : order;
    });
  }

  static List<SavedMatch> _read(SharedPreferences preferences) {
    final stored = preferences.get(_key);
    if (stored == null) {
      _cachedEncoded = null;
      _cachedRecords = null;
      return [];
    }
    if (stored is String &&
        stored == _cachedEncoded &&
        _cachedRecords != null) {
      return List.of(_cachedRecords!);
    }
    try {
      if (stored is! String || stored.length > _maxEncodedLength) {
        throw const FormatException('Invalid match library storage');
      }
      final data = _map(jsonDecode(stored));
      final entries = data['matches'];
      if (data['version'] is! int ||
          data['version'] != _version ||
          entries is! List ||
          entries.length > maxSavedMatches) {
        throw const FormatException('Unsupported match library');
      }
      final records = <SavedMatch>[];
      final ids = <String>{};
      for (final entry in entries) {
        try {
          final record = _decodeRecord(_map(entry));
          if (ids.add(record.id)) records.add(record);
        } on FormatException {
          // One damaged replay must not hide the rest of the library.
        }
      }
      _sort(records);
      _cachedEncoded = stored;
      _cachedRecords = List.unmodifiable(records);
      return records;
    } on FormatException {
      _cachedEncoded = stored is String ? stored : null;
      _cachedRecords = const [];
      return [];
    }
  }

  static Map<String, dynamic> _map(Object? value) {
    if (value is! Map<String, dynamic>) {
      throw const FormatException('Expected an object');
    }
    return value;
  }

  static DateTime _date(Object? value) {
    if (value is! String || value.length > 40) {
      throw const FormatException('Invalid match date');
    }
    final parsed = DateTime.tryParse(value);
    if (parsed == null || parsed.toIso8601String() != value) {
      throw const FormatException('Invalid match date');
    }
    return parsed;
  }

  static SavedMatch _decodeRecord(Map<String, dynamic> data) {
    final startedAt = _date(data['startedAt']);
    final completedAt = _date(data['completedAt']);
    final session = GameSessionCodec.decode(_map(data['session']));
    final id = data['id'];
    if (id is! String ||
        id != _idFor(session.settings, startedAt) ||
        !session.savedAt.isAtSameMomentAs(startedAt) ||
        completedAt.isBefore(startedAt) ||
        !session.model.gameIsOver) {
      throw const FormatException('Invalid completed match');
    }
    return SavedMatch(
      id: id,
      settings: session.settings,
      history: session.timeline,
      startedAt: startedAt,
      completedAt: completedAt,
    );
  }

  static Future<void> _write(
      SharedPreferences preferences, List<SavedMatch> records) async {
    if (records.isEmpty) {
      await _persist(preferences, () => preferences.remove(_key),
          'Could not remove a saved match');
      _cachedEncoded = null;
      _cachedRecords = null;
      return;
    }
    final encoded = jsonEncode({
      'version': _version,
      'matches': records
          .map((record) => {
                'id': record.id,
                'startedAt': record.startedAt.toUtc().toIso8601String(),
                'completedAt': record.completedAt.toUtc().toIso8601String(),
                'session': GameSessionCodec.encode(GameSession(
                  settings: record.settings,
                  timeline: record.history,
                  savedAt: record.startedAt.toUtc(),
                )),
              })
          .toList(),
    });
    await _persist(preferences, () => preferences.setString(_key, encoded),
        'Could not save the match library');
    _cachedEncoded = encoded;
    _cachedRecords = List.unmodifiable(records);
  }

  static Future<void> _persist(SharedPreferences preferences,
      Future<bool> Function() write, String failureMessage) async {
    try {
      if (!await write()) throw StateError(failureMessage);
    } catch (_) {
      // SharedPreferences updates its optimistic cache before platform storage
      // answers. Restore the durable values so a retry cannot mistake a failed
      // save for an existing replay or hide a replay after a failed deletion.
      _cachedEncoded = null;
      _cachedRecords = null;
      await preferences.reload();
      rethrow;
    }
  }
}

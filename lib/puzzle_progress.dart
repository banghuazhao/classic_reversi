import 'package:shared_preferences/shared_preferences.dart';

import 'puzzles.dart';

/// Independent, idempotent puzzle progress. This storage never touches active
/// matches, game history, achievements, or match statistics.
abstract final class PuzzleProgressService {
  static const storageKey = 'completedCuratedPuzzles';
  static Future<void>? _pending;

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

  static Set<String> _read(SharedPreferences preferences) {
    final stored = preferences.get(storageKey);
    if (stored is! List) return {};
    final known = curatedPuzzles.map((puzzle) => puzzle.id).toSet();
    return stored.whereType<String>().where(known.contains).toSet();
  }

  static Future<Set<String>> loadCompletedIds() => _enqueue(() async {
        final preferences = await SharedPreferences.getInstance();
        return Set.unmodifiable(_read(preferences));
      });

  /// Returns true only for a newly completed, known puzzle.
  static Future<bool> complete(String id) => _enqueue(() async {
        if (!curatedPuzzles.any((puzzle) => puzzle.id == id)) {
          throw ArgumentError.value(id, 'id', 'Unknown puzzle');
        }
        final preferences = await SharedPreferences.getInstance();
        final completed = _read(preferences);
        if (!completed.add(id)) return false;
        try {
          final saved = await preferences.setStringList(
            storageKey,
            completed.toList()..sort(),
          );
          if (!saved) throw StateError('Puzzle progress could not be saved');
        } catch (_) {
          // The legacy preferences API updates its cache before the platform
          // confirms the write. Reload so a failed completion cannot appear
          // solved or make a retry incorrectly skip its backend write.
          await preferences.reload();
          rethrow;
        }
        return true;
      });
}

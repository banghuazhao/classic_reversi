import 'dart:convert';

import 'package:classic_reversi/daily_challenge.dart';
import 'package:classic_reversi/game_board.dart';
import 'package:classic_reversi/game_model.dart';
import 'package:classic_reversi/game_session.dart';
import 'package:classic_reversi/game_settings.dart';
import 'package:classic_reversi/match_library.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
// The existing preferences plugin exposes failed-write responses through its
// platform contract; no additional runtime dependency is needed for this fake.
// ignore: depend_on_referenced_packages
import 'package:shared_preferences_platform_interface/shared_preferences_platform_interface.dart';

final _startedAt = DateTime(2026, 10, 23, 10, 30);

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await MatchLibraryService.clear();
    await GameSessionService.clear();
  });

  test('an empty library starts with no records', () async {
    expect(await MatchLibraryService.load(), isEmpty);
  });

  test('persisted timestamps use UTC and survive a cold decode with stable IDs',
      () async {
    const settings =
        GameSettings(difficulty: Difficulty.superEasy, twoPlayerMode: true);
    final completedAt = _startedAt.add(const Duration(minutes: 5));
    await MatchLibraryService.saveCompleted(
        settings: settings,
        history: _finish(settings),
        startedAt: _startedAt,
        completedAt: completedAt);
    final original = (await MatchLibraryService.load()).single;
    final preferences = await SharedPreferences.getInstance();
    final key = preferences.getKeys().single;
    final encoded = preferences.getString(key)!;
    final data = jsonDecode(encoded) as Map<String, dynamic>;
    final record = data['matches'].single as Map<String, dynamic>;

    expect(record['startedAt'], _startedAt.toUtc().toIso8601String());
    expect(record['completedAt'], completedAt.toUtc().toIso8601String());
    expect(record['session']['savedAt'], record['startedAt']);
    expect((record['startedAt'] as String).endsWith('Z'), isTrue);
    expect((record['completedAt'] as String).endsWith('Z'), isTrue);
    expect((record['session']['savedAt'] as String).endsWith('Z'), isTrue);

    // Drop the decoded-record cache, then restore exactly the durable payload.
    // UTC strings retain their instant in every system timezone, so validation
    // must derive the same epoch-based identity after reopening the library.
    await preferences.remove(key);
    expect(await MatchLibraryService.load(), isEmpty);
    await preferences.setString(key, encoded);
    final restored = (await MatchLibraryService.load()).single;
    expect(restored.id, original.id);
    expect(restored.startedAt.isUtc, isTrue);
    expect(restored.completedAt.isUtc, isTrue);
    expect(restored.startedAt.isAtSameMomentAs(_startedAt), isTrue);
    expect(restored.completedAt.isAtSameMomentAs(completedAt), isTrue);
    expect(restored.finalModel.board.rows, original.finalModel.board.rows);
  });

  for (final difficulty in [Difficulty.superEasy, Difficulty.hard]) {
    test(
        '${difficulty.boardSize} by ${difficulty.boardSize} completed replay '
        'preserves setup, chronology, final score, and dates', () async {
      final settings = GameSettings(
        difficulty: difficulty,
        twoPlayerMode: false,
        humanColor: PieceType.white,
      );
      final history = _finish(settings);
      final completedAt = _startedAt.add(const Duration(minutes: 8));
      await MatchLibraryService.saveCompleted(
        settings: settings,
        history: history,
        startedAt: _startedAt,
        completedAt: completedAt,
      );

      final records = await MatchLibraryService.load();

      expect(records, hasLength(1));
      final saved = records.single;
      expect(saved.id, isNotEmpty);
      expect(saved.settings.difficulty, difficulty);
      expect(saved.settings.twoPlayerMode, isFalse);
      expect(saved.settings.humanColor, PieceType.white);
      expect(saved.settings.boardSize, difficulty.boardSize);
      expect(saved.startedAt, _startedAt);
      expect(saved.completedAt, completedAt);
      expect(saved.history, hasLength(history.length));
      expect(saved.finalModel.gameIsOver, isTrue);
      expect(saved.finalModel.blackScore, history.last.blackScore);
      expect(saved.finalModel.whiteScore, history.last.whiteScore);
      for (var index = 0; index < history.length; index++) {
        expect(saved.history[index].player, history[index].player);
        expect(saved.history[index].board.rows, history[index].board.rows);
      }
      expect(() => records.clear(), throwsUnsupportedError);
      expect(() => saved.history.clear(), throwsUnsupportedError);
    });
  }

  test('daily replay remains saved with its original challenge date and setup',
      () async {
    final settings = DailyChallenge.settingsForToday(_startedAt);
    await MatchLibraryService.saveCompleted(
      settings: settings,
      history: _finish(settings),
      startedAt: _startedAt,
      completedAt: _startedAt.add(const Duration(days: 1)),
    );

    final saved = (await MatchLibraryService.load()).single;

    expect(saved.settings.isDailyChallenge, isTrue);
    expect(saved.settings.initialBoard!.rows, settings.initialBoard!.rows);
    expect(saved.settings.initialPlayer, settings.initialPlayer);
    expect(saved.startedAt, _startedAt);
    expect(saved.history.first.board.rows, settings.initialBoard!.rows);
    expect(saved.finalModel.gameIsOver, isTrue);
  });

  test('unfinished and empty games are never added', () async {
    const settings =
        GameSettings(difficulty: Difficulty.easy, twoPlayerMode: true);
    await MatchLibraryService.saveCompleted(
      settings: settings,
      history: [],
      startedAt: _startedAt,
    );
    await MatchLibraryService.saveCompleted(
      settings: settings,
      history: [GameModel.initial()],
      startedAt: _startedAt,
    );

    expect(await MatchLibraryService.load(), isEmpty);
  });

  test('completed history must consist of legal moves from its starting board',
      () async {
    const settings =
        GameSettings(difficulty: Difficulty.easy, twoPlayerMode: true);
    final history = _finish(settings);
    final corrupted = [history.first, history.last];

    await expectLater(
        MatchLibraryService.saveCompleted(
          settings: settings,
          history: corrupted,
          startedAt: _startedAt,
        ),
        throwsFormatException);
    expect(await MatchLibraryService.load(), isEmpty);
  });

  test(
      'repeated terminal callbacks save one record and retain the first finish time',
      () async {
    const settings =
        GameSettings(difficulty: Difficulty.superEasy, twoPlayerMode: true);
    final history = _finish(settings);
    final firstFinish = _startedAt.add(const Duration(minutes: 1));
    await Future.wait([
      MatchLibraryService.saveCompleted(
          settings: settings,
          history: history,
          startedAt: _startedAt,
          completedAt: firstFinish),
      MatchLibraryService.saveCompleted(
          settings: settings,
          history: history,
          startedAt: _startedAt,
          completedAt: firstFinish.add(const Duration(minutes: 1))),
    ]);

    final saved = await MatchLibraryService.load();
    expect(saved, hasLength(1));
    expect(saved.single.completedAt, firstFinish);
  });

  test('library orders newest completion first rather than callback order',
      () async {
    const settings =
        GameSettings(difficulty: Difficulty.superEasy, twoPlayerMode: true);
    final history = _finish(settings);
    for (final minutes in [3, 1, 2]) {
      await MatchLibraryService.saveCompleted(
        settings: settings,
        history: history,
        startedAt: _startedAt.add(Duration(minutes: minutes)),
        completedAt: _startedAt.add(Duration(minutes: minutes + 1)),
      );
    }

    final records = await MatchLibraryService.load();
    expect(records.map((record) => record.startedAt), [
      _startedAt.add(const Duration(minutes: 3)),
      _startedAt.add(const Duration(minutes: 2)),
      _startedAt.add(const Duration(minutes: 1)),
    ]);
  });

  test('retention keeps only the newest hundred completed games', () async {
    const settings =
        GameSettings(difficulty: Difficulty.superEasy, twoPlayerMode: true);
    final history = _finish(settings);
    // Seed 100 valid saved entries to exercise the boundary without repeatedly
    // rewriting every board in the library during test setup.
    await MatchLibraryService.saveCompleted(
        settings: settings,
        history: history,
        startedAt: _startedAt,
        completedAt: _startedAt.add(const Duration(seconds: 1)));
    final preferences = await SharedPreferences.getInstance();
    final key = preferences.getKeys().single;
    final stored =
        jsonDecode(preferences.getString(key)!) as Map<String, dynamic>;
    final template = stored['matches'].single as Map<String, dynamic>;
    final records = <Map<String, dynamic>>[];
    final idSuffix = (template['id'] as String)
        .substring((template['id'] as String).indexOf('-'));
    for (var index = 0; index < MatchLibraryService.maxSavedMatches; index++) {
      final started = _startedAt.add(Duration(minutes: index));
      final entry = jsonDecode(jsonEncode(template)) as Map<String, dynamic>;
      entry['id'] = '${started.microsecondsSinceEpoch}$idSuffix';
      entry['startedAt'] = started.toIso8601String();
      entry['completedAt'] =
          started.add(const Duration(seconds: 1)).toIso8601String();
      entry['session']['savedAt'] = started.toIso8601String();
      records.add(entry);
    }
    stored['matches'] = records;
    await preferences.setString(key, jsonEncode(stored));
    final newestStart = _startedAt.add(const Duration(minutes: 100));
    await MatchLibraryService.saveCompleted(
        settings: settings,
        history: history,
        startedAt: newestStart,
        completedAt: newestStart.add(const Duration(seconds: 1)));

    final saved = await MatchLibraryService.load();
    expect(saved, hasLength(MatchLibraryService.maxSavedMatches));
    expect(saved.first.startedAt, newestStart);
    expect(saved.last.startedAt, _startedAt.add(const Duration(minutes: 1)));
  });

  test('deleting a replay preserves other replays and the active match',
      () async {
    const settings =
        GameSettings(difficulty: Difficulty.superEasy, twoPlayerMode: true);
    final history = _finish(settings);
    await GameSessionService.save(
        GameSession(settings: settings, timeline: history.take(3).toList()));
    for (var index = 0; index < 2; index++) {
      await MatchLibraryService.saveCompleted(
          settings: settings,
          history: history,
          startedAt: _startedAt.add(Duration(minutes: index)));
    }
    final before = await MatchLibraryService.load();
    await MatchLibraryService.remove(before.first.id);

    final remaining = await MatchLibraryService.load();
    expect(remaining.single.id, before.last.id);
    expect((await GameSessionService.load())!.timeline, hasLength(3));
    await MatchLibraryService.clear();
    expect(await MatchLibraryService.load(), isEmpty);
    expect((await GameSessionService.load())!.timeline, hasLength(3));
  });

  test('queued save and deletion cannot resurrect a deleted replay', () async {
    const settings =
        GameSettings(difficulty: Difficulty.superEasy, twoPlayerMode: true);
    final history = _finish(settings);
    await MatchLibraryService.saveCompleted(
        settings: settings, history: history, startedAt: _startedAt);
    final id = (await MatchLibraryService.load()).single.id;
    await Future.wait([
      MatchLibraryService.saveCompleted(
          settings: settings, history: history, startedAt: _startedAt),
      MatchLibraryService.remove(id),
    ]);
    expect(await MatchLibraryService.load(), isEmpty);
  });

  test('a damaged record does not hide the valid replay beside it', () async {
    const settings =
        GameSettings(difficulty: Difficulty.superEasy, twoPlayerMode: true);
    final history = _finish(settings);
    await MatchLibraryService.saveCompleted(
        settings: settings, history: history, startedAt: _startedAt);
    final preferences = await SharedPreferences.getInstance();
    final key = preferences.getKeys().single;
    final stored =
        jsonDecode(preferences.getString(key)!) as Map<String, dynamic>;
    final valid = stored['matches'].single;
    final invalid = jsonDecode(jsonEncode(valid)) as Map<String, dynamic>;
    invalid['session']['timeline'][1]['board'][0] = ['black'];
    stored['matches'] = [invalid, null, valid];
    await preferences.setString(key, jsonEncode(stored));

    final saved = await MatchLibraryService.load();
    expect(saved, hasLength(1));
    expect(saved.single.finalModel.board.rows, history.last.board.rows);
  });

  for (final corruption in <String, void Function(Map<String, dynamic>)>{
    'unknown version': (data) => data['version'] = 2,
    'wrong entries type': (data) => data['matches'] = {},
    'invalid date': (data) => data['matches'][0]['startedAt'] = 'yesterday',
    'completion before start': (data) =>
        data['matches'][0]['completedAt'] = DateTime(2000).toIso8601String(),
    'wrong identity': (data) => data['matches'][0]['id'] = 'unrelated',
    'mismatched session date': (data) => data['matches'][0]['session']
        ['savedAt'] = DateTime(2000).toIso8601String(),
    'ongoing replay': (data) =>
        (data['matches'][0]['session']['timeline'] as List).removeLast(),
    'illegal move': (data) =>
        data['matches'][0]['session']['timeline'][1]['player'] = 'empty',
  }.entries) {
    test('rejects ${corruption.key} without affecting active recovery',
        () async {
      const settings =
          GameSettings(difficulty: Difficulty.superEasy, twoPlayerMode: true);
      await MatchLibraryService.saveCompleted(
          settings: settings,
          history: _finish(settings),
          startedAt: _startedAt);
      final preferences = await SharedPreferences.getInstance();
      final key = preferences.getKeys().single;
      final stored =
          jsonDecode(preferences.getString(key)!) as Map<String, dynamic>;
      corruption.value(stored);
      await preferences.setString(key, jsonEncode(stored));
      await GameSessionService.save(GameSession(
          settings: settings,
          timeline: [GameModel.initial(boardSize: settings.boardSize)]));

      expect(await MatchLibraryService.load(), isEmpty);
      expect(await GameSessionService.load(), isNotNull);
    });
  }

  test('malformed JSON and wrong preference types are safe to load', () async {
    const settings =
        GameSettings(difficulty: Difficulty.superEasy, twoPlayerMode: true);
    await MatchLibraryService.saveCompleted(
        settings: settings, history: _finish(settings), startedAt: _startedAt);
    final preferences = await SharedPreferences.getInstance();
    final key = preferences.getKeys().single;
    await preferences.setString(key, '{broken');
    expect(await MatchLibraryService.load(), isEmpty);
    await preferences.setInt(key, 4);
    expect(await MatchLibraryService.load(), isEmpty);
  });

  test('a false platform write is reported and the queue recovers', () async {
    final store = _FailingPreferencesStore()..failWrites = true;
    SharedPreferencesStorePlatform.instance = store;
    const settings =
        GameSettings(difficulty: Difficulty.superEasy, twoPlayerMode: true);
    final history = _finish(settings);

    await expectLater(
        MatchLibraryService.saveCompleted(
            settings: settings, history: history, startedAt: _startedAt),
        throwsStateError);
    final preferences = await SharedPreferences.getInstance();
    expect(await MatchLibraryService.load(), isEmpty);
    expect(await store.getAll(), isEmpty);

    store.failWrites = false;
    await MatchLibraryService.saveCompleted(
        settings: settings, history: history, startedAt: _startedAt);
    // A reload after success proves the retry reached platform storage rather
    // than deduplicating the optimistic entry left by the failed attempt.
    await preferences.reload();
    expect(await MatchLibraryService.load(), hasLength(1));
  });

  test(
      'a false delete or clear response is reported without losing the persisted replay',
      () async {
    final store = _FailingPreferencesStore();
    SharedPreferencesStorePlatform.instance = store;
    const settings =
        GameSettings(difficulty: Difficulty.superEasy, twoPlayerMode: true);
    await MatchLibraryService.saveCompleted(
        settings: settings, history: _finish(settings), startedAt: _startedAt);
    final saved = (await MatchLibraryService.load()).single;

    store.failRemovals = true;
    await expectLater(MatchLibraryService.remove(saved.id), throwsStateError);
    expect((await MatchLibraryService.load()).single.id, saved.id);
    await expectLater(MatchLibraryService.clear(), throwsStateError);
    expect((await MatchLibraryService.load()).single.id, saved.id);

    store.failRemovals = false;
    await MatchLibraryService.remove(saved.id);
    expect(await MatchLibraryService.load(), isEmpty);
  });
}

class _FailingPreferencesStore extends InMemorySharedPreferencesStore {
  _FailingPreferencesStore() : super.empty();

  bool failWrites = false;
  bool failRemovals = false;

  @override
  Future<bool> setValue(String valueType, String key, Object value) =>
      failWrites ? Future.value(false) : super.setValue(valueType, key, value);

  @override
  Future<bool> remove(String key) =>
      failRemovals ? Future.value(false) : super.remove(key);
}

List<GameModel> _finish(GameSettings settings) {
  final history = [
    GameModel.initial(
      board: settings.initialBoard,
      player: settings.initialPlayer,
      boardSize: settings.boardSize,
    )
  ];
  while (!history.last.gameIsOver) {
    final model = history.last;
    final move = model.board.getMovesForPlayer(model.player).first;
    history.add(model.updateForMove(move.x, move.y)!);
  }
  return history;
}

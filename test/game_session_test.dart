import 'dart:convert';

import 'package:classic_reversi/daily_challenge.dart';
import 'package:classic_reversi/game_board.dart';
import 'package:classic_reversi/game_model.dart';
import 'package:classic_reversi/game_session.dart';
import 'package:classic_reversi/game_settings.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await GameSessionService.clear();
  });

  test('sessions keep an immutable copy of their history lists', () {
    final models = [GameModel.initial()];
    final history = <GameModel>[];
    final session = GameSession(
      settings: _settings(),
      timeline: models,
      undoHistory: history,
    );
    models.clear();
    history.add(GameModel.initial());

    expect(session.timeline, hasLength(1));
    expect(session.undoHistory, isEmpty);
    expect(() => session.timeline.clear(), throwsUnsupportedError);
    expect(() => session.undoHistory.clear(), throwsUnsupportedError);
    expect(
      () => GameSession(settings: _settings(), timeline: []),
      throwsArgumentError,
    );
  });

  for (final difficulty in [Difficulty.superEasy, Difficulty.hard]) {
    test(
        '${difficulty.boardSize} by ${difficulty.boardSize} match resumes '
        'with moves, undo, and reward state', () async {
      final settings = _settings(difficulty: difficulty);
      final played = _play(settings, 4);
      final savedAt = DateTime.now().subtract(const Duration(hours: 2));
      final session = GameSession(
        settings: settings,
        timeline: played.timeline,
        undoHistory: [played.timeline[0], played.timeline[2]],
        lastMove: played.lastMove,
        canUndo: true,
        hintsUnlocked: true,
        rewardedUndoCharges: 2,
        savedAt: savedAt,
      );

      await GameSessionService.save(session);
      final restored = await GameSessionService.load();

      expect(restored, isNotNull);
      expect(restored!.settings.difficulty, difficulty);
      expect(restored.settings.boardSize, difficulty.boardSize);
      expect(restored.settings.twoPlayerMode, isTrue);
      expect(restored.settings.humanColor, PieceType.white);
      expect(restored.settings.isDailyChallenge, isFalse);
      expect(restored.timeline, hasLength(5));
      expect(restored.undoHistory, hasLength(2));
      expect(restored.canUndo, isTrue);
      expect(restored.hintsUnlocked, isTrue);
      expect(restored.rewardedUndoCharges, 2);
      expect(restored.savedAt, savedAt);
      expect(restored.lastMove!.x, played.lastMove!.x);
      expect(restored.lastMove!.y, played.lastMove!.y);
      for (var index = 0; index < played.timeline.length; index++) {
        _expectModel(restored.timeline[index], played.timeline[index]);
      }
      _expectModel(restored.undoHistory[1], played.timeline[2]);

      // Verify the restored turn can produce the same next board.
      final move =
          session.model.board.getMovesForPlayer(session.model.player).first;
      _expectModel(
        restored.model.updateForMove(move.x, move.y)!,
        session.model.updateForMove(move.x, move.y)!,
      );
    });
  }

  test(
    'daily resume preserves its original board and player for restart',
    () async {
      final settings = DailyChallenge.settingsForToday();
      final played = _play(settings, 4);
      final session = GameSession(
        settings: settings,
        timeline: played.timeline,
        undoHistory: [played.timeline.first],
        lastMove: played.lastMove,
        canUndo: true,
      );
      await GameSessionService.save(session);

      final restored = await GameSessionService.load();

      expect(restored, isNotNull);
      expect(restored!.settings.isDailyChallenge, isTrue);
      expect(restored.settings.twoPlayerMode, isFalse);
      expect(restored.settings.initialPlayer, settings.initialPlayer);
      expect(restored.settings.initialBoard!.rows, settings.initialBoard!.rows);
      _expectModel(restored.model, played.timeline.last);
      _expectModel(
        GameModel.initial(
          board: restored.settings.initialBoard,
          player: restored.settings.initialPlayer,
        ),
        played.timeline.first,
      );
    },
  );

  test('daily sessions expire on the next local date', () async {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    final settings = DailyChallenge.settingsForToday(yesterday);
    await GameSessionService.save(
      GameSession(
        settings: settings,
        timeline: _play(settings, 2).timeline,
        savedAt: yesterday,
      ),
    );

    expect(await GameSessionService.load(), isNull);
    expect((await SharedPreferences.getInstance()).getKeys(), isEmpty);
  });

  test('ordinary matches remain available after their original date', () async {
    final settings = _settings();
    await GameSessionService.save(
      GameSession(
        settings: settings,
        timeline: _play(settings, 2).timeline,
        savedAt: DateTime.now().subtract(const Duration(days: 7)),
      ),
    );

    expect(await GameSessionService.load(), isNotNull);
  });

  test('a completed match is never offered for continuation', () async {
    final settings = _settings();
    final timeline = _play(settings, 60).timeline;
    expect(timeline.last.gameIsOver, isTrue);
    await GameSessionService.save(
      GameSession(settings: settings, timeline: timeline),
    );

    expect(await GameSessionService.load(), isNull);
    expect((await SharedPreferences.getInstance()).getKeys(), isEmpty);
  });

  test('queued saves and clear preserve invocation order', () async {
    final settings = _settings();
    final first = GameSession(
      settings: settings,
      timeline: _play(settings, 1).timeline,
    );
    final second = GameSession(
      settings: settings,
      timeline: _play(settings, 2).timeline,
    );

    await Future.wait([
      GameSessionService.save(first),
      GameSessionService.save(second),
      GameSessionService.clear(),
    ]);
    expect(await GameSessionService.load(), isNull);

    await Future.wait([
      GameSessionService.save(first),
      GameSessionService.clear(),
      GameSessionService.save(second),
    ]);
    _expectModel((await GameSessionService.load())!.model, second.model);
  });

  final corruptions = <String, void Function(Map<String, dynamic>)>{
    'unsupported version': (data) => data['version'] = 99,
    'noninteger version': (data) => data['version'] = 1.0,
    'missing settings': (data) => data.remove('settings'),
    'unknown difficulty': (data) => data['settings']['difficulty'] = 'expert',
    'empty human color': (data) => data['settings']['humanColor'] = 'empty',
    'unsupported size': (data) => data['settings']['boardSize'] = 7,
    'inconsistent size': (data) => data['settings']['boardSize'] = 6,
    'wrong boolean type': (data) => data['canUndo'] = 'true',
    'empty timeline': (data) => data['timeline'] = [],
    'unbounded timeline': (data) =>
        data['timeline'] = List.filled(1000, data['timeline'][0]),
    'nonobject model': (data) => data['timeline'][0] = null,
    'short board row': (data) => data['timeline'][0]['board'][0] = ['black'],
    'unknown board piece': (data) => data['timeline'][0]['board'][0][0] = 'red',
    'empty active player': (data) => data['timeline'][0]['player'] = 'empty',
    'wrong active player': (data) => data['timeline'][1]['player'] = 'black',
    'invalid initial position': (data) =>
        data['timeline'][0]['board'][0][0] = 'black',
    'impossible move history': (data) =>
        data['timeline'][1] = data['timeline'][0],
    'undo outside timeline': (data) =>
        data['undoHistory'] = [data['timeline'].last],
    'undo without history': (data) {
      data['canUndo'] = true;
      data['undoHistory'] = [];
    },
    'negative reward count': (data) => data['rewardedUndoCharges'] = -1,
    'fractional reward count': (data) => data['rewardedUndoCharges'] = 1.5,
    'out of range last move': (data) => data['lastMove'] = {'x': 8, 'y': 0},
    'unoccupied last move': (data) => data['lastMove'] = {'x': 0, 'y': 0},
    'invalid date': (data) => data['savedAt'] = '2026-99-99',
    'missing daily starting position': (data) =>
        data['settings']['isDailyChallenge'] = true,
  };
  for (final corruption in corruptions.entries) {
    test('rejects and clears ${corruption.key}', () async {
      final settings = _settings();
      await GameSessionService.save(
        GameSession(settings: settings, timeline: _play(settings, 2).timeline),
      );
      final preferences = await SharedPreferences.getInstance();
      final key = preferences.getKeys().single;
      final encoded =
          jsonDecode(preferences.getString(key)!) as Map<String, dynamic>;
      corruption.value(encoded);
      await preferences.setString(key, jsonEncode(encoded));

      expect(await GameSessionService.load(), isNull);
      expect(preferences.containsKey(key), isFalse);
    });
  }

  test('invalid JSON and wrong preference types fail gracefully', () async {
    final settings = _settings();
    await GameSessionService.save(
      GameSession(settings: settings, timeline: _play(settings, 2).timeline),
    );
    final preferences = await SharedPreferences.getInstance();
    final key = preferences.getKeys().single;
    await preferences.setString(key, '{unfinished');
    expect(await GameSessionService.load(), isNull);
    await preferences.setInt(key, 7);
    expect(await GameSessionService.load(), isNull);
    expect(preferences.containsKey(key), isFalse);
  });
}

GameSettings _settings({Difficulty difficulty = Difficulty.hard}) =>
    GameSettings(
      difficulty: difficulty,
      twoPlayerMode: true,
      humanColor: PieceType.white,
    );

({List<GameModel> timeline, Position? lastMove}) _play(
  GameSettings settings,
  int moves,
) {
  final timeline = [
    GameModel.initial(
      board: settings.initialBoard,
      player: settings.initialPlayer,
      boardSize: settings.boardSize,
    ),
  ];
  Position? lastMove;
  for (var index = 0; index < moves && !timeline.last.gameIsOver; index++) {
    final model = timeline.last;
    lastMove = model.board.getMovesForPlayer(model.player).first;
    timeline.add(model.updateForMove(lastMove.x, lastMove.y)!);
  }
  return (timeline: timeline, lastMove: lastMove);
}

void _expectModel(GameModel actual, GameModel expected) {
  expect(actual.player, expected.player);
  expect(actual.board.size, expected.board.size);
  expect(actual.board.rows, expected.board.rows);
}

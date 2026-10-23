import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ignore: depend_on_referenced_packages
import 'package:shared_preferences_platform_interface/shared_preferences_platform_interface.dart';

import 'package:classic_reversi/achievements_service.dart';
import 'package:classic_reversi/game_board.dart';
import 'package:classic_reversi/game_model.dart';
import 'package:classic_reversi/game_settings.dart';
import 'package:classic_reversi/settings_service.dart';

GameModel _modelWithScores({required int black, required int white}) {
  final rows = List.generate(
    8,
    (_) => List.filled(8, PieceType.empty, growable: false),
    growable: false,
  );
  var placedBlack = 0;
  var placedWhite = 0;
  for (var y = 0; y < 8; y++) {
    for (var x = 0; x < 8; x++) {
      if (placedBlack < black) {
        rows[y][x] = PieceType.black;
        placedBlack++;
      } else if (placedWhite < white) {
        rows[y][x] = PieceType.white;
        placedWhite++;
      }
    }
  }
  return GameModel(board: GameBoard.fromRows(rows), player: PieceType.empty);
}

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test('winning unlocks first win and records streak', () async {
    final unlocked = await AchievementsService.instance.recordGameOver(
      model: _modelWithScores(black: 40, white: 24),
      settings: const GameSettings(
        difficulty: Difficulty.easy,
        twoPlayerMode: false,
        humanColor: PieceType.black,
      ),
    );

    expect(unlocked, contains(AchievementId.firstWin));
    final stats = await AchievementsService.instance.loadStats();
    expect(stats.wins, 1);
    expect(stats.currentStreak, 1);
    expect(stats.winsEasy, 1);
  });

  test('hard win unlocks hard achievement', () async {
    final unlocked = await AchievementsService.instance.recordGameOver(
      model: _modelWithScores(black: 35, white: 29),
      settings: const GameSettings(
        difficulty: Difficulty.hard,
        twoPlayerMode: false,
        humanColor: PieceType.black,
      ),
    );

    expect(unlocked, contains(AchievementId.winHard));
  });

  test('two-player games do not affect stats', () async {
    final unlocked = await AchievementsService.instance.recordGameOver(
      model: _modelWithScores(black: 40, white: 24),
      settings: const GameSettings(
        difficulty: Difficulty.hard,
        twoPlayerMode: true,
        humanColor: PieceType.black,
      ),
    );

    expect(unlocked, isEmpty);
    final stats = await AchievementsService.instance.loadStats();
    expect(stats.gamesPlayed, 0);
    expect(stats.wins, 0);
  });

  test('daily rematch after completion does not inflate wins', () async {
    final first = await AchievementsService.instance.recordGameOver(
      model: _modelWithScores(black: 40, white: 24),
      settings: const GameSettings(
        difficulty: Difficulty.hard,
        twoPlayerMode: false,
        humanColor: PieceType.black,
        isDailyChallenge: true,
      ),
    );
    expect(first, isNotEmpty);

    final rematch = await AchievementsService.instance.recordGameOver(
      model: _modelWithScores(black: 40, white: 24),
      settings: const GameSettings(
        difficulty: Difficulty.hard,
        twoPlayerMode: false,
        humanColor: PieceType.black,
        isDailyChallenge: true,
      ),
    );
    expect(rematch, isEmpty);

    final stats = await AchievementsService.instance.loadStats();
    expect(stats.wins, 1);
    expect(stats.gamesPlayed, 1);
  });

  test('simultaneous outcomes keep every win and a consistent streak',
      () async {
    const settings =
        GameSettings(difficulty: Difficulty.easy, twoPlayerMode: false);
    final model = _modelWithScores(black: 40, white: 24);
    await Future.wait(List.generate(
        3,
        (_) => AchievementsService.instance.recordGameOver(
              model: model,
              settings: settings,
            )));
    final stats = await AchievementsService.instance.loadStats();
    expect(stats.wins, 3);
    expect(stats.gamesPlayed, 3);
    expect(stats.currentStreak, 3);
    expect(stats.bestStreak, 3);
    expect(stats.winsEasy, 3);
    expect(stats.unlockedAchievements, contains(AchievementId.winStreak3.name));
  });

  test('simultaneous daily completions only credit one win', () async {
    final date = DateTime(2026, 10, 24);
    final settings = GameSettings(
        difficulty: Difficulty.hard,
        twoPlayerMode: false,
        isDailyChallenge: true,
        dailyChallengeDate: date);
    final model = _modelWithScores(black: 40, white: 24);
    await Future.wait([
      AchievementsService.instance
          .recordGameOver(model: model, settings: settings),
      AchievementsService.instance
          .recordGameOver(model: model, settings: settings),
    ]);
    final stats = await AchievementsService.instance.loadStats();
    expect(stats.wins, 1);
    expect(stats.gamesPlayed, 1);
    expect(stats.dailyCompletions, 1);
  });

  test(
      'finishing an older daily puzzle never replaces today or credits it twice',
      () async {
    final today = DateTime.now();
    final yesterday = DateTime(today.year, today.month, today.day - 1);
    GameSettings daily(DateTime date) => GameSettings(
        difficulty: Difficulty.hard,
        twoPlayerMode: false,
        isDailyChallenge: true,
        dailyChallengeDate: date);
    final model = _modelWithScores(black: 40, white: 24);
    await AchievementsService.instance
        .recordGameOver(model: model, settings: daily(today));
    await AchievementsService.instance.recordGameOver(
        model: model, settings: daily(yesterday), playedAt: today);
    expect(await SettingsService.isDailyCompletedToday(), isTrue);
    expect(await SettingsService.isDailyCompletedOn(yesterday), isTrue);
    await AchievementsService.instance.recordGameOver(
        model: model,
        settings: daily(yesterday),
        playedAt: today.add(const Duration(hours: 1)));
    final stats = await AchievementsService.instance.loadStats();
    expect(stats.wins, 2);
    expect(stats.gamesPlayed, 2);
    expect(stats.dailyCompletions, 2);
  });

  test('unfinished positions never change statistics', () async {
    expect(
        await AchievementsService.instance.recordGameOver(
            model: GameModel.initial(),
            settings: const GameSettings(
                difficulty: Difficulty.easy, twoPlayerMode: false)),
        isEmpty);
    expect((await AchievementsService.instance.loadStats()).gamesPlayed, 0);
  });

  test(
      'rejected daily completion changes no statistics and a retry counts once',
      () async {
    final store = _DailyCompletionRejectingStore();
    SharedPreferencesStorePlatform.instance = store;
    final settings = GameSettings(
        difficulty: Difficulty.hard,
        twoPlayerMode: false,
        isDailyChallenge: true,
        dailyChallengeDate: DateTime.now());
    final model = _modelWithScores(black: 40, white: 24);

    await expectLater(
        AchievementsService.instance
            .recordGameOver(model: model, settings: settings),
        throwsStateError);
    final failed = await AchievementsService.instance.loadStats();
    expect(failed.gamesPlayed, 0);
    expect(failed.wins, 0);
    expect(failed.winsHard, 0);
    expect(failed.currentStreak, 0);
    expect(failed.bestStreak, 0);
    expect(failed.dailyCompletions, 0);
    expect(failed.unlockedAchievements, isEmpty);
    expect(await SettingsService.getHasWonOnce(), isFalse);
    expect(await store.getAll(), isEmpty);

    store.rejectDailyWrite = false;
    await AchievementsService.instance
        .recordGameOver(model: model, settings: settings);
    await AchievementsService.instance
        .recordGameOver(model: model, settings: settings);
    final retried = await AchievementsService.instance.loadStats();
    expect(retried.gamesPlayed, 1);
    expect(retried.wins, 1);
    expect(retried.winsHard, 1);
    expect(retried.currentStreak, 1);
    expect(retried.dailyCompletions, 1);
    expect(retried.unlockedAchievements,
        contains(AchievementId.dailyChallenge.name));
  });
}

class _DailyCompletionRejectingStore extends InMemorySharedPreferencesStore {
  _DailyCompletionRejectingStore() : super.empty();
  bool rejectDailyWrite = true;

  @override
  Future<bool> setValue(String valueType, String key, Object value) =>
      rejectDailyWrite && key.endsWith('dailyCompletionState')
          ? Future.value(false)
          : super.setValue(valueType, key, value);
}

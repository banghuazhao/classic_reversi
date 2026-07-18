import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:classic_reversi/achievements_service.dart';
import 'package:classic_reversi/game_board.dart';
import 'package:classic_reversi/game_model.dart';
import 'package:classic_reversi/game_settings.dart';

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
}

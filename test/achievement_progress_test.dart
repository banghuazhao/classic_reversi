import 'package:classic_reversi/achievement_progress.dart';
import 'package:classic_reversi/achievements_service.dart';
import 'package:flutter_test/flutter_test.dart';

PlayerStats stats(
        {int wins = 0,
        int games = 0,
        int streak = 0,
        int hard = 0,
        int perfect = 0,
        int daily = 0,
        Set<String> unlocked = const {}}) =>
    PlayerStats(
      wins: wins,
      losses: 0,
      ties: 0,
      gamesPlayed: games,
      currentStreak: streak,
      bestStreak: streak,
      winsSuperEasy: 0,
      winsEasy: 0,
      winsMedium: 0,
      winsHard: hard,
      perfectWins: perfect,
      dailyCompletions: daily,
      unlockedAchievements: unlocked,
    );

void main() {
  test('first win is the first milestone for a new player', () {
    final next = AchievementProgress.nextMilestone(stats())!;
    expect(next.id, AchievementId.firstWin);
    expect(next.current, 0);
    expect(next.target, 1);
    expect(next.completed, isFalse);
  });

  test('seven games show measurable progress toward ten games', () {
    final next = AchievementProgress.nextMilestone(stats(games: 7))!;
    expect(next.id, AchievementId.games10);
    expect(next.current, 7);
    expect(next.target, 10);
    expect(next.fraction, closeTo(0.7, 0.001));
  });

  test('an earned streak stays complete after a loss resets current streak',
      () {
    final goals = AchievementProgress.forStats(
        stats(streak: 0, unlocked: {AchievementId.winStreak3.storageKey}));
    final earned =
        goals.singleWhere((goal) => goal.id == AchievementId.winStreak3);
    expect(earned.completed, isTrue);
    expect(earned.current, 3);
    final pending =
        goals.singleWhere((goal) => goal.id == AchievementId.winStreak5);
    expect(pending.completed, isFalse);
    expect(pending.current, 0);
  });

  test('legacy totals reaching a goal are treated as earned', () {
    final goals =
        AchievementProgress.forStats(stats(games: 80, wins: 12, hard: 2));
    expect(goals.singleWhere((g) => g.id == AchievementId.games50).current, 50);
    expect(goals.singleWhere((g) => g.id == AchievementId.firstWin).completed,
        isTrue);
    expect(goals.singleWhere((g) => g.id == AchievementId.winHard).completed,
        isTrue);
  });

  test('a player with all milestones has no next goal', () {
    expect(
        AchievementProgress.nextMilestone(stats(
          unlocked: AchievementId.values.map((id) => id.storageKey).toSet(),
        )),
        isNull);
  });
}

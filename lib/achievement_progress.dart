import 'achievements_service.dart';

enum AchievementMetric { wins, streak, hardWins, perfectWins, dailyWins, games }

/// A milestone derived from recorded results. Earned streaks remain complete
/// even when a later loss resets the current streak.
class AchievementProgress {
  const AchievementProgress({
    required this.id,
    required this.metric,
    required this.current,
    required this.target,
    required this.completed,
  });

  final AchievementId id;
  final AchievementMetric metric;
  final int current;
  final int target;
  final bool completed;

  double get fraction => (current / target).clamp(0, 1);

  static List<AchievementProgress> forStats(PlayerStats stats) {
    AchievementProgress goal(
        AchievementId id, AchievementMetric metric, int value, int target) {
      final completed =
          stats.unlockedAchievements.contains(id.storageKey) || value >= target;
      return AchievementProgress(
        id: id,
        metric: metric,
        current: completed ? target : value.clamp(0, target),
        target: target,
        completed: completed,
      );
    }

    return [
      goal(AchievementId.firstWin, AchievementMetric.wins, stats.wins, 1),
      goal(AchievementId.winStreak3, AchievementMetric.streak,
          stats.currentStreak, 3),
      goal(AchievementId.winStreak5, AchievementMetric.streak,
          stats.currentStreak, 5),
      goal(
          AchievementId.winHard, AchievementMetric.hardWins, stats.winsHard, 1),
      goal(AchievementId.perfectGame, AchievementMetric.perfectWins,
          stats.perfectWins, 1),
      goal(AchievementId.dailyChallenge, AchievementMetric.dailyWins,
          stats.dailyCompletions, 1),
      goal(AchievementId.games10, AchievementMetric.games, stats.gamesPlayed,
          10),
      goal(AchievementId.games50, AchievementMetric.games, stats.gamesPlayed,
          50),
    ];
  }

  static AchievementProgress? nextMilestone(PlayerStats stats) {
    final pending = forStats(stats).where((goal) => !goal.completed).toList();
    if (pending.isEmpty) return null;
    // Preserve achievement display order for ties, making the first win the
    // natural goal for a new player.
    pending.sort((a, b) {
      final comparison = b.fraction.compareTo(a.fraction);
      return comparison != 0 ? comparison : a.id.index.compareTo(b.id.index);
    });
    return pending.first;
  }
}

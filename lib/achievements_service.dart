import 'package:flutter/widgets.dart';

import 'game_board.dart';
import 'game_model.dart';
import 'game_settings.dart';
import 'generated/l10n.dart';
import 'settings_service.dart';

enum AchievementId {
  firstWin,
  winStreak3,
  winStreak5,
  winHard,
  perfectGame,
  dailyChallenge,
  games10,
  games50,
}

extension AchievementIdX on AchievementId {
  String get storageKey => name;

  String title(BuildContext context) {
    final s = S.of(context);
    switch (this) {
      case AchievementId.firstWin:
        return s.AchFirstWin;
      case AchievementId.winStreak3:
        return s.AchWinStreak3;
      case AchievementId.winStreak5:
        return s.AchWinStreak5;
      case AchievementId.winHard:
        return s.AchWinHard;
      case AchievementId.perfectGame:
        return s.AchPerfectGame;
      case AchievementId.dailyChallenge:
        return s.AchDailyChallenge;
      case AchievementId.games10:
        return s.AchGames10;
      case AchievementId.games50:
        return s.AchGames50;
    }
  }
}

class PlayerStats {
  final int wins;
  final int losses;
  final int ties;
  final int gamesPlayed;
  final int currentStreak;
  final int bestStreak;
  final int winsEasy;
  final int winsMedium;
  final int winsHard;
  final int perfectWins;
  final int dailyCompletions;
  final Set<String> unlockedAchievements;

  const PlayerStats({
    required this.wins,
    required this.losses,
    required this.ties,
    required this.gamesPlayed,
    required this.currentStreak,
    required this.bestStreak,
    required this.winsEasy,
    required this.winsMedium,
    required this.winsHard,
    required this.perfectWins,
    required this.dailyCompletions,
    required this.unlockedAchievements,
  });

  double get winRate {
    final decided = wins + losses;
    if (decided == 0) {
      return 0;
    }
    return wins / decided;
  }
}

/// Records game outcomes and unlocks achievements.
class AchievementsService {
  AchievementsService._();
  static final AchievementsService instance = AchievementsService._();

  Future<PlayerStats> loadStats() async {
    return PlayerStats(
      wins: await SettingsService.getWins(),
      losses: await SettingsService.getLosses(),
      ties: await SettingsService.getTies(),
      gamesPlayed: await SettingsService.getGamesPlayed(),
      currentStreak: await SettingsService.getCurrentStreak(),
      bestStreak: await SettingsService.getBestStreak(),
      winsEasy: await SettingsService.getWinsForDifficulty(Difficulty.easy),
      winsMedium: await SettingsService.getWinsForDifficulty(Difficulty.medium),
      winsHard: await SettingsService.getWinsForDifficulty(Difficulty.hard),
      perfectWins: await SettingsService.getPerfectWins(),
      dailyCompletions: await SettingsService.getDailyCompletions(),
      unlockedAchievements: await SettingsService.getUnlockedAchievements(),
    );
  }

  /// Applies end-of-game bookkeeping. Returns newly unlocked achievement ids.
  Future<List<AchievementId>> recordGameOver({
    required GameModel model,
    required GameSettings settings,
  }) async {
    if (settings.twoPlayerMode) {
      return const [];
    }

    await SettingsService.incrementGamesPlayed();

    final newlyUnlocked = <AchievementId>[];
    Future<void> tryUnlock(AchievementId id) async {
      if (await SettingsService.unlockAchievement(id.storageKey)) {
        newlyUnlocked.add(id);
      }
    }

    final gamesPlayed = await SettingsService.getGamesPlayed();
    if (gamesPlayed >= 10) {
      await tryUnlock(AchievementId.games10);
    }
    if (gamesPlayed >= 50) {
      await tryUnlock(AchievementId.games50);
    }

    final isTie = model.blackScore == model.whiteScore;
    if (isTie) {
      await SettingsService.incrementTies();
      await SettingsService.resetWinStreak();
      return newlyUnlocked;
    }

    final humanWon = model.blackScore > model.whiteScore
        ? settings.humanColor == PieceType.black
        : settings.humanColor == PieceType.white;

    if (humanWon) {
      await SettingsService.incrementWins();
      await SettingsService.incrementWinsForDifficulty(settings.difficulty);
      await SettingsService.recordWinStreak();

      if (!await SettingsService.getHasWonOnce()) {
        await SettingsService.setHasWonOnce();
      }
      await tryUnlock(AchievementId.firstWin);

      final streak = await SettingsService.getCurrentStreak();
      if (streak >= 3) {
        await tryUnlock(AchievementId.winStreak3);
      }
      if (streak >= 5) {
        await tryUnlock(AchievementId.winStreak5);
      }
      if (settings.difficulty == Difficulty.hard) {
        await tryUnlock(AchievementId.winHard);
      }

      final opponentScore = settings.humanColor == PieceType.black
          ? model.whiteScore
          : model.blackScore;
      if (opponentScore == 0) {
        await SettingsService.incrementPerfectWins();
        await tryUnlock(AchievementId.perfectGame);
      }

      if (settings.isDailyChallenge) {
        await SettingsService.markDailyCompletedToday();
        await tryUnlock(AchievementId.dailyChallenge);
      }
    } else {
      await SettingsService.incrementLosses();
      await SettingsService.resetWinStreak();
    }

    return newlyUnlocked;
  }
}

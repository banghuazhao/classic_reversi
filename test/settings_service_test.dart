import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:classic_reversi/app_theme.dart';
import 'package:classic_reversi/game_settings.dart';
import 'package:classic_reversi/settings_service.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test('difficulty defaults to hard and round-trips', () async {
    expect(await SettingsService.getDifficulty(), Difficulty.hard);

    await SettingsService.setDifficulty(Difficulty.easy);
    expect(await SettingsService.getDifficulty(), Difficulty.easy);

    await SettingsService.setDifficulty(Difficulty.superEasy);
    expect(await SettingsService.getDifficulty(), Difficulty.superEasy);
  });

  test('first player defaults to human and round-trips', () async {
    expect(await SettingsService.getFirstPlayer(), FirstPlayer.human);

    await SettingsService.setFirstPlayer(FirstPlayer.random);
    expect(await SettingsService.getFirstPlayer(), FirstPlayer.random);
  });

  test('wins and losses start at zero and increment independently', () async {
    expect(await SettingsService.getWins(), 0);
    expect(await SettingsService.getLosses(), 0);

    await SettingsService.incrementWins();
    await SettingsService.incrementWins();
    await SettingsService.incrementLosses();

    expect(await SettingsService.getWins(), 2);
    expect(await SettingsService.getLosses(), 1);
  });

  test('hasWonOnce starts false and only needs to be set once', () async {
    expect(await SettingsService.getHasWonOnce(), isFalse);

    await SettingsService.setHasWonOnce();
    expect(await SettingsService.getHasWonOnce(), isTrue);
  });

  test('adsRemoved defaults to false and round-trips', () async {
    expect(await SettingsService.getAdsRemoved(), isFalse);

    await SettingsService.setAdsRemoved(true);
    expect(await SettingsService.getAdsRemoved(), isTrue);
  });

  test('sound and haptics default to enabled', () async {
    expect(await SettingsService.getSoundEnabled(), isTrue);
    expect(await SettingsService.getHapticsEnabled(), isTrue);

    await SettingsService.setSoundEnabled(false);
    await SettingsService.setHapticsEnabled(false);
    expect(await SettingsService.getSoundEnabled(), isFalse);
    expect(await SettingsService.getHapticsEnabled(), isFalse);
  });

  test('home how-to dismissal persists', () async {
    expect(await SettingsService.getHomeHowToPlayDismissed(), isFalse);

    await SettingsService.dismissHomeHowToPlay();
    expect(await SettingsService.getHomeHowToPlayDismissed(), isTrue);
  });

  test('board theme defaults to classic and round-trips', () async {
    expect(await SettingsService.getBoardTheme(), BoardThemeId.classic);

    await SettingsService.setBoardTheme(BoardThemeId.night);
    expect(await SettingsService.getBoardTheme(), BoardThemeId.night);
  });

  test('streaks update on win and reset on loss', () async {
    await SettingsService.recordWinStreak();
    await SettingsService.recordWinStreak();
    expect(await SettingsService.getCurrentStreak(), 2);
    expect(await SettingsService.getBestStreak(), 2);

    await SettingsService.resetWinStreak();
    expect(await SettingsService.getCurrentStreak(), 0);
    expect(await SettingsService.getBestStreak(), 2);
  });

  test('daily completion is tracked once per day', () async {
    expect(await SettingsService.isDailyCompletedToday(), isFalse);
    await SettingsService.markDailyCompletedToday();
    expect(await SettingsService.isDailyCompletedToday(), isTrue);
    expect(await SettingsService.getDailyCompletions(), 1);

    await SettingsService.markDailyCompletedToday();
    expect(await SettingsService.getDailyCompletions(), 1);
  });
}

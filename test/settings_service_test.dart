import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ignore: depend_on_referenced_packages
import 'package:shared_preferences_platform_interface/shared_preferences_platform_interface.dart';

import 'package:classic_reversi/app_theme.dart';
import 'package:classic_reversi/game_settings.dart';
import 'package:classic_reversi/settings_service.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test('difficulty defaults to easy and round-trips', () async {
    expect(await SettingsService.getDifficulty(), Difficulty.easy);

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
    expect(await SettingsService.getPremiumUnlocked(), isFalse);

    await SettingsService.setPremiumUnlocked(true);
    expect(await SettingsService.getPremiumUnlocked(), isTrue);
  });

  test('sound and haptics default to enabled', () async {
    expect(await SettingsService.getSoundEnabled(), isTrue);
    expect(await SettingsService.getHapticsEnabled(), isTrue);

    await SettingsService.setSoundEnabled(false);
    await SettingsService.setHapticsEnabled(false);
    expect(await SettingsService.getSoundEnabled(), isFalse);
    expect(await SettingsService.getHapticsEnabled(), isFalse);
  });

  test('accessibility feedback preferences default and round-trip', () async {
    expect(await SettingsService.getReduceMotion(), isFalse);
    expect(
      await SettingsService.getFeedbackIntensity(),
      FeedbackIntensity.balanced,
    );

    await SettingsService.setReduceMotion(true);
    await SettingsService.setFeedbackIntensity(FeedbackIntensity.gentle);

    expect(await SettingsService.getReduceMotion(), isTrue);
    expect(
      await SettingsService.getFeedbackIntensity(),
      FeedbackIntensity.gentle,
    );
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

  test('daily migration keeps lifetime count and all newly completed dates',
      () async {
    SharedPreferences.setMockInitialValues({
      'dailyCompletedDate': '2026-10-23',
      'dailyCompletions': 7,
    });
    final date = DateTime(2026, 10, 24);
    await SettingsService.markDailyCompletedOn(date);
    await SettingsService.markDailyCompletedOn(DateTime(2026, 10, 22));
    expect(await SettingsService.isDailyCompletedOn(date), isTrue);
    expect(await SettingsService.isDailyCompletedOn(DateTime(2026, 10, 23)),
        isTrue);
    expect(await SettingsService.getDailyCompletions(), 9);
    await SettingsService.markDailyCompletedOn(date);
    expect(await SettingsService.getDailyCompletions(), 9);
  });

  test('concurrent daily completion requests commit one date and one count',
      () async {
    await Future.wait(
        List.generate(3, (_) => SettingsService.markDailyCompletedToday()));
    expect(await SettingsService.getDailyCompletions(), 1);
  });

  test(
      'failed daily write and failed reload cannot expose optimistic completion',
      () async {
    final store = _SettingsPreferencesStore();
    SharedPreferencesStorePlatform.instance = store;
    await SharedPreferences.getInstance();
    store.failWrites = true;
    store.failReads = true;
    await expectLater(
        SettingsService.markDailyCompletedToday(), throwsStateError);
    await expectLater(
        SettingsService.isDailyCompletedToday(), throwsStateError);
    await expectLater(SettingsService.getDifficulty(), throwsStateError);
    store.failReads = false;
    expect(await SettingsService.isDailyCompletedToday(), isFalse);
    expect(await SettingsService.getDailyCompletions(), 0);
    store.failWrites = false;
    await SettingsService.markDailyCompletedToday();
    expect(await SettingsService.getDailyCompletions(), 1);
  });
}

class _SettingsPreferencesStore extends InMemorySharedPreferencesStore {
  _SettingsPreferencesStore() : super.empty();
  bool failWrites = false;
  bool failReads = false;

  @override
  Future<bool> setValue(String valueType, String key, Object value) =>
      failWrites ? Future.value(false) : super.setValue(valueType, key, value);

  @override
  Future<Map<String, Object>> getAll() => failReads
      ? Future.error(StateError('Storage is unavailable'))
      : super.getAll();
}

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
}

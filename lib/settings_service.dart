// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'app_theme.dart';
import 'game_settings.dart';

/// Controls the strength of visual, audio, and haptic game feedback.
enum FeedbackIntensity { gentle, balanced, lively }

/// Thin wrapper around [SharedPreferences] for values the app needs to
/// remember across launches.
class SettingsService {
  static const _difficultyKey = 'difficulty';
  static const _firstPlayerKey = 'firstPlayer';
  static const _winsKey = 'wins';
  static const _lossesKey = 'losses';
  static const _tiesKey = 'ties';
  static const _hasWonOnceKey = 'hasWonOnce';
  static const _adsRemovedKey = 'adsRemoved';
  static const _soundEnabledKey = 'soundEnabled';
  static const _hapticsEnabledKey = 'hapticsEnabled';
  static const _reduceMotionKey = 'reduceMotion';
  static const _feedbackIntensityKey = 'feedbackIntensity';
  static const _boardThemeKey = 'boardTheme';
  static const _gamesPlayedKey = 'gamesPlayed';
  static const _currentStreakKey = 'currentStreak';
  static const _bestStreakKey = 'bestStreak';
  static const _winsSuperEasyKey = 'winsSuperEasy';
  static const _winsEasyKey = 'winsEasy';
  static const _winsMediumKey = 'winsMedium';
  static const _winsHardKey = 'winsHard';
  static const _perfectWinsKey = 'perfectWins';
  static const _dailyCompletedDateKey = 'dailyCompletedDate';
  static const _dailyCompletedDatesKey = 'dailyCompletedDates';
  static const _dailyCompletionStateKey = 'dailyCompletionState';
  static const _dailyCompletionsKey = 'dailyCompletions';
  static const _unlockedAchievementsKey = 'unlockedAchievements';
  static const _homeHowToPlayDismissedKey = 'homeHowToPlayDismissed';
  static bool _needsReload = false;
  static Future<void>? _dailyPending;

  static Future<SharedPreferences> _preferences() async {
    final prefs = await SharedPreferences.getInstance();
    if (_needsReload) {
      await prefs.reload();
      _needsReload = false;
    }
    return prefs;
  }

  static Future<T> _dailyOperation<T>(Future<T> Function() operation) {
    final result =
        _dailyPending?.then((_) => operation()) ?? Future<T>.sync(operation);
    final tail =
        result.then<void>((_) {}, onError: (Object _, StackTrace __) {});
    _dailyPending = tail;
    tail.then((_) {
      if (identical(_dailyPending, tail)) _dailyPending = null;
    });
    return result;
  }

  static Future<void> _persistDaily(
      SharedPreferences prefs, String encoded) async {
    try {
      if (!await prefs.setString(_dailyCompletionStateKey, encoded)) {
        throw StateError('Daily completion could not be saved');
      }
    } catch (_) {
      _needsReload = true;
      await prefs.reload();
      _needsReload = false;
      rethrow;
    }
  }

  static Future<Difficulty> getDifficulty() async {
    final prefs = await _preferences();
    final index = prefs.getInt(_difficultyKey) ?? Difficulty.easy.index;
    return Difficulty.values[index.clamp(0, Difficulty.values.length - 1)];
  }

  static Future<void> setDifficulty(Difficulty difficulty) async {
    final prefs = await _preferences();
    await prefs.setInt(_difficultyKey, difficulty.index);
  }

  static Future<FirstPlayer> getFirstPlayer() async {
    final prefs = await _preferences();
    final index = prefs.getInt(_firstPlayerKey) ?? FirstPlayer.human.index;
    return FirstPlayer.values[index.clamp(0, FirstPlayer.values.length - 1)];
  }

  static Future<void> setFirstPlayer(FirstPlayer firstPlayer) async {
    final prefs = await _preferences();
    await prefs.setInt(_firstPlayerKey, firstPlayer.index);
  }

  static Future<int> getWins() async {
    final prefs = await _preferences();
    return prefs.getInt(_winsKey) ?? 0;
  }

  static Future<int> getLosses() async {
    final prefs = await _preferences();
    return prefs.getInt(_lossesKey) ?? 0;
  }

  static Future<int> getTies() async {
    final prefs = await _preferences();
    return prefs.getInt(_tiesKey) ?? 0;
  }

  static Future<void> incrementWins() async {
    final prefs = await _preferences();
    await prefs.setInt(_winsKey, (prefs.getInt(_winsKey) ?? 0) + 1);
  }

  static Future<void> incrementLosses() async {
    final prefs = await _preferences();
    await prefs.setInt(_lossesKey, (prefs.getInt(_lossesKey) ?? 0) + 1);
  }

  static Future<void> incrementTies() async {
    final prefs = await _preferences();
    await prefs.setInt(_tiesKey, (prefs.getInt(_tiesKey) ?? 0) + 1);
  }

  static Future<bool> getHasWonOnce() async {
    final prefs = await _preferences();
    return prefs.getBool(_hasWonOnceKey) ?? false;
  }

  static Future<void> setHasWonOnce() async {
    final prefs = await _preferences();
    await prefs.setBool(_hasWonOnceKey, true);
  }

  /// Local cache of the Remove Ads entitlement for offline launches.
  /// Store entitlements remain authoritative and are reconciled on startup.
  static Future<bool> getAdsRemoved() async {
    final prefs = await _preferences();
    return prefs.getBool(_adsRemovedKey) ?? false;
  }

  static Future<void> setAdsRemoved(bool value) async {
    final prefs = await _preferences();
    await prefs.setBool(_adsRemovedKey, value);
  }

  static Future<bool> getSoundEnabled() async {
    final prefs = await _preferences();
    return prefs.getBool(_soundEnabledKey) ?? true;
  }

  static Future<void> setSoundEnabled(bool value) async {
    final prefs = await _preferences();
    await prefs.setBool(_soundEnabledKey, value);
  }

  static Future<bool> getHapticsEnabled() async {
    final prefs = await _preferences();
    return prefs.getBool(_hapticsEnabledKey) ?? true;
  }

  static Future<void> setHapticsEnabled(bool value) async {
    final prefs = await _preferences();
    await prefs.setBool(_hapticsEnabledKey, value);
  }

  static Future<bool> getReduceMotion() async {
    final prefs = await _preferences();
    return prefs.getBool(_reduceMotionKey) ?? false;
  }

  static Future<void> setReduceMotion(bool value) async {
    final prefs = await _preferences();
    await prefs.setBool(_reduceMotionKey, value);
  }

  static Future<FeedbackIntensity> getFeedbackIntensity() async {
    final prefs = await _preferences();
    final index =
        prefs.getInt(_feedbackIntensityKey) ?? FeedbackIntensity.balanced.index;
    return FeedbackIntensity.values[index.clamp(
      0,
      FeedbackIntensity.values.length - 1,
    )];
  }

  static Future<void> setFeedbackIntensity(FeedbackIntensity value) async {
    final prefs = await _preferences();
    await prefs.setInt(_feedbackIntensityKey, value.index);
  }

  static Future<bool> getHomeHowToPlayDismissed() async {
    final prefs = await _preferences();
    return prefs.getBool(_homeHowToPlayDismissedKey) ?? false;
  }

  static Future<void> dismissHomeHowToPlay() async {
    final prefs = await _preferences();
    await prefs.setBool(_homeHowToPlayDismissedKey, true);
  }

  static Future<BoardThemeId> getBoardTheme() async {
    final prefs = await _preferences();
    final index = prefs.getInt(_boardThemeKey) ?? BoardThemeId.classic.index;
    return BoardThemeId.values[index.clamp(0, BoardThemeId.values.length - 1)];
  }

  static Future<void> setBoardTheme(BoardThemeId theme) async {
    final prefs = await _preferences();
    await prefs.setInt(_boardThemeKey, theme.index);
  }

  static Future<int> getGamesPlayed() async {
    final prefs = await _preferences();
    return prefs.getInt(_gamesPlayedKey) ?? 0;
  }

  static Future<void> incrementGamesPlayed() async {
    final prefs = await _preferences();
    await prefs.setInt(
      _gamesPlayedKey,
      (prefs.getInt(_gamesPlayedKey) ?? 0) + 1,
    );
  }

  static Future<int> getCurrentStreak() async {
    final prefs = await _preferences();
    return prefs.getInt(_currentStreakKey) ?? 0;
  }

  static Future<int> getBestStreak() async {
    final prefs = await _preferences();
    return prefs.getInt(_bestStreakKey) ?? 0;
  }

  static Future<void> recordWinStreak() async {
    final prefs = await _preferences();
    final next = (prefs.getInt(_currentStreakKey) ?? 0) + 1;
    await prefs.setInt(_currentStreakKey, next);
    final best = prefs.getInt(_bestStreakKey) ?? 0;
    if (next > best) {
      await prefs.setInt(_bestStreakKey, next);
    }
  }

  static Future<void> resetWinStreak() async {
    final prefs = await _preferences();
    await prefs.setInt(_currentStreakKey, 0);
  }

  static Future<int> getWinsForDifficulty(Difficulty difficulty) async {
    final prefs = await _preferences();
    switch (difficulty) {
      case Difficulty.superEasy:
        return prefs.getInt(_winsSuperEasyKey) ?? 0;
      case Difficulty.easy:
        return prefs.getInt(_winsEasyKey) ?? 0;
      case Difficulty.medium:
        return prefs.getInt(_winsMediumKey) ?? 0;
      case Difficulty.hard:
        return prefs.getInt(_winsHardKey) ?? 0;
    }
  }

  static Future<void> incrementWinsForDifficulty(Difficulty difficulty) async {
    final prefs = await _preferences();
    final key = switch (difficulty) {
      Difficulty.superEasy => _winsSuperEasyKey,
      Difficulty.easy => _winsEasyKey,
      Difficulty.medium => _winsMediumKey,
      Difficulty.hard => _winsHardKey,
    };
    await prefs.setInt(key, (prefs.getInt(key) ?? 0) + 1);
  }

  static Future<int> getPerfectWins() async {
    final prefs = await _preferences();
    return prefs.getInt(_perfectWinsKey) ?? 0;
  }

  static Future<void> incrementPerfectWins() async {
    final prefs = await _preferences();
    await prefs.setInt(
      _perfectWinsKey,
      (prefs.getInt(_perfectWinsKey) ?? 0) + 1,
    );
  }

  static String todayKey([DateTime? date]) {
    final d = date ?? DateTime.now();
    final month = d.month.toString().padLeft(2, '0');
    final day = d.day.toString().padLeft(2, '0');
    return '${d.year}-$month-$day';
  }

  static Future<bool> isDailyCompletedToday() =>
      isDailyCompletedOn(DateTime.now());

  static Future<bool> isDailyCompletedOn(DateTime date) =>
      _dailyOperation(() async {
        final prefs = await _preferences();
        return _dailyState(prefs).dates.contains(todayKey(date));
      });

  static Future<void> markDailyCompletedToday() =>
      markDailyCompletedOn(DateTime.now());

  static Future<void> markDailyCompletedOn(DateTime date) =>
      _dailyOperation(() async {
        final prefs = await _preferences();
        final previous = _dailyState(prefs);
        final dates = previous.dates;
        if (dates.add(todayKey(date))) {
          final sorted = dates.toList()..sort();
          // One payload keeps the count and date set consistent if storage fails.
          await _persistDaily(
              prefs,
              jsonEncode({
                'version': 1,
                'dates': sorted,
                'count': previous.count + 1,
              }));
        }
      });

  static ({Set<String> dates, int count}) _dailyState(SharedPreferences prefs) {
    final encoded = prefs.get(_dailyCompletionStateKey);
    if (encoded is String) {
      try {
        final data = jsonDecode(encoded);
        if (data is Map &&
            data['version'] == 1 &&
            data['count'] is int &&
            data['count'] >= 0 &&
            data['dates'] is List &&
            (data['dates'] as List)
                .every((date) => date is String && _validDateKey(date))) {
          return (
            dates: (data['dates'] as List).cast<String>().toSet(),
            count: data['count'] as int
          );
        }
      } on FormatException {
        // Fall back to the prior release's marker and lifetime total.
      }
    }
    final stored = prefs.get(_dailyCompletedDatesKey);
    final legacy = prefs.get(_dailyCompletedDateKey);
    final dates = <String>{
      if (stored is List) ...stored.whereType<String>().where(_validDateKey),
      if (legacy is String && _validDateKey(legacy)) legacy,
    };
    final count = prefs.get(_dailyCompletionsKey);
    return (
      dates: dates,
      count: count is int && count >= dates.length ? count : dates.length
    );
  }

  static bool _validDateKey(String value) {
    final date = DateTime.tryParse(value);
    return value.length == 10 && date != null && todayKey(date) == value;
  }

  static Future<int> getDailyCompletions() => _dailyOperation(() async {
        final prefs = await _preferences();
        return _dailyState(prefs).count;
      });

  static Future<Set<String>> getUnlockedAchievements() async {
    final prefs = await _preferences();
    return (prefs.getStringList(_unlockedAchievementsKey) ?? const []).toSet();
  }

  static Future<bool> unlockAchievement(String id) async {
    final prefs = await _preferences();
    final current =
        (prefs.getStringList(_unlockedAchievementsKey) ?? []).toSet();
    if (current.contains(id)) {
      return false;
    }
    current.add(id);
    await prefs.setStringList(_unlockedAchievementsKey, current.toList());
    return true;
  }
}

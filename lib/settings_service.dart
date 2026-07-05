// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:shared_preferences/shared_preferences.dart';

import 'game_settings.dart';

/// Thin wrapper around [SharedPreferences] for the handful of values the app
/// needs to remember across launches: the player's preferred difficulty and
/// first-player choice, their win/loss record, and whether they've ever won a
/// game (used to decide when to prompt for a store review).
class SettingsService {
  static const _difficultyKey = 'difficulty';
  static const _firstPlayerKey = 'firstPlayer';
  static const _winsKey = 'wins';
  static const _lossesKey = 'losses';
  static const _hasWonOnceKey = 'hasWonOnce';

  static Future<Difficulty> getDifficulty() async {
    final prefs = await SharedPreferences.getInstance();
    final index = prefs.getInt(_difficultyKey) ?? Difficulty.hard.index;
    return Difficulty.values[index.clamp(0, Difficulty.values.length - 1)];
  }

  static Future<void> setDifficulty(Difficulty difficulty) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_difficultyKey, difficulty.index);
  }

  static Future<FirstPlayer> getFirstPlayer() async {
    final prefs = await SharedPreferences.getInstance();
    final index = prefs.getInt(_firstPlayerKey) ?? FirstPlayer.human.index;
    return FirstPlayer.values[index.clamp(0, FirstPlayer.values.length - 1)];
  }

  static Future<void> setFirstPlayer(FirstPlayer firstPlayer) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_firstPlayerKey, firstPlayer.index);
  }

  static Future<int> getWins() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_winsKey) ?? 0;
  }

  static Future<int> getLosses() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_lossesKey) ?? 0;
  }

  static Future<void> incrementWins() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_winsKey, (prefs.getInt(_winsKey) ?? 0) + 1);
  }

  static Future<void> incrementLosses() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_lossesKey, (prefs.getInt(_lossesKey) ?? 0) + 1);
  }

  static Future<bool> getHasWonOnce() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_hasWonOnceKey) ?? false;
  }

  static Future<void> setHasWonOnce() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_hasWonOnceKey, true);
  }
}

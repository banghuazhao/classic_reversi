// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'daily_challenge.dart';
import 'game_board.dart';
import 'game_settings.dart';
import 'generated/l10n.dart';
import 'main.dart';
import 'settings_screen.dart';
import 'settings_service.dart';
import 'stats_screen.dart';
import 'styling.dart';
import 'theme_controller.dart';

/// The very first screen the player sees: pick a difficulty, choose who goes
/// first (or play locally with a friend), see the running win/loss record,
/// then start a game. Shown again whenever the player wants a new game with
/// different settings (the restart button in [GameScreen] returns here).
class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  Difficulty _difficulty = Difficulty.hard;
  FirstPlayer _firstPlayer = FirstPlayer.human;
  bool _twoPlayerMode = false;
  bool _showHowToPlay = false;
  int _wins = 0;
  int _losses = 0;
  int _currentStreak = 0;
  bool _dailyCompleted = false;

  @override
  void initState() {
    super.initState();
    ThemeController.instance.addListener(_onThemeChanged);
    _loadSettings();
  }

  @override
  void dispose() {
    ThemeController.instance.removeListener(_onThemeChanged);
    super.dispose();
  }

  void _onThemeChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _loadSettings() async {
    final difficulty = await SettingsService.getDifficulty();
    final firstPlayer = await SettingsService.getFirstPlayer();
    final wins = await SettingsService.getWins();
    final losses = await SettingsService.getLosses();
    final streak = await SettingsService.getCurrentStreak();
    final dailyDone = await DailyChallenge.isCompletedToday();
    if (!mounted) return;
    setState(() {
      _difficulty = difficulty;
      _firstPlayer = firstPlayer;
      _wins = wins;
      _losses = losses;
      _currentStreak = streak;
      _dailyCompleted = dailyDone;
    });
  }

  void _startGame() {
    SettingsService.setDifficulty(_difficulty);
    SettingsService.setFirstPlayer(_firstPlayer);

    PieceType humanColor = PieceType.black;
    if (!_twoPlayerMode) {
      switch (_firstPlayer) {
        case FirstPlayer.human:
          humanColor = PieceType.black;
          break;
        case FirstPlayer.computer:
          humanColor = PieceType.white;
          break;
        case FirstPlayer.random:
          humanColor = Random().nextBool() ? PieceType.black : PieceType.white;
          break;
      }
    }

    Navigator.of(context).pushReplacement(
      fadeRoute((context) => GameScreen(
            settings: GameSettings(
              difficulty: _difficulty,
              twoPlayerMode: _twoPlayerMode,
              humanColor: humanColor,
            ),
          )),
    );
  }

  void _startDailyChallenge() {
    Navigator.of(context).pushReplacement(
      fadeRoute((context) => GameScreen(
            settings: DailyChallenge.settingsForToday(),
          )),
    );
  }

  Widget _sectionLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: Styling.scoreLabelText.copyWith(fontSize: 18),
      ),
    );
  }

  // A minimal on/off switch that doesn't need a Material ancestor, since this
  // app deliberately doesn't use MaterialApp/Theme (see main.dart).
  Widget _toggleSwitch(bool value) {
    final theme = ThemeController.instance.theme;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      width: 46,
      height: 28,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: value ? Color(0xffffffff) : Color(0x60ffffff),
        borderRadius: BorderRadius.circular(14),
      ),
      child: AnimatedAlign(
        duration: const Duration(milliseconds: 150),
        alignment: value ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            color: value ? theme.backgroundFinish : Color(0xffffffff),
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }

  // An expandable "How to Play" panel, styled to match the other settings
  // rows. Kept as a simple GestureDetector + AnimatedCrossFade (no
  // ExpansionTile) since this app deliberately avoids Material/Theme.
  Widget _howToPlaySection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GestureDetector(
          onTap: () => setState(() => _showHowToPlay = !_showHowToPlay),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: Color(0x40ffffff),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.of(context).How_to_play,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xffffffff),
                  ),
                ),
                AnimatedRotation(
                  turns: _showHowToPlay ? 0.5 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: Color(0xffffffff),
                  ),
                ),
              ],
            ),
          ),
        ),
        AnimatedCrossFade(
          firstChild: const SizedBox(width: double.infinity, height: 0),
          secondChild: Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: Text(
              S.of(context).How_to_play_explain,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 13,
                height: 1.4,
                color: Color(0xe0ffffff),
              ),
            ),
          ),
          crossFadeState:
              _showHowToPlay ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 200),
          sizeCurve: Curves.easeInOut,
        ),
      ],
    );
  }

  Widget _segmentedControl<T>({
    required List<T> values,
    required T selected,
    required String Function(T) labelFor,
    required ValueChanged<T> onSelected,
  }) {
    return Row(
      children: values.map((value) {
        final isSelected = value == selected;
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: GestureDetector(
              onTap: () => onSelected(value),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected ? Color(0xffffffff) : Color(0x40ffffff),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  labelFor(value),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: isSelected ? Color(0xff000000) : Color(0xffffffff),
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _iconButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: 44,
      height: 44,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: ThemeController.instance.theme.buttonFill,
          shape: const CircleBorder(),
          padding: EdgeInsets.zero,
          elevation: 0,
        ),
        child: Icon(icon, size: 20, color: const Color(0xffffffff)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = ThemeController.instance.theme;
    final s = S.of(context);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.backgroundStart,
            theme.backgroundFinish,
          ],
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  _iconButton(
                    icon: CupertinoIcons.chart_bar,
                    onPressed: () async {
                      await Navigator.of(context).push(
                        fadeRoute((context) => const StatsScreen()),
                      );
                      _loadSettings();
                    },
                  ),
                  const Spacer(),
                  _iconButton(
                    icon: CupertinoIcons.settings,
                    onPressed: () async {
                      await Navigator.of(context).push(
                        fadeRoute((context) => const SettingsScreen()),
                      );
                      if (mounted) setState(() {});
                    },
                  ),
                ],
              ),
              SizedBox(height: 12),
              Text(
                s.Classic_Reversi,
                textAlign: TextAlign.center,
                style: Styling.resultText.copyWith(fontSize: 36),
              ),
              SizedBox(height: 10),
              Text(
                s.WinsLosses(_wins, _losses),
                textAlign: TextAlign.center,
                style: Styling.scoreLabelText.copyWith(fontSize: 16),
              ),
              if (_currentStreak > 0) ...[
                SizedBox(height: 4),
                Text(
                  '${s.CurrentStreak}: $_currentStreak',
                  textAlign: TextAlign.center,
                  style: Styling.scoreLabelText.copyWith(fontSize: 14),
                ),
              ],
              SizedBox(height: 22),
              GestureDetector(
                onTap: _startDailyChallenge,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Color(0x55ffffff),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: theme.lastMoveBorder, width: 1.2),
                  ),
                  child: Row(
                    children: [
                      Icon(CupertinoIcons.calendar,
                          color: theme.lastMoveBorder, size: 22),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              s.DailyChallenge,
                              style: const TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: Color(0xffffffff),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              _dailyCompleted
                                  ? s.DailyCompleted
                                  : s.DailyChallengeSubtitle,
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 12,
                                color: Color(0xe0ffffff),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        _dailyCompleted
                            ? CupertinoIcons.checkmark_circle_fill
                            : CupertinoIcons.chevron_right,
                        color: Color(0xffffffff),
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24),
              _howToPlaySection(context),
              SizedBox(height: 30),
              _sectionLabel(s.Difficulty),
              _segmentedControl<Difficulty>(
                values: Difficulty.values,
                selected: _difficulty,
                labelFor: (d) => d.label(context),
                onSelected: (d) => setState(() => _difficulty = d),
              ),
              SizedBox(height: 30),
              _sectionLabel(s.TwoPlayersMode),
              GestureDetector(
                onTap: () => setState(() => _twoPlayerMode = !_twoPlayerMode),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Color(0x40ffffff),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          s.PlayAgainstFriend,
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 14,
                            color: Color(0xffffffff),
                          ),
                        ),
                      ),
                      _toggleSwitch(_twoPlayerMode),
                    ],
                  ),
                ),
              ),
              if (!_twoPlayerMode) ...[
                SizedBox(height: 30),
                _sectionLabel(s.WhoGoesFirst),
                _segmentedControl<FirstPlayer>(
                  values: FirstPlayer.values,
                  selected: _firstPlayer,
                  labelFor: (f) => f.label(context),
                  onSelected: (f) => setState(() => _firstPlayer = f),
                ),
              ],
              SizedBox(height: 40),
              SizedBox(
                height: 56,
                child: ElevatedButton(
                  onPressed: _startGame,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffffffff),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: Text(
                    s.StartGame,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Color(0xff000000),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

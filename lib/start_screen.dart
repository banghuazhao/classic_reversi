// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'daily_challenge.dart';
import 'app_chrome.dart';
import 'game_board.dart';
import 'game_settings.dart';
import 'generated/l10n.dart';
import 'how_to_play_screen.dart';
import 'main.dart';
import 'settings_screen.dart';
import 'settings_service.dart';
import 'stats_screen.dart';
import 'styling.dart';
import 'theme_controller.dart';

/// The very first screen the player sees: pick a difficulty, choose who goes
/// first (or play locally with a friend), then start a game. Shown again
/// whenever the player wants a new game with
/// different settings (the home button in [GameScreen] returns here).
class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  Difficulty _difficulty = Difficulty.hard;
  FirstPlayer _firstPlayer = FirstPlayer.human;
  bool _twoPlayerMode = false;
  bool _showHowToPlayDetails = false;
  bool _homeHowToPlayDismissed = false;
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
    final howToPlayDismissed =
        await SettingsService.getHomeHowToPlayDismissed();
    final dailyDone = await DailyChallenge.isCompletedToday();
    if (!mounted) return;
    setState(() {
      _difficulty = difficulty;
      _firstPlayer = firstPlayer;
      _homeHowToPlayDismissed = howToPlayDismissed;
      _dailyCompleted = dailyDone;
    });
  }

  Future<void> _dismissHomeHowToPlay() async {
    setState(() {
      _homeHowToPlayDismissed = true;
      _showHowToPlayDetails = false;
    });
    await SettingsService.dismissHomeHowToPlay();
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

  // Compact switch used in the start-screen game options.
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

  Widget _howToPlaySection(BuildContext context) {
    final s = S.of(context);
    final theme = ThemeController.instance.theme;
    return Material(
      color: AppChrome.cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: AppChrome.borderColor),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          InkWell(
            onTap: () => setState(
              () => _showHowToPlayDetails = !_showHowToPlayDetails,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 64),
              child: Padding(
                padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
                child: Row(
                  children: [
                    Icon(
                      CupertinoIcons.question_circle_fill,
                      color: theme.lastMoveBorder,
                      size: 23,
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        s.How_to_play,
                        style: const TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: AppChrome.primaryText,
                        ),
                      ),
                    ),
                    AnimatedRotation(
                      turns: _showHowToPlayDetails ? 0.5 : 0,
                      duration: const Duration(milliseconds: 180),
                      child: const Icon(
                        CupertinoIcons.chevron_down,
                        size: 18,
                        color: AppChrome.primaryText,
                      ),
                    ),
                    IconButton(
                      tooltip:
                          MaterialLocalizations.of(context).closeButtonTooltip,
                      onPressed: _dismissHomeHowToPlay,
                      icon: const Icon(
                        CupertinoIcons.xmark,
                        size: 18,
                        color: AppChrome.primaryText,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox(width: double.infinity),
            secondChild: Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(18, 0, 18, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(color: AppChrome.borderColor, height: 1),
                  const SizedBox(height: 14),
                  Text(
                    s.How_to_play_explain,
                    style: const TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 14,
                      height: 1.45,
                      color: AppChrome.secondaryText,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(
                        fadeRoute((context) => const HowToPlayScreen()),
                      );
                    },
                    icon: const Icon(CupertinoIcons.book_fill, size: 17),
                    label: Text(s.HowToLearnMore),
                  ),
                ],
              ),
            ),
            crossFadeState: _showHowToPlayDetails
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 200),
            sizeCurve: Curves.easeInOut,
          ),
        ],
      ),
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
                  color: isSelected
                      ? const Color(0xffffffff)
                      : AppChrome.cardColor,
                  border: Border.all(color: AppChrome.borderColor),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  labelFor(value),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                    fontSize: values.length > 3 ? 12 : 14,
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
    required String tooltip,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Semantics(
      label: tooltip,
      button: true,
      child: ExcludeSemantics(
        child: Tooltip(
          message: tooltip,
          child: SizedBox(
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
              child: Icon(
                icon,
                size: 20,
                color: const Color(0xffffffff),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = ThemeController.instance.theme;
    final s = S.of(context);

    return Scaffold(
      backgroundColor: theme.backgroundFinish,
      body: Container(
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
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  width: min(constraints.maxWidth, 720),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            _iconButton(
                              tooltip: s.Stats,
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
                              tooltip: s.Settings,
                              icon: CupertinoIcons.settings,
                              onPressed: () async {
                                await Navigator.of(context).push(
                                  fadeRoute(
                                      (context) => const SettingsScreen()),
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
                        SizedBox(height: 22),
                        GestureDetector(
                          onTap: _startDailyChallenge,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 14, horizontal: 16),
                            decoration: BoxDecoration(
                              color: AppChrome.cardColor,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                  color: theme.lastMoveBorder, width: 1.2),
                            ),
                            child: Row(
                              children: [
                                Icon(CupertinoIcons.calendar,
                                    color: theme.lastMoveBorder, size: 22),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                        if (!_homeHowToPlayDismissed) ...[
                          SizedBox(height: 24),
                          _howToPlaySection(context),
                        ],
                        if (!_twoPlayerMode) ...[
                          SizedBox(height: 30),
                          _sectionLabel(s.Difficulty),
                          _segmentedControl<Difficulty>(
                            values: const [
                              Difficulty.superEasy,
                              Difficulty.easy,
                              Difficulty.medium,
                              Difficulty.hard,
                            ],
                            selected: _difficulty,
                            labelFor: (d) => d.label(context),
                            onSelected: (d) => setState(() => _difficulty = d),
                          ),
                        ],
                        SizedBox(height: 30),
                        _sectionLabel(s.TwoPlayersMode),
                        GestureDetector(
                          onTap: () =>
                              setState(() => _twoPlayerMode = !_twoPlayerMode),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 16),
                            decoration: BoxDecoration(
                              color: AppChrome.cardColor,
                              border: Border.all(color: AppChrome.borderColor),
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
            },
          ),
        ),
      ),
    );
  }
}

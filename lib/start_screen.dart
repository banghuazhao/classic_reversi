// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_chrome.dart';
import 'daily_challenge.dart';
import 'game_board.dart';
import 'game_session.dart';
import 'game_settings.dart';
import 'generated/l10n.dart';
import 'how_to_play_screen.dart';
import 'main.dart';
import 'match_library_screen.dart';
import 'puzzles_screen.dart';
import 'settings_screen.dart';
import 'settings_service.dart';
import 'stats_screen.dart';
import 'theme_controller.dart';
import 'tutorial_screen.dart';

/// A quiet landing page. Match preferences are revealed only when starting a
/// new game, so returning players can get back to their board in one tap.
class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> with WidgetsBindingObserver {
  Difficulty _difficulty = Difficulty.easy;
  FirstPlayer _firstPlayer = FirstPlayer.human;
  bool _twoPlayerMode = false;
  bool _dailyCompleted = false;
  bool _loading = true;
  bool _openingGame = false;
  int _settingsLoadGeneration = 0;
  GameSession? _savedSession;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    ThemeController.instance.addListener(_onThemeChanged);
    _loadSettings();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    ThemeController.instance.removeListener(_onThemeChanged);
    super.dispose();
  }

  void _onThemeChanged() {
    if (mounted) setState(() {});
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) _loadSettings();
  }

  Future<void> _loadSettings() async {
    if (_openingGame) return;
    final generation = ++_settingsLoadGeneration;
    setState(() => _loading = true);
    try {
      final difficulty = await SettingsService.getDifficulty();
      final firstPlayer = await SettingsService.getFirstPlayer();
      final dailyDone = await DailyChallenge.isCompletedToday();
      final savedSession = await GameSessionService.load();
      if (!mounted || generation != _settingsLoadGeneration || _openingGame) {
        return;
      }
      setState(() {
        _difficulty = difficulty;
        _firstPlayer = firstPlayer;
        _dailyCompleted = dailyDone;
        _savedSession = savedSession;
        _loading = false;
      });
    } catch (error) {
      debugPrint('Refreshing home failed: $error');
      if (mounted && generation == _settingsLoadGeneration && !_openingGame) {
        setState(() => _loading = false);
      }
    }
  }

  Future<bool> _confirmReplaceSavedGame() async {
    if (_savedSession == null) return true;
    final s = S.of(context);
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(s.ReplaceSavedGameTitle),
            content: Text(s.ReplaceSavedGameMessage),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(s.KeepPlaying),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(s.StartNewGame),
              ),
            ],
          ),
        ) ??
        false;
  }

  Future<void> _continueGame() async {
    if (_savedSession == null || _openingGame || _loading) return;
    // Invalidate older refreshes and validate expiry again at the moment of
    // opening. Home can remain mounted across a change of local date.
    _settingsLoadGeneration++;
    setState(() {
      _openingGame = true;
      _loading = true;
    });
    try {
      final session = await GameSessionService.load();
      if (!mounted) return;
      if (session == null) {
        setState(() {
          _savedSession = null;
          _openingGame = false;
        });
        await _loadSettings();
        return;
      }
      Navigator.of(context).pushReplacement(
        fadeRoute(
          (context) =>
              GameScreen(settings: session.settings, savedSession: session),
        ),
      );
    } catch (error) {
      debugPrint('Continuing game failed: $error');
      if (mounted) {
        setState(() {
          _openingGame = false;
          _loading = false;
        });
      }
    }
  }

  Future<void> _launchGame(GameSettings settings) async {
    if (_openingGame || !await _confirmReplaceSavedGame() || !mounted) return;
    setState(() => _openingGame = true);
    await GameSessionService.clear();
    if (!mounted) return;
    Navigator.of(
      context,
    ).pushReplacement(fadeRoute((context) => GameScreen(settings: settings)));
  }

  Future<void> _startGuidedGame() async {
    final startPractice = await Navigator.of(context)
        .push<bool>(fadeRoute((context) => const TutorialScreen()));
    if (startPractice == true && mounted) {
      await _launchGame(
        const GameSettings(
          difficulty: Difficulty.easy,
          twoPlayerMode: false,
          humanColor: PieceType.black,
        ),
      );
    }
  }

  Future<void> _showGameSetup() async {
    var difficulty = _difficulty;
    var firstPlayer = _firstPlayer;
    var twoPlayerMode = _twoPlayerMode;
    final settings = await showModalBottomSheet<GameSettings>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: ThemeController.instance.theme.backgroundFinish,
      barrierColor: const Color(0x99000000),
      constraints: const BoxConstraints(maxWidth: 640),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setSheetState) {
          final s = S.of(context);
          return ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.sizeOf(context).height * 0.88,
            ),
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                24,
                16,
                24,
                24 + MediaQuery.paddingOf(context).bottom,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Semantics(
                          header: true,
                          child: Text(s.GameSetup, style: AppChrome.titleStyle),
                        ),
                      ),
                      IconButton(
                        tooltip: MaterialLocalizations.of(context)
                            .closeButtonTooltip,
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(
                          CupertinoIcons.xmark,
                          color: AppChrome.primaryText,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  AppSectionTitle(s.Opponent),
                  _SetupChoices<bool>(
                    values: const [false, true],
                    selected: twoPlayerMode,
                    labelFor: (value) =>
                        value ? s.PlayAgainstFriend : s.AgainstComputer,
                    onSelected: (value) =>
                        setSheetState(() => twoPlayerMode = value),
                  ),
                  if (!twoPlayerMode) ...[
                    const SizedBox(height: 24),
                    AppSectionTitle(s.Difficulty),
                    _SetupChoices<Difficulty>(
                      values: const [
                        Difficulty.superEasy,
                        Difficulty.easy,
                        Difficulty.medium,
                        Difficulty.hard,
                      ],
                      selected: difficulty,
                      labelFor: (value) => value.label(context),
                      onSelected: (value) =>
                          setSheetState(() => difficulty = value),
                    ),
                    const SizedBox(height: 24),
                    AppSectionTitle(s.WhoGoesFirst),
                    _SetupChoices<FirstPlayer>(
                      values: FirstPlayer.values,
                      selected: firstPlayer,
                      labelFor: (value) => value.label(context),
                      onSelected: (value) =>
                          setSheetState(() => firstPlayer = value),
                    ),
                  ],
                  const SizedBox(height: 32),
                  ElevatedButton(
                    style: appPrimaryButtonStyle(),
                    onPressed: () {
                      PieceType humanColor = PieceType.black;
                      if (!twoPlayerMode) {
                        humanColor = switch (firstPlayer) {
                          FirstPlayer.human => PieceType.black,
                          FirstPlayer.computer => PieceType.white,
                          FirstPlayer.random => Random().nextBool()
                              ? PieceType.black
                              : PieceType.white,
                        };
                      }
                      Navigator.of(context).pop(
                        GameSettings(
                          difficulty: difficulty,
                          twoPlayerMode: twoPlayerMode,
                          humanColor: humanColor,
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Text(s.StartGame, textAlign: TextAlign.center),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
    if (settings == null || !mounted) return;
    setState(() {
      _difficulty = difficulty;
      _firstPlayer = firstPlayer;
      _twoPlayerMode = twoPlayerMode;
    });
    await SettingsService.setDifficulty(difficulty);
    await SettingsService.setFirstPlayer(firstPlayer);
    if (mounted) await _launchGame(settings);
  }

  Widget _iconButton({
    required String tooltip,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return IconButton.filledTonal(
      tooltip: tooltip,
      onPressed: onPressed,
      style: IconButton.styleFrom(
        backgroundColor: AppChrome.cardColor,
        foregroundColor: AppChrome.primaryText,
        minimumSize: const Size(48, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      icon: Icon(icon, size: 22),
    );
  }

  @override
  Widget build(BuildContext context) {
    final palette = ThemeController.instance.theme;
    final s = S.of(context);
    final hasSavedGame = _savedSession != null;
    return Scaffold(
      backgroundColor: palette.backgroundFinish,
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [palette.backgroundStart, palette.backgroundFinish],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) => Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 560),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
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
                              if (mounted) _loadSettings();
                            },
                          ),
                          const Spacer(),
                          _iconButton(
                            tooltip: s.Settings,
                            icon: CupertinoIcons.settings,
                            onPressed: () async {
                              await Navigator.of(context).push(
                                fadeRoute((context) => const SettingsScreen()),
                              );
                              if (mounted) _loadSettings();
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Center(
                        child: BoardThemePreview(
                          palette: palette,
                          size: constraints.maxHeight < 500 ? 88 : 128,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Semantics(
                        header: true,
                        child: Text(
                          s.Classic_Reversi,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            height: 1.15,
                            letterSpacing: -0.6,
                            color: AppChrome.primaryText,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        hasSavedGame ? s.SavedGameSubtitle : s.HomeTagline,
                        textAlign: TextAlign.center,
                        style: AppChrome.bodyStyle,
                      ),
                      const SizedBox(height: 32),
                      ElevatedButton.icon(
                        onPressed: _loading || _openingGame
                            ? null
                            : hasSavedGame
                                ? _continueGame
                                : _showGameSetup,
                        style: appPrimaryButtonStyle(),
                        icon: _loading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Icon(CupertinoIcons.play_fill, size: 18),
                        label: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Text(
                            hasSavedGame ? s.ContinueGame : s.Play,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      if (hasSavedGame) ...[
                        const SizedBox(height: 8),
                        TextButton(
                          onPressed:
                              _loading || _openingGame ? null : _showGameSetup,
                          style: TextButton.styleFrom(
                            minimumSize: const Size(48, 48),
                            foregroundColor: AppChrome.primaryText,
                            textStyle: AppChrome.actionStyle,
                          ),
                          child: Text(s.NewGame),
                        ),
                      ],
                      const SizedBox(height: 24),
                      AppMenuRow(
                        icon: CupertinoIcons.calendar,
                        title: s.DailyChallenge,
                        subtitle: _dailyCompleted
                            ? s.DailyCompleted
                            : s.DailyChallengeSubtitle,
                        onTap: _loading || _openingGame
                            ? null
                            : () => _launchGame(
                                  DailyChallenge.settingsForToday(),
                                ),
                        trailing: _dailyCompleted
                            ? Icon(
                                CupertinoIcons.checkmark_circle,
                                color: palette.lastMoveBorder,
                                size: 22,
                              )
                            : null,
                      ),
                      LayoutBuilder(builder: (context, tileConstraints) {
                        final scale =
                            MediaQuery.textScalerOf(context).scale(16) / 16;
                        final columns =
                            tileConstraints.maxWidth >= 304 * scale ? 2 : 1;
                        final tileWidth =
                            (tileConstraints.maxWidth - (columns - 1) * 12) /
                                columns;
                        return Wrap(spacing: 12, runSpacing: 12, children: [
                          SizedBox(
                              width: tileWidth,
                              child: _ExploreTile(
                                title: s.Puzzles,
                                icon: CupertinoIcons.square_grid_2x2,
                                onPressed: () => Navigator.of(context).push(
                                    fadeRoute(
                                        (context) => const PuzzlesScreen())),
                              )),
                          SizedBox(
                              width: tileWidth,
                              child: _ExploreTile(
                                title: s.MatchLibrary,
                                icon: CupertinoIcons.clock,
                                onPressed: () => Navigator.of(context).push(
                                    fadeRoute((context) =>
                                        const MatchLibraryScreen())),
                              )),
                        ]);
                      }),
                      const SizedBox(height: 12),
                      AppMenuRow(
                        icon: CupertinoIcons.book,
                        title: s.GuidedFirstGame,
                        subtitle: s.GuidedFirstGameSubtitle,
                        onTap:
                            _loading || _openingGame ? null : _startGuidedGame,
                        margin: EdgeInsets.zero,
                      ),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.center,
                        child: TextButton(
                          onPressed: () => Navigator.of(context).push(
                            fadeRoute((context) => const HowToPlayScreen()),
                          ),
                          style: TextButton.styleFrom(
                            foregroundColor: AppChrome.secondaryText,
                            minimumSize: const Size(48, 48),
                            textStyle: AppChrome.actionStyle,
                          ),
                          child: Text(s.Rules),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Wrapping choices keep labels legible with large text and narrow screens.
/// The checkmark and selected semantics convey state without relying on color.
class _SetupChoices<T> extends StatelessWidget {
  const _SetupChoices({
    required this.values,
    required this.selected,
    required this.labelFor,
    required this.onSelected,
  });

  final List<T> values;
  final T selected;
  final String Function(T) labelFor;
  final ValueChanged<T> onSelected;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Wrap(
        spacing: 8,
        runSpacing: 8,
        children: values.map((value) {
          final isSelected = value == selected;
          return ConstrainedBox(
            constraints: BoxConstraints(maxWidth: constraints.maxWidth),
            child: Semantics(
              selected: isSelected,
              button: true,
              child: Material(
                color: isSelected ? AppChrome.primaryText : AppChrome.cardColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: const BorderSide(color: AppChrome.borderColor),
                ),
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: () => onSelected(value),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(minHeight: 48),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            isSelected
                                ? CupertinoIcons.checkmark_circle_fill
                                : CupertinoIcons.circle,
                            size: 20,
                            color: isSelected
                                ? AppChrome.onPrimary
                                : AppChrome.secondaryText,
                          ),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              labelFor(value),
                              style: AppChrome.actionStyle.copyWith(
                                color: isSelected
                                    ? AppChrome.onPrimary
                                    : AppChrome.primaryText,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _ExploreTile extends StatelessWidget {
  const _ExploreTile(
      {required this.title, required this.icon, required this.onPressed});
  final String title;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppChrome.cardColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppChrome.borderColor)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onPressed,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 72),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(children: [
              Icon(icon,
                  size: 22,
                  color: ThemeController.instance.theme.lastMoveBorder),
              const SizedBox(width: 12),
              Expanded(
                  child: Text(title,
                      style: const TextStyle(
                          color: AppChrome.primaryText,
                          fontSize: 16,
                          height: 1.4,
                          fontWeight: FontWeight.w600))),
            ]),
          ),
        ),
      ),
    );
  }
}

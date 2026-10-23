// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:math';

import 'package:app_tracking_transparency/app_tracking_transparency.dart'
    if (dart.library.io) 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart'
    if (dart.library.io) 'package:google_mobile_ads/google_mobile_ads.dart';

import 'Tools/ads_manager.dart' if (dart.library.io) 'Tools/ads_manager.dart';
import 'Tools/in_app_reviewer_helper.dart'
    if (dart.library.io) 'Tools/in_app_reviewer_helper.dart';
import 'Tools/purchase_service.dart';
import 'achievements_service.dart';
import 'app_chrome.dart';
import 'app_theme.dart';
import 'feedback_service.dart';
import 'flip_piece.dart';
import 'game_board.dart';
import 'game_materials.dart';
import 'game_model.dart';
import 'game_over_sheet.dart';
import 'game_review_screen.dart';
import 'game_session.dart';
import 'game_settings.dart';
import 'gameplay_activity.dart';
import 'generated/l10n.dart';
import 'move_finder.dart';
import 'settings_screen.dart';
import 'start_screen.dart';
import 'styling.dart';
import 'theme_controller.dart';
import 'thinking_indicator.dart';

final ValueNotifier<bool> _servicesReady = ValueNotifier(false);

/// Render the home screen before starting store, audio, and consent work.
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());

  if (!kIsWeb) {
    Future.delayed(const Duration(seconds: 1), () {
      AppTrackingTransparency.requestTrackingAuthorization();
    }).catchError((Object error) {
      debugPrint('ATT request failed: $error');
    });

    () async {
      // Load visual/preferences independently of store network work so a
      // remembered theme can appear as early as the first frame.
      await Future.wait<void>([
        PurchaseService.instance.init().catchError((Object error) {
          debugPrint('PurchaseService init failed: $error');
        }),
        ThemeController.instance.load().catchError((Object error) {
          debugPrint('ThemeController load failed: $error');
        }),
        FeedbackService.instance.init().catchError((Object error) {
          debugPrint('FeedbackService init failed: $error');
        }),
      ]);

      // UMP consent must complete before ads initialize / load.
      try {
        await AdsManager.initializeWithConsent();
      } catch (error) {
        debugPrint('Ads consent/init failed: $error');
      }

      if (kDebugMode) {
        try {
          AdsManager.debugPrintID();
        } catch (error) {
          debugPrint('debugPrintID failed: $error');
        }
      }

      _servicesReady.value = true;
    }();
  }
}

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

/// A plain cross-fade between screens, used for switching between the start
/// screen and the game screen. Unlike [CupertinoPageRoute]'s slide-and-dim
/// transition, this doesn't leave the outgoing screen visible/ghosting
/// through mid-transition, which reads oddly for what's really a mode swap
/// rather than a drill-down navigation.
Route<T> fadeRoute<T>(WidgetBuilder builder) {
  return PageRouteBuilder<T>(
    pageBuilder: (context, animation, secondaryAnimation) => builder(context),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      if (MediaQuery.maybeOf(context)?.disableAnimations ?? false) return child;
      return FadeTransition(opacity: animation, child: child);
    },
    transitionDuration: FeedbackService.instance.reduceMotion
        ? Duration.zero
        : const Duration(milliseconds: 200),
  );
}

/// App shell. Uses [MaterialApp] so dialogs, snackbars, and tooltips work
/// reliably across the custom game screens. It also owns the app-open ad so
/// the ad is preloaded on the home screen and survives route changes.
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppOpenAdManager? _appOpenAdManager;
  AppLifecycleReactor? _appLifecycleReactor;

  @override
  void initState() {
    super.initState();
    PurchaseService.instance.addListener(_onPurchaseEntitlementChanged);
    _servicesReady.addListener(_setupAppOpenAds);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _setupAppOpenAds();
      }
    });
  }

  void _setupAppOpenAds() {
    if (kIsWeb ||
        !AdsManager.adsEnabled ||
        !AdsManager.mobileAdsInitialized ||
        _appOpenAdManager != null) {
      return;
    }

    final manager = AppOpenAdManager()..loadAd();
    _appOpenAdManager = manager;
    _appLifecycleReactor = AppLifecycleReactor(appOpenAdManager: manager)
      ..listenToAppStateChanges();
    // Preload only. Showing is reserved for true background→foreground
    // transitions so cold start is not interrupted by an app-open ad.
  }

  void _onPurchaseEntitlementChanged() {
    if (PurchaseService.instance.isAdsRemoved) {
      _tearDownAppOpenAds();
    }
  }

  void _tearDownAppOpenAds() {
    _appLifecycleReactor?.dispose();
    _appLifecycleReactor = null;
    _appOpenAdManager?.dispose();
    _appOpenAdManager = null;
  }

  @override
  void dispose() {
    PurchaseService.instance.removeListener(_onPurchaseEntitlementChanged);
    _servicesReady.removeListener(_setupAppOpenAds);
    _tearDownAppOpenAds();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xffE4C18B),
          brightness: Brightness.dark,
        ),
        splashFactory: NoSplash.splashFactory,
        dialogTheme: DialogThemeData(
          backgroundColor: const Color(0xff2b1b12),
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
            side: const BorderSide(color: Color(0x40ffffff)),
          ),
          titleTextStyle: const TextStyle(
            fontFamily: 'Roboto',
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          contentTextStyle: const TextStyle(
            fontFamily: 'Roboto',
            fontSize: 16,
            height: 1.4,
            color: Color(0xe6ffffff),
          ),
        ),
        snackBarTheme: const SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Color(0xff241710),
          contentTextStyle: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 15,
            color: Colors.white,
          ),
        ),
        tooltipTheme: TooltipThemeData(
          decoration: BoxDecoration(
            color: const Color(0xff241710),
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: const TextStyle(fontFamily: 'Roboto', color: Colors.white),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xffffd45c),
            textStyle: const TextStyle(
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      navigatorObservers: [routeObserver],
      supportedLocales: S.delegate.supportedLocales,
      localeResolutionCallback: (locale, supportedLocales) {
        // 中文 简繁体处理
        if (locale?.languageCode == 'zh') {
          if (locale?.scriptCode == 'Hant' ||
              locale?.countryCode == 'HK' ||
              locale?.countryCode == 'TW' ||
              locale?.countryCode == 'MO') {
            return const Locale('zh', 'HK'); //繁体
          } else {
            return const Locale('zh', ''); //简体
          }
        }
        // Fall back to matching any other language this app has translations
        // for (ja, ru, it, id, vi, ...), so new locales just need an arb file
        // added - no further changes needed here.
        if (locale != null) {
          for (final supported in supportedLocales) {
            if (supported.languageCode == locale.languageCode) {
              return supported;
            }
          }
        }
        return const Locale('en', '');
      },
      onGenerateRoute: (settings) {
        return PageRouteBuilder<dynamic>(
          settings: settings,
          pageBuilder: (context, animation, secondaryAnimation) =>
              const StartScreen(),
        );
      },
    );
  }
}

/// The [GameScreen] Widget represents the entire game
/// display, from scores to board state and everything in between.
class GameScreen extends StatefulWidget {
  final GameSettings settings;
  final GameSession? savedSession;

  const GameScreen({super.key, required this.settings, this.savedSession});

  @override
  State createState() => _GameScreenState();
}

/// State class for [GameScreen].
///
/// Immutable positions are committed immediately and saved in chronological
/// order. A generation counter cancels stale asynchronous computer turns.
class _GameScreenState extends State<GameScreen> with WidgetsBindingObserver {
  BannerAd? _ad;

  bool _isAdLoaded = false;

  final RewardedAdHelper _rewardedAdHelper = RewardedAdHelper();

  // The square the most recently placed piece landed on, so it can be
  // highlighted and is easy to spot (especially after the CPU moves).
  Position? _lastMove;

  // Visual-only event counter and strength for one-shot board feedback. They
  // never participate in move validation or game state.
  int _moveImpactId = 0;
  int _lastFlippedCount = 0;
  bool _cpuMoveAnticipating = false;

  bool _gameOverCelebrating = false;
  PieceType _gameOverWinner = PieceType.empty;
  bool _gameOverVictory = false;
  int _gameOverCelebrationId = 0;

  // Snapshots of the board from just before each human move, used to
  // support taking a move back. Cleared on undo so only one undo can be
  // used per turn until another move is made.
  final List<GameModel> _historyStack = [];
  final List<GameModel> _timeline = [];
  GameModel? _currentModel;
  late DateTime _sessionStartedAt;
  PieceType? _passedPlayer;
  bool _leaving = false;
  final FocusNode _boardFocus = FocusNode(debugLabel: 'Reversi board');
  Position _keyboardPosition = const Position(0, 0);
  bool _boardHasFocus = false;
  bool _canUndo = false;

  /// Extra undo charges earned via rewarded ads (Hard mode).
  int _rewardedUndoCharges = 0;

  /// Legal-move hints unlocked for this game via rewarded ad.
  bool _hintsUnlocked = false;

  bool _gameOverSheetVisible = false;
  bool _rewardFlowBusy = false;

  /// Bumped to cancel an in-flight CPU think/move when the user undoes.
  int _turnGeneration = 0;

  PieceType get _computerColor => widget.settings.twoPlayerMode
      ? PieceType.empty
      : getOpponent(widget.settings.humanColor);

  bool get _adsRemovedOrDisabled =>
      !AdsManager.adsEnabled || PurchaseService.instance.isAdsRemoved;

  bool get _freeUndoAllowed =>
      widget.settings.twoPlayerMode ||
      widget.settings.difficulty != Difficulty.hard ||
      _adsRemovedOrDisabled;

  bool get _undoAllowed =>
      _canUndo && (_freeUndoAllowed || _rewardedUndoCharges > 0);

  bool get _showHints {
    if (widget.settings.twoPlayerMode) {
      return false;
    }
    if (widget.settings.difficulty == Difficulty.easy ||
        widget.settings.difficulty == Difficulty.superEasy ||
        _adsRemovedOrDisabled) {
      return true;
    }
    return _hintsUnlocked;
  }

  GameModel _initialModel() {
    return GameModel.initial(
      board: widget.settings.initialBoard,
      player: widget.settings.initialPlayer,
      boardSize: widget.settings.boardSize,
    );
  }

  /// Commit immediately so restart, undo, and navigation always see the same
  /// authoritative position, even while a canceled computer search winds down.
  void _submitModel(GameModel model) {
    final generation = ++_turnGeneration;
    _acceptModel(model);
    setState(() {});
    if (model.player == _computerColor && !model.gameIsOver) {
      unawaited(_advanceComputer(model, generation));
    }
  }

  Future<void> _advanceComputer(GameModel model, int generation) async {
    var current = model;
    bool isCurrent() => mounted && !_leaving && generation == _turnGeneration;
    while (isCurrent() &&
        current.player == _computerColor &&
        !current.gameIsOver) {
      final move = await MoveFinder(current.board)
          .findMove(current.player, widget.settings.difficulty);
      if (!isCurrent() || move == null) return;
      await Future<void>.delayed(const Duration(milliseconds: 420));
      if (!isCurrent()) return;
      setState(() => _cpuMoveAnticipating = true);
      await Future<void>.delayed(const Duration(milliseconds: 180));
      if (!isCurrent()) return;
      final updated = current.updateForMove(move.x, move.y);
      if (updated == null) return;
      final flipped =
          GameBoard.flippedPositions(current.board, updated.board, move);
      unawaited(
          FeedbackService.instance.moveFeedback(flippedCount: flipped.length));
      _cpuMoveAnticipating = false;
      _lastMove = move;
      _lastFlippedCount = flipped.length;
      _moveImpactId++;
      current = updated;
      _acceptModel(current);
      setState(() {});
    }
  }

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    GameplayActivity.begin(this);
    final saved = widget.savedSession;
    _sessionStartedAt = saved?.savedAt ?? DateTime.now();
    if (saved != null) {
      _timeline.addAll(saved.timeline);
      _historyStack.addAll(saved.undoHistory);
      _currentModel = saved.model;
      _lastMove = saved.lastMove;
      _canUndo = saved.canUndo;
      _hintsUnlocked = saved.hintsUnlocked;
      _rewardedUndoCharges = saved.rewardedUndoCharges;
    }
    // Kick off the very first turn. If the computer is meant to move first,
    // this triggers that opening move; otherwise it commits the starting board.
    _submitModel(saved?.model ?? _initialModel());

    // Ads-removed users get Hard undo / hints without watching ads.
    if (_adsRemovedOrDisabled) {
      _hintsUnlocked = true;
    }

    PurchaseService.instance.addListener(_onPurchaseEntitlementChanged);
    ThemeController.instance.addListener(_onThemeChanged);
    FeedbackService.instance.addListener(_onFeedbackSettingsChanged);
    _servicesReady.addListener(_onServicesReady);

    if (!kIsWeb && AdsManager.adsEnabled && AdsManager.mobileAdsInitialized) {
      _setupAds();
    }
  }

  void _onServicesReady() {
    if (mounted &&
        !kIsWeb &&
        AdsManager.adsEnabled &&
        AdsManager.mobileAdsInitialized &&
        _ad == null) {
      _setupAds();
    }
  }

  static bool _samePosition(GameModel a, GameModel b) {
    if (a.player != b.player || a.board.size != b.board.size) return false;
    for (var y = 0; y < a.board.size; y++) {
      for (var x = 0; x < a.board.size; x++) {
        if (a.board.rows[y][x] != b.board.rows[y][x]) return false;
      }
    }
    return true;
  }

  void _acceptModel(GameModel model) {
    final previous = _timeline.isEmpty ? null : _timeline.last;
    if (previous == null || !_samePosition(previous, model)) {
      _timeline.add(model);
    }
    _passedPlayer = _timeline.length > 1 &&
            _timeline[_timeline.length - 2].player == model.player &&
            !model.gameIsOver
        ? getOpponent(model.player)
        : null;
    _currentModel = model;
    if (model.gameIsOver) {
      GameplayActivity.end(this);
      unawaited(
        GameSessionService.clear().catchError((Object error) {
          debugPrint('Clearing finished game failed: $error');
        }),
      );
    } else {
      unawaited(_saveSession());
    }
  }

  Future<void> _saveSession() async {
    final model = _currentModel;
    if (model == null || model.gameIsOver || _timeline.isEmpty) return;
    try {
      await GameSessionService.save(
        GameSession(
          settings: widget.settings,
          timeline: _timeline,
          undoHistory: _historyStack,
          lastMove: _lastMove,
          canUndo: _canUndo,
          hintsUnlocked: _hintsUnlocked,
          rewardedUndoCharges: _rewardedUndoCharges,
          savedAt: _sessionStartedAt,
        ),
      );
    } catch (error) {
      debugPrint('Saving game failed: $error');
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused ||
        state == AppLifecycleState.hidden) {
      unawaited(_saveSession());
    }
  }

  Future<void> _goHome() async {
    if (_leaving) return;
    _leaving = true;
    _turnGeneration++;
    await _saveSession();
    if (!mounted) return;
    Navigator.of(context)
        .pushReplacement(fadeRoute((context) => const StartScreen()));
  }

  Future<void> _confirmRestart() async {
    if (_timeline.length <= 1 || _currentModel?.gameIsOver == true) {
      _rematch();
      return;
    }
    final s = S.of(context);
    final restart = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(s.RestartConfirmTitle),
        content: Text(s.RestartConfirmMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(s.KeepPlaying),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(s.RestartGame),
          ),
        ],
      ),
    );
    if (restart == true && mounted) _rematch();
  }

  void _onThemeChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  void _onFeedbackSettingsChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  void _onPurchaseEntitlementChanged() {
    if (!mounted) {
      return;
    }
    if (PurchaseService.instance.isAdsRemoved) {
      _tearDownAds();
      setState(() {
        _hintsUnlocked = true;
      });
    }
  }

  void _setupAds() {
    // Ad setup must never be able to crash the game screen: a failure here
    // (bad ad unit config, SDK not ready, etc.) should just mean no ads.
    try {
      final bannerId = AdsManager.bannerAdUnitId;
      if (bannerId.isEmpty) {
        return;
      }
      _ad = BannerAd(
        adUnitId: bannerId,
        size: AdSize.banner,
        request: AdRequest(),
        listener: BannerAdListener(
          onAdLoaded: (_) {
            if (mounted && AdsManager.adsEnabled) {
              setState(() {
                _isAdLoaded = true;
              });
            } else {
              _tearDownAds();
            }
          },
          onAdFailedToLoad: (ad, error) {
            // Releases an ad resource when it fails to load
            ad.dispose();

            debugPrint(
              'Ad load failed (code=${error.code} message=${error.message})',
            );
          },
        ),
      );

      _ad?.load();

      _rewardedAdHelper.load();
    } catch (error) {
      debugPrint('Ad setup failed: $error');
    }
  }

  void _tearDownAds() {
    _rewardedAdHelper.dispose();
    _ad?.dispose();
    _ad = null;
    _isAdLoaded = false;
  }

  // Cancel computer work and release observers and board focus.
  @override
  void dispose() {
    _turnGeneration++;
    WidgetsBinding.instance.removeObserver(this);
    GameplayActivity.end(this);
    _servicesReady.removeListener(_onServicesReady);
    _boardFocus.dispose();
    PurchaseService.instance.removeListener(_onPurchaseEntitlementChanged);
    ThemeController.instance.removeListener(_onThemeChanged);
    FeedbackService.instance.removeListener(_onFeedbackSettingsChanged);
    _tearDownAds();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final model = _currentModel ?? _initialModel();
    _handleGameOverIfNeeded(model);
    return _buildWidgets(context, model);
  }

  // Records stats/achievements and shows the end-of-game sheet once per game.
  bool _gameOverHandled = false;

  void _handleGameOverIfNeeded(GameModel model) {
    if (!model.gameIsOver) {
      _gameOverHandled = false;
      return;
    }
    if (_gameOverHandled) {
      return;
    }
    _gameOverHandled = true;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      _runGameOverFlow(model);
    });
  }

  Future<void> _runGameOverFlow(GameModel model) async {
    final generation = _turnGeneration;
    if (!mounted ||
        _leaving ||
        _gameOverSheetVisible ||
        _currentModel == null ||
        !_samePosition(_currentModel!, model)) {
      return;
    }

    List<AchievementId> unlocked = const [];
    final isTie = model.blackScore == model.whiteScore;
    final winner = isTie
        ? PieceType.empty
        : model.blackScore > model.whiteScore
            ? PieceType.black
            : PieceType.white;
    final bool? humanWon = widget.settings.twoPlayerMode || isTie
        ? null
        : winner == widget.settings.humanColor;
    final celebrateVictory =
        !isTie && (widget.settings.twoPlayerMode || humanWon == true);
    var requestReview = false;

    try {
      if (!widget.settings.twoPlayerMode) {
        unlocked = await AchievementsService.instance.recordGameOver(
          model: model,
          settings: widget.settings,
        );
        requestReview = unlocked.contains(AchievementId.firstWin);
      }
    } catch (error) {
      debugPrint('Game-over bookkeeping failed: $error');
    }

    if (!mounted || _gameOverSheetVisible || generation != _turnGeneration) {
      return;
    }

    final feedback = FeedbackService.instance;
    await Future.delayed(
      Duration(milliseconds: feedback.reduceMotion ? 80 : 420),
    );
    if (!mounted || _gameOverSheetVisible || generation != _turnGeneration) {
      return;
    }
    setState(() {
      _gameOverCelebrating = true;
      _gameOverWinner = winner;
      _gameOverVictory = celebrateVictory;
      _gameOverCelebrationId++;
    });
    try {
      await feedback.gameOverFeedback(humanWon: celebrateVictory, tie: isTie);
    } catch (error) {
      debugPrint('Game-over feedback failed: $error');
    }
    await Future.delayed(
      Duration(milliseconds: feedback.reduceMotion ? 120 : 940),
    );
    if (!mounted || _gameOverSheetVisible || generation != _turnGeneration) {
      return;
    }

    // Respect a player who opened Settings or Review during the celebration.
    if (ModalRoute.of(context)?.isCurrent != true) return;
    _gameOverSheetVisible = true;
    try {
      await showGameOverSheet(
        context: context,
        model: model,
        settings: widget.settings,
        theme: ThemeController.instance.theme,
        newAchievements: unlocked,
        reduceMotion:
            feedback.reduceMotion || MediaQuery.disableAnimationsOf(context),
        feedbackScale: feedback.effectScale,
        celebrateWin: celebrateVictory,
        onRematch: _rematch,
        onHome: _goHome,
        onReview: () => Navigator.of(context).push(
          fadeRoute(
            (context) =>
                GameReviewScreen(history: List.unmodifiable(_timeline)),
          ),
        ),
      );
    } finally {
      _gameOverSheetVisible = false;
      if (mounted) {
        setState(() => _gameOverCelebrating = false);
      }
    }

    // Ask for a review after the result sheet, not on top of it.
    if (requestReview && !kIsWeb && !GameplayActivity.isPlaying) {
      InAppReviewHelper.requestReviewAfterFirstWin();
    }
  }

  void _rematch() {
    _turnGeneration++;
    GameplayActivity.begin(this);
    _sessionStartedAt = DateTime.now();
    _timeline.clear();
    _passedPlayer = null;
    setState(() {
      _historyStack.clear();
      _canUndo = false;
      _lastMove = null;
      _moveImpactId = 0;
      _lastFlippedCount = 0;
      _cpuMoveAnticipating = false;
      _gameOverCelebrating = false;
      _gameOverWinner = PieceType.empty;
      _gameOverVictory = false;
      _gameOverHandled = false;
      _gameOverSheetVisible = false;
      _rewardedUndoCharges = 0;
      if (!_adsRemovedOrDisabled &&
          widget.settings.difficulty != Difficulty.easy &&
          widget.settings.difficulty != Difficulty.superEasy) {
        _hintsUnlocked = false;
      } else if (_adsRemovedOrDisabled) {
        _hintsUnlocked = true;
      }
    });
    final initial = _initialModel();
    _currentModel = initial;
    _submitModel(initial);
  }

  // Called when the user taps on the game's board display. If it's the player's
  // turn, this method will attempt to make the move, creating a new GameModel
  // in the process.
  void _attemptUserMove(GameModel model, int x, int y) {
    final isHumanTurn = widget.settings.twoPlayerMode
        ? model.player != PieceType.empty
        : model.player != _computerColor;
    if (!_leaving &&
        _currentModel != null &&
        _samePosition(model, _currentModel!) &&
        isHumanTurn &&
        !model.gameIsOver &&
        model.board.isLegalMove(x, y, model.player)) {
      _historyStack.add(model);
      _canUndo = true;
      _lastMove = Position(x, y);
      final previousBoard = model.board;
      final updatedModel = model.updateForMove(x, y);
      if (updatedModel != null) {
        final flipped = GameBoard.flippedPositions(
          previousBoard,
          updatedModel.board,
          Position(x, y),
        );
        FeedbackService.instance.moveFeedback(flippedCount: flipped.length);
        _lastFlippedCount = flipped.length;
        _moveImpactId++;
        _submitModel(updatedModel);
      }
    }
  }

  void _undoLastMove({GameModel? currentModel}) {
    if (!_canUndo || _historyStack.isEmpty) {
      return;
    }
    // Don't undo while the CPU is thinking — the stream would still finish
    // the in-flight move first and burn a rewarded charge.
    if (currentModel != null && currentModel.player == _computerColor) {
      return;
    }
    if (!_freeUndoAllowed) {
      if (_rewardedUndoCharges <= 0) {
        _requestRewardedUndo(currentModel: currentModel);
        return;
      }
      _rewardedUndoCharges -= 1;
    }
    final previousModel = _historyStack.removeLast();
    final index = _timeline.lastIndexWhere(
      (model) => _samePosition(model, previousModel),
    );
    if (index >= 0) _timeline.removeRange(index + 1, _timeline.length);
    _canUndo = false;
    _lastMove = _lastPlacedPosition();
    _cpuMoveAnticipating = false;
    _turnGeneration++;
    setState(() {});
    _submitModel(previousModel);
  }

  Position? _lastPlacedPosition() {
    if (_timeline.length < 2) return null;
    final before = _timeline[_timeline.length - 2].board;
    final after = _timeline.last.board;
    for (var y = 0; y < after.size; y++) {
      for (var x = 0; x < after.size; x++) {
        if (before.rows[y][x] == PieceType.empty &&
            after.rows[y][x] != PieceType.empty) {
          return Position(x, y);
        }
      }
    }
    return null;
  }

  Future<void> _requestRewardedUndo({GameModel? currentModel}) async {
    if (_rewardFlowBusy || !_canUndo || _historyStack.isEmpty) {
      return;
    }
    if (currentModel != null && currentModel.player == _computerColor) {
      return;
    }
    _rewardFlowBusy = true;
    final s = S.of(context);
    try {
      if (!_adsRemovedOrDisabled) {
        final proceed = await _confirmWatchAd(s.WatchAdForUndo);
        if (proceed != true || !mounted) {
          return;
        }
        _showMessage(s.AdLoading);
      }
      final ok = await _rewardedAdHelper.show(
        onUserEarnedReward: () {
          _rewardedUndoCharges += 1;
        },
      );
      if (!mounted) {
        return;
      }
      if (!ok) {
        _showMessage(s.AdFailed);
        return;
      }
      setState(() {});
      _undoLastMove(currentModel: currentModel);
    } finally {
      _rewardFlowBusy = false;
    }
  }

  Future<void> _requestRewardedHints() async {
    if (_hintsUnlocked || _rewardFlowBusy) {
      return;
    }
    _rewardFlowBusy = true;
    final s = S.of(context);
    try {
      if (!_adsRemovedOrDisabled) {
        final proceed = await _confirmWatchAd(s.WatchAdForHint);
        if (proceed != true || !mounted) {
          return;
        }
        _showMessage(s.AdLoading);
      }
      final ok = await _rewardedAdHelper.show(
        onUserEarnedReward: () {
          _hintsUnlocked = true;
        },
      );
      if (!mounted) {
        return;
      }
      if (!ok) {
        _showMessage(s.AdFailed);
        return;
      }
      setState(() {});
      unawaited(_saveSession());
      _showMessage(s.HintsEnabled);
    } finally {
      _rewardFlowBusy = false;
    }
  }

  Future<bool?> _confirmWatchAd(String message) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(S.of(context).WatchAd),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(S.of(context).Cancel),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(S.of(context).Watch),
            ),
          ],
        );
      },
    );
  }

  void _showMessage(String message) {
    final messenger = ScaffoldMessenger.maybeOf(context);
    if (messenger != null) {
      messenger.hideCurrentSnackBar();
      messenger.showSnackBar(SnackBar(content: Text(message)));
      return;
    }
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(S.of(context).OK),
          ),
        ],
      ),
    );
  }

  Widget _circleActionButton({
    required String tooltip,
    required IconData icon,
    required VoidCallback? onPressed,
    required AppTheme theme,
    bool rewarded = false,
  }) {
    return Semantics(
      label: tooltip,
      button: true,
      enabled: onPressed != null,
      child: ExcludeSemantics(
        child: Tooltip(
          message: tooltip,
          child: SizedBox(
            width: 52,
            height: 52,
            child: ElevatedButton(
              onPressed: onPressed,
              style: _circleButtonStyle.copyWith(
                backgroundColor: WidgetStateProperty.resolveWith(
                  (states) => states.contains(WidgetState.disabled)
                      ? const Color(0x33000000)
                      : theme.buttonFill,
                ),
                side: WidgetStatePropertyAll(
                  BorderSide(
                    color: onPressed == null
                        ? const Color(0x24ffffff)
                        : const Color(0x40ffffff),
                  ),
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Icon(
                    icon,
                    size: 22,
                    color: onPressed == null
                        ? const Color(0x70ffffff)
                        : Colors.white,
                  ),
                  if (rewarded)
                    Positioned(
                      right: 2,
                      top: 2,
                      child: Icon(
                        CupertinoIcons.play_rectangle_fill,
                        size: 14,
                        color: theme.lastMoveBorder,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  static final ButtonStyle _circleButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: Color(0x60421E08),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35.0)),
    padding: EdgeInsets.zero,
    minimumSize: Size.zero,
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    elevation: 0,
  );

  Widget _buildScoreBox(PieceType player, GameModel model, AppTheme theme) {
    final s = S.of(context);
    final color = player == PieceType.black ? s.Black : s.White;
    final label = widget.settings.twoPlayerMode
        ? color
        : player == widget.settings.humanColor
            ? s.YouColor(color)
            : s.ComputerColor(color);
    final score =
        player == PieceType.black ? model.blackScore : model.whiteScore;
    final active = model.player == player;
    final reduceMotion = FeedbackService.instance.reduceMotion ||
        MediaQuery.disableAnimationsOf(context);
    return Semantics(
      label: '$label, $score',
      selected: active,
      child: ExcludeSemantics(
        child: AnimatedContainer(
          duration:
              reduceMotion ? Duration.zero : const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            color: AppChrome.cardColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: active ? theme.lastMoveBorder : AppChrome.borderColor,
              width: active ? 2 : 1,
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: theme.pieceGradients[player],
                      border: Border.all(color: const Color(0x66FFFFFF)),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      label,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14,
                        height: 1.35,
                        fontWeight: FontWeight.w500,
                        color: AppChrome.primaryText,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              AnimatedSwitcher(
                duration: reduceMotion
                    ? Duration.zero
                    : const Duration(milliseconds: 180),
                child: Text(
                  '$score',
                  key: ValueKey('$player-$score'),
                  style: const TextStyle(
                    fontSize: 36,
                    height: 1.2,
                    fontWeight: FontWeight.w700,
                    color: AppChrome.primaryText,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  KeyEventResult _onBoardKey(GameModel model, KeyEvent event) {
    if (event is! KeyDownEvent && event is! KeyRepeatEvent) {
      return KeyEventResult.ignored;
    }
    final key = event.logicalKey;
    var x = _keyboardPosition.x;
    var y = _keyboardPosition.y;
    if (key == LogicalKeyboardKey.arrowLeft) {
      x--;
    } else if (key == LogicalKeyboardKey.arrowRight) {
      x++;
    } else if (key == LogicalKeyboardKey.arrowUp) {
      y--;
    } else if (key == LogicalKeyboardKey.arrowDown) {
      y++;
    } else if (key == LogicalKeyboardKey.enter ||
        key == LogicalKeyboardKey.space) {
      if (event is KeyDownEvent) _attemptUserMove(model, x, y);
      return KeyEventResult.handled;
    } else {
      return KeyEventResult.ignored;
    }
    setState(
      () => _keyboardPosition = Position(
        x.clamp(0, model.board.size - 1),
        y.clamp(0, model.board.size - 1),
      ),
    );
    return KeyEventResult.handled;
  }

  Widget _buildGameBoardDisplay(
    BuildContext context,
    GameModel model,
    double boxWidth,
    AppTheme theme,
  ) {
    final feedback = FeedbackService.instance;
    final reduceMotion = feedback.reduceMotion ||
        (MediaQuery.maybeOf(context)?.disableAnimations ?? false);
    final isHumanTurn = widget.settings.twoPlayerMode
        ? model.player != PieceType.empty
        : model.player != _computerColor;
    final canInteract =
        isHumanTurn && !model.gameIsOver && !_gameOverCelebrating;
    final legalMoves = canInteract
        ? model.board.getMovesForPlayer(model.player)
        : const <Position>[];
    final showLegalMoveHints =
        _showHints && model.player != _computerColor && !model.gameIsOver;
    final cells = <Widget>[];
    final winningCells = <Offset>[];

    for (var y = 0; y < model.board.height; y++) {
      for (var x = 0; x < model.board.width; x++) {
        final type = model.board.getPieceAtLocation(x, y);
        final isLastMove = _lastMove?.x == x && _lastMove?.y == y;
        final isLegalTap = type == PieceType.empty &&
            legalMoves.any((position) => position.x == x && position.y == y);
        final isLegalMoveHint = showLegalMoveHints && isLegalTap;
        if (_gameOverCelebrating && type == _gameOverWinner) {
          winningCells.add(Offset(x + 0.5, y + 0.5));
        }
        final distanceFromMove = _lastMove == null
            ? 0
            : max((x - _lastMove!.x).abs(), (y - _lastMove!.y).abs());
        final flipDelay = Duration(
          milliseconds: (distanceFromMove * 46).clamp(0, 184),
        );

        cells.add(
          Positioned(
            left: x * boxWidth,
            top: y * boxWidth,
            width: boxWidth,
            height: boxWidth,
            child: Semantics(
              label: [
                S.of(context).BoardCell(
                      '${String.fromCharCode(65 + x)}${y + 1}',
                      type == PieceType.empty
                          ? S.of(context).BoardEmpty
                          : type == PieceType.black
                              ? S.of(context).Black
                              : S.of(context).White,
                    ),
                if (isLegalTap) S.of(context).BoardLegalMove,
                if (isLastMove) S.of(context).BoardLastMove,
              ].join(', '),
              sortKey: OrdinalSortKey((y * model.board.size + x).toDouble()),
              button: isLegalTap,
              selected: _boardHasFocus &&
                  _keyboardPosition.x == x &&
                  _keyboardPosition.y == y,
              liveRegion: _boardHasFocus &&
                  _keyboardPosition.x == x &&
                  _keyboardPosition.y == y,
              onTap: isLegalTap ? () => _attemptUserMove(model, x, y) : null,
              child: ExcludeSemantics(
                child: TactileBoardCell(
                  key: ValueKey('cell-$x-$y'),
                  enabled: canInteract,
                  isLegal: isLegalTap,
                  reduceMotion: reduceMotion,
                  effectScale: feedback.effectScale,
                  onLegalTap: () => _attemptUserMove(model, x, y),
                  onInvalidTap: FeedbackService.instance.invalidMoveFeedback,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      if (isLastMove && type != PieceType.empty)
                        MoveImpactHalo(
                          key: ValueKey('move-halo-$_moveImpactId'),
                          size: boxWidth,
                          color: theme.lastMoveBorder,
                          reduceMotion: reduceMotion,
                          effectScale: feedback.effectScale,
                        ),
                      FlipPiece(
                        type: type,
                        size: boxWidth,
                        isLastMove: isLastMove,
                        theme: theme,
                        duration: Styling.pieceFlipDuration,
                        delay: flipDelay,
                        reduceMotion: reduceMotion,
                        effectScale: feedback.effectScale,
                      ),
                      if (isLegalMoveHint)
                        MaterialMoveHint(
                          size: boxWidth * 0.28,
                          color: theme.hintDot,
                          reduceMotion: reduceMotion,
                          effectScale: feedback.effectScale,
                        ),
                      if (_boardHasFocus &&
                          _keyboardPosition.x == x &&
                          _keyboardPosition.y == y)
                        Positioned.fill(
                          child: IgnorePointer(
                            child: Container(
                              margin: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 3,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }
    }

    final board = MaterialBoard(
      boardSize: model.board.size,
      cellSize: boxWidth,
      theme: theme,
      child: Stack(
        children: [
          ...cells,
          if (_gameOverCelebrating)
            Positioned.fill(
              child: EndgameBoardCelebration(
                celebrationId: _gameOverCelebrationId,
                boardSize: model.board.size,
                winningCells: winningCells,
                victory: _gameOverVictory,
                reduceMotion: reduceMotion,
                effectScale: feedback.effectScale,
                color: theme.lastMoveBorder,
              ),
            ),
        ],
      ),
    );

    return Semantics(
      container: true,
      explicitChildNodes: true,
      hint: S.of(context).BoardKeyboardHint,
      child: Focus(
        focusNode: _boardFocus,
        includeSemantics: false,
        onFocusChange: (value) => setState(() => _boardHasFocus = value),
        onKeyEvent: (_, event) => _onBoardKey(model, event),
        child: BoardImpactAnimator(
          impactId: _moveImpactId,
          flippedCount: _lastFlippedCount,
          reduceMotion: reduceMotion,
          effectScale: feedback.effectScale,
          child: board,
        ),
      ),
    );
  }

  String _turnStatus(GameModel model) {
    final s = S.of(context);
    if (model.gameIsOver) return s.GameOver;
    if (widget.settings.twoPlayerMode) {
      return s.PlayerTurn(model.player == PieceType.black ? s.Black : s.White);
    }
    return model.player == _computerColor ? s.ComputerThinking : s.YourTurn;
  }

  Widget _buildWidgets(BuildContext context, GameModel model) {
    final theme = ThemeController.instance.theme;
    final s = S.of(context);
    final cpuThinking = !widget.settings.twoPlayerMode &&
        !model.gameIsOver &&
        model.player == _computerColor;
    final needsHintButton = !widget.settings.twoPlayerMode && !_showHints;
    final needsRewardedUndo = !widget.settings.twoPlayerMode &&
        widget.settings.difficulty == Difficulty.hard &&
        !_freeUndoAllowed;
    final undoEnabled = !cpuThinking && !model.gameIsOver && _canUndo;
    final reduceMotion = FeedbackService.instance.reduceMotion ||
        MediaQuery.disableAnimationsOf(context);
    final status = _turnStatus(model);

    final scores = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _buildScoreBox(PieceType.black, model, theme)),
        const SizedBox(width: 12),
        Expanded(child: _buildScoreBox(PieceType.white, model, theme)),
      ],
    );
    final controls = Wrap(
      alignment: WrapAlignment.center,
      spacing: 12,
      runSpacing: 12,
      children: [
        _circleActionButton(
          tooltip: needsRewardedUndo ? s.UndoWithAd : s.Undo,
          icon: CupertinoIcons.arrow_uturn_left,
          theme: theme,
          rewarded: needsRewardedUndo,
          onPressed: undoEnabled
              ? () {
                  if (_undoAllowed) {
                    _undoLastMove(currentModel: model);
                  } else {
                    _requestRewardedUndo(currentModel: model);
                  }
                }
              : null,
        ),
        if (needsHintButton)
          _circleActionButton(
            tooltip: s.HintWithAd,
            icon: CupertinoIcons.lightbulb,
            theme: theme,
            rewarded: true,
            onPressed: !model.gameIsOver && !cpuThinking
                ? _requestRewardedHints
                : null,
          ),
        _circleActionButton(
          tooltip: s.RestartGame,
          icon: CupertinoIcons.refresh_bold,
          theme: theme,
          onPressed: _confirmRestart,
        ),
        _circleActionButton(
          tooltip: s.Settings,
          icon: CupertinoIcons.settings,
          theme: theme,
          onPressed: () => Navigator.of(context)
              .push(fadeRoute((context) => const SettingsScreen())),
        ),
        _circleActionButton(
          tooltip: s.Home,
          icon: CupertinoIcons.house_fill,
          theme: theme,
          onPressed: _goHome,
        ),
        if (model.gameIsOver)
          _circleActionButton(
            tooltip: s.ReviewGame,
            icon: CupertinoIcons.backward_end,
            theme: theme,
            onPressed: () => Navigator.of(context).push(
              fadeRoute(
                (context) =>
                    GameReviewScreen(history: List.unmodifiable(_timeline)),
              ),
            ),
          ),
      ],
    );
    final turn = Semantics(
      liveRegion: true,
      label: s.GameStatusAnnouncement(
        _passedPlayer == null
            ? status
            : s.TurnPassed(
                _passedPlayer == PieceType.black ? s.Black : s.White,
                model.player == PieceType.black ? s.Black : s.White,
              ),
        model.blackScore,
        model.whiteScore,
      ),
      child: ExcludeSemantics(
        child: Column(
          children: [
            Text(
              status,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 17,
                height: 1.4,
                fontWeight: FontWeight.w600,
                color: AppChrome.primaryText,
              ),
            ),
            if (_passedPlayer != null) ...[
              const SizedBox(height: 8),
              Text(
                s.TurnPassed(
                  _passedPlayer == PieceType.black ? s.Black : s.White,
                  model.player == PieceType.black ? s.Black : s.White,
                ),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.4,
                  color: AppChrome.secondaryText,
                ),
              ),
            ],
            const SizedBox(height: 8),
            ThinkingIndicator(
              color: theme.thinking,
              height: Styling.thinkingSize,
              visible: cpuThinking,
              emphasized: _cpuMoveAnticipating,
              reduceMotion: reduceMotion,
              effectScale: FeedbackService.instance.effectScale,
            ),
          ],
        ),
      ),
    );

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _goHome();
      },
      child: Scaffold(
        backgroundColor: theme.backgroundFinish,
        body: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [theme.backgroundStart, theme.backgroundFinish],
            ),
          ),
          child: TabletopTexture(
            theme: theme,
            child: SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final width = min(constraints.maxWidth, 980.0);
                  final wide = width >= 700 && width > constraints.maxHeight;
                  final extent = wide
                      ? min(
                          (width - 64) * 0.58,
                          max(220.0, constraints.maxHeight - 64),
                        )
                      : min(width - 32, 560.0);
                  // An ad loading never changes the board dimensions.
                  final board = _buildGameBoardDisplay(
                    context,
                    model,
                    (extent - 20) / GameBoard.standardSize,
                    theme,
                  );
                  final information = Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.settings.isDailyChallenge
                            ? s.DailyChallenge
                            : widget.settings.twoPlayerMode
                                ? s.TwoPlayersMode
                                : widget.settings.difficulty.label(context),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14,
                          height: 1.4,
                          color: AppChrome.secondaryText,
                        ),
                      ),
                      const SizedBox(height: 16),
                      scores,
                      const SizedBox(height: 16),
                      controls,
                      const SizedBox(height: 20),
                      turn,
                    ],
                  );
                  return Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      width: width,
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            if (wide)
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 6,
                                    child: Center(child: board),
                                  ),
                                  const SizedBox(width: 24),
                                  Expanded(flex: 4, child: information),
                                ],
                              )
                            else ...[
                              information,
                              const SizedBox(height: 20),
                              Center(child: board),
                            ],
                            if (!kIsWeb && AdsManager.adsEnabled)
                              SizedBox(
                                height: 68,
                                child: _isAdLoaded
                                    ? Center(
                                        child: SizedBox(
                                          width: _ad!.size.width.toDouble(),
                                          height: _ad!.size.height.toDouble(),
                                          child: AdWidget(ad: _ad!),
                                        ),
                                      )
                                    : null,
                              ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:math';

import 'package:app_tracking_transparency/app_tracking_transparency.dart'
    if (dart.library.io) 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemChrome, DeviceOrientation;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart'
    if (dart.library.io) 'package:google_mobile_ads/google_mobile_ads.dart';

import 'Tools/ads_manager.dart' if (dart.library.io) 'Tools/ads_manager.dart';
import 'Tools/in_app_reviewer_helper.dart'
    if (dart.library.io) 'Tools/in_app_reviewer_helper.dart';
import 'Tools/purchase_service.dart';
import 'achievements_service.dart';
import 'app_theme.dart';
import 'feedback_service.dart';
import 'flip_piece.dart';
import 'game_board.dart';
import 'game_model.dart';
import 'game_over_sheet.dart';
import 'game_settings.dart';
import 'generated/l10n.dart';
import 'more_page.dart';
import 'move_finder.dart';
import 'start_screen.dart';
import 'styling.dart';
import 'theme_controller.dart';
import 'thinking_indicator.dart';

/// Main function for the app. Turns off the system overlays and locks portrait
/// orientation for a more game-like UI, and then runs the [Widget] tree.
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb) {
    Future.delayed(const Duration(seconds: 1), () {
      AppTrackingTransparency.requestTrackingAuthorization();
    }).catchError((Object error) {
      print('ATT request failed: $error');
    });

    InAppReviewHelper.checkAndAskForReview().catchError((Object error) {
      print('In-app review check failed: $error');
    });

    () async {
      // Entitlement before ads / first frame so purchased users skip ads.
      try {
        await PurchaseService.instance.init();
      } catch (error) {
        print('PurchaseService init failed: $error');
      }

      try {
        await ThemeController.instance.load();
      } catch (error) {
        print('ThemeController load failed: $error');
      }

      try {
        await FeedbackService.instance.init();
      } catch (error) {
        print('FeedbackService init failed: $error');
      }

      if (AdsManager.adsEnabled) {
        try {
          await MobileAds.instance.initialize();
        } catch (error) {
          print('MobileAds initialization failed: $error');
        }

        try {
          AdsManager.debugPrintID();
        } catch (error) {
          print('debugPrintID failed: $error');
        }
      }

      try {
        await SystemChrome.setPreferredOrientations(
            [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
      } catch (error) {
        print('setPreferredOrientations failed: $error');
      }
      runApp(MyApp());
    }();
  } else {
    runApp(MyApp());
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
      return FadeTransition(opacity: animation, child: child);
    },
    transitionDuration: const Duration(milliseconds: 200),
  );
}

/// The App class. Unlike many Flutter apps, this one does not use Material
/// widgets, so there's no [MaterialApp] or [Theme] objects.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WidgetsApp(
      debugShowCheckedModeBanner: false,
      color: Color(0xffffffff), // Mandatory background color.
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

  const GameScreen({super.key, required this.settings});

  @override
  State createState() => _GameScreenState();
}

/// State class for [GameScreen].
///
/// The game is modeled as a [Stream] of immutable instances of [GameModel].
/// Each move by the player or CPU results in a new [GameModel], which is
/// sent downstream. [GameScreen] uses a [StreamBuilder] wired up to that stream
/// of models to build out its [Widget] tree.
class _GameScreenState extends State<GameScreen> {
  final StreamController<GameModel> _userMovesController =
      StreamController<GameModel>();
  final StreamController<GameModel> _restartController =
      StreamController<GameModel>();
  Stream<GameModel>? _modelStream;

  BannerAd? _ad;

  bool _isAdLoaded = false;

  AppOpenAdManager? _appOpenAdManager;
  AppLifecycleReactor? _appLifecycleReactor;
  final RewardedAdHelper _rewardedAdHelper = RewardedAdHelper();

  // The square the most recently placed piece landed on, so it can be
  // highlighted and is easy to spot (especially after the CPU moves).
  Position? _lastMove;

  // Snapshots of the board from just before each human move, used to
  // support taking a move back. Cleared on undo so only one undo can be
  // used per turn until another move is made.
  final List<GameModel> _historyStack = [];
  bool _canUndo = false;

  /// Extra undo charges earned via rewarded ads (Hard mode).
  int _rewardedUndoCharges = 0;

  /// Legal-move hints unlocked for this game via rewarded ad.
  bool _hintsUnlocked = false;

  bool _gameOverSheetVisible = false;

  PieceType get _computerColor => widget.settings.twoPlayerMode
      ? PieceType.empty
      : getOpponent(widget.settings.humanColor);

  bool get _freeUndoAllowed =>
      widget.settings.twoPlayerMode ||
      widget.settings.difficulty != Difficulty.hard;

  bool get _undoAllowed =>
      _canUndo && (_freeUndoAllowed || _rewardedUndoCharges > 0);

  bool get _showHints {
    if (widget.settings.twoPlayerMode) {
      return false;
    }
    if (widget.settings.difficulty == Difficulty.easy) {
      return true;
    }
    return _hintsUnlocked;
  }

  GameModel _initialModel() {
    return GameModel.initial(
      board: widget.settings.initialBoard,
      player: widget.settings.initialPlayer,
    );
  }

  // Below is the combination of streams that controls the flow of the game.
  void _setUpModelStream() {
    _modelStream = StreamGroup.merge([
      _userMovesController.stream,
      _restartController.stream,
    ]).asyncExpand((model) async* {
      yield model;

      var newModel = model;

      while (newModel.player == _computerColor) {
        final finder = MoveFinder(newModel.board);
        final move =
            await finder.findMove(newModel.player, widget.settings.difficulty);
        if (move != null) {
          // A brief pause makes the CPU's move visible and easy to follow
          // instead of feeling instant.
          await Future.delayed(const Duration(milliseconds: 600));
          final previousBoard = newModel.board;
          final updatedModel = newModel.updateForMove(move.x, move.y);
          if (updatedModel == null) {
            break;
          }
          final flipped = GameBoard.flippedPositions(
            previousBoard,
            updatedModel.board,
            move,
          );
          FeedbackService.instance
              .moveFeedback(flippedCount: flipped.length);
          newModel = updatedModel;
          _lastMove = move;
          yield newModel;
        } else {
          break;
        }
      }
    });
  }

  @override
  initState() {
    super.initState();

    _setUpModelStream();
    // Kick off the very first turn. If the computer is meant to move first,
    // this is what triggers that opening move; otherwise it just seeds the
    // stream with the starting position.
    _restartController.add(_initialModel());

    // Ads-removed users get Hard undo / hints without watching ads.
    if (PurchaseService.instance.isAdsRemoved) {
      _rewardedUndoCharges = 1;
      _hintsUnlocked = true;
    }

    PurchaseService.instance.addListener(_onPurchaseEntitlementChanged);
    ThemeController.instance.addListener(_onThemeChanged);

    if (!kIsWeb && AdsManager.adsEnabled) {
      _setupAds();
    }
  }

  void _onThemeChanged() {
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
        _rewardedUndoCharges = max(_rewardedUndoCharges, 1);
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

            print(
                'Ad load failed (code=${error.code} message=${error.message})');
          },
        ),
      );

      _ad?.load();

      _appOpenAdManager = AppOpenAdManager()..loadAd();
      _appLifecycleReactor =
          AppLifecycleReactor(appOpenAdManager: _appOpenAdManager!);
      _appLifecycleReactor?.listenToAppStateChanges();
      _rewardedAdHelper.load();
    } catch (error) {
      print('Ad setup failed: $error');
    }
  }

  void _tearDownAds() {
    _appLifecycleReactor?.dispose();
    _appLifecycleReactor = null;
    _appOpenAdManager?.dispose();
    _appOpenAdManager = null;
    _rewardedAdHelper.dispose();
    _ad?.dispose();
    _ad = null;
    _isAdLoaded = false;
  }

  // Thou shalt tidy up thy stream controllers.
  @override
  void dispose() {
    PurchaseService.instance.removeListener(_onPurchaseEntitlementChanged);
    ThemeController.instance.removeListener(_onThemeChanged);
    _tearDownAds();
    _userMovesController.close();
    _restartController.close();
    super.dispose();
  }

  /// The build method mostly just sets up the StreamBuilder and leaves the
  /// details to _buildWidgets.
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: ThemeController.instance,
      builder: (context, _) {
        return StreamBuilder<GameModel>(
          stream: _modelStream,
          builder: (context, snapshot) {
            final model = snapshot.hasData
                ? snapshot.data!
                : _initialModel();
            _handleGameOverIfNeeded(model);
            return _buildWidgets(context, model);
          },
        );
      },
    );
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

    () async {
      List<AchievementId> unlocked = const [];
      bool? humanWon;
      final isTie = model.blackScore == model.whiteScore;

      if (!widget.settings.twoPlayerMode) {
        if (!isTie) {
          humanWon = model.blackScore > model.whiteScore
              ? widget.settings.humanColor == PieceType.black
              : widget.settings.humanColor == PieceType.white;
        }
        unlocked = await AchievementsService.instance.recordGameOver(
          model: model,
          settings: widget.settings,
        );

        if (unlocked.contains(AchievementId.firstWin)) {
          InAppReviewHelper.requestReviewAfterFirstWin();
        }
      }

      await FeedbackService.instance.gameOverFeedback(
        humanWon: humanWon == true,
        tie: isTie || widget.settings.twoPlayerMode,
      );

      if (!mounted || _gameOverSheetVisible) {
        return;
      }

      final sheetModel = model;
      final sheetUnlocked = unlocked;
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        if (!mounted || _gameOverSheetVisible) {
          return;
        }
        _gameOverSheetVisible = true;
        await showGameOverSheet(
          context: context,
          model: sheetModel,
          settings: widget.settings,
          theme: ThemeController.instance.theme,
          newAchievements: sheetUnlocked,
          onRematch: _rematch,
          onHome: () {
            Navigator.of(context).pushReplacement(
              fadeRoute((context) => const StartScreen()),
            );
          },
        );
        _gameOverSheetVisible = false;
      });
    }();
  }

  void _rematch() {
    setState(() {
      _historyStack.clear();
      _canUndo = false;
      _lastMove = null;
      _gameOverHandled = false;
      _gameOverSheetVisible = false;
      if (!PurchaseService.instance.isAdsRemoved) {
        _rewardedUndoCharges = 0;
        if (widget.settings.difficulty != Difficulty.easy) {
          _hintsUnlocked = false;
        }
      }
    });
    _restartController.add(_initialModel());
  }

  // Called when the user taps on the game's board display. If it's the player's
  // turn, this method will attempt to make the move, creating a new GameModel
  // in the process.
  void _attemptUserMove(GameModel model, int x, int y) {
    final isHumanTurn = widget.settings.twoPlayerMode
        ? model.player != PieceType.empty
        : model.player != _computerColor;
    if (isHumanTurn && model.board.isLegalMove(x, y, model.player)) {
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
        _userMovesController.add(updatedModel);
      }
    }
  }

  void _undoLastMove() {
    if (!_canUndo || _historyStack.isEmpty) {
      return;
    }
    if (!_freeUndoAllowed) {
      if (_rewardedUndoCharges <= 0) {
        _requestRewardedUndo();
        return;
      }
      _rewardedUndoCharges -= 1;
    }
    final previousModel = _historyStack.removeLast();
    _canUndo = false;
    _lastMove = null;
    setState(() {});
    _restartController.add(previousModel);
  }

  Future<void> _requestRewardedUndo() async {
    final s = S.of(context);
    final proceed = await _confirmWatchAd(s.WatchAdForUndo);
    if (proceed != true || !mounted) {
      return;
    }
    final ok = await _rewardedAdHelper.show(onUserEarnedReward: () {
      _rewardedUndoCharges += 1;
    });
    if (!mounted) {
      return;
    }
    if (!ok) {
      _showMessage(s.AdFailed);
      return;
    }
    setState(() {});
    _undoLastMove();
  }

  Future<void> _requestRewardedHints() async {
    if (_hintsUnlocked) {
      return;
    }
    final s = S.of(context);
    final proceed = await _confirmWatchAd(s.WatchAdForHint);
    if (proceed != true || !mounted) {
      return;
    }
    final ok = await _rewardedAdHelper.show(onUserEarnedReward: () {
      _hintsUnlocked = true;
    });
    if (!mounted) {
      return;
    }
    if (!ok) {
      _showMessage(s.AdFailed);
      return;
    }
    setState(() {});
    _showMessage(s.HintsEnabled);
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
            child: const Text('OK'),
          ),
        ],
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
    var label =
        player == PieceType.black ? S.of(context).Black : S.of(context).White;
    var scoreText = player == PieceType.black
        ? '${model.blackScore}'
        : '${model.whiteScore}';

    final labelStyle = player == PieceType.black
        ? Styling.scoreLabelTextBlack.copyWith(color: theme.scoreBlack)
        : Styling.scoreLabelText.copyWith(color: theme.scoreWhite);
    final scoreStyle = player == PieceType.black
        ? Styling.scoreTextBlack.copyWith(color: theme.scoreBlack)
        : Styling.scoreText.copyWith(color: theme.scoreWhite);

    return DecoratedBox(
      decoration: (model.player == player)
          ? (player == PieceType.black
              ? BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 2.0, color: theme.scoreBlack),
                  ),
                )
              : BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 2.0, color: theme.scoreWhite),
                  ),
                ))
          : Styling.inactivePlayerIndicator,
      child: Column(
        children: <Widget>[
          Text(
            label,
            textAlign: TextAlign.center,
            style: labelStyle,
          ),
          Text(
            scoreText,
            textAlign: TextAlign.center,
            style: scoreStyle,
          )
        ],
      ),
    );
  }

  List<Widget> _buildGameBoardDisplay(
      BuildContext context, GameModel model, double boxWidth, AppTheme theme) {
    final rows = <Widget>[];

    double lineMargin = boxWidth > 40 ? 2.0 : 1.0;

    final showLegalMoveHints =
        _showHints && model.player != _computerColor && !model.gameIsOver;
    final legalMoveHints = showLegalMoveHints
        ? model.board.getMovesForPlayer(model.player)
        : const <Position>[];

    for (var y = 0; y < GameBoard.height; y++) {
      final spots = <Widget>[];

      for (var x = 0; x < GameBoard.width; x++) {
        PieceType type = model.board.getPieceAtLocation(x, y);
        final isLastMove = _lastMove?.x == x && _lastMove?.y == y;
        final isLegalMoveHint = type == PieceType.empty &&
            legalMoveHints.any((p) => p.x == x && p.y == y);

        spots.add(Container(
          key: ValueKey('cell-$x-$y'),
          margin: EdgeInsets.all(lineMargin),
          width: boxWidth,
          height: boxWidth,
          decoration: BoxDecoration(
            gradient: theme.pieceGradients[PieceType.empty],
          ),
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              _attemptUserMove(model, x, y);
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                FlipPiece(
                  type: type,
                  size: boxWidth,
                  isLastMove: isLastMove,
                  theme: theme,
                  duration: Styling.pieceFlipDuration,
                ),
                if (isLegalMoveHint)
                  Container(
                    width: boxWidth * 0.3,
                    height: boxWidth * 0.3,
                    decoration: BoxDecoration(
                      color: theme.hintDot,
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),
          ),
        ));
      }

      rows.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: spots,
      ));
    }

    return rows;
  }

  // Builds out the Widget tree using the most recent GameModel from the stream.
  Widget _buildWidgets(BuildContext context, GameModel model) {
    final theme = ThemeController.instance.theme;
    // Fixed-height chrome that always surrounds the board, used to work out
    // how much vertical space is actually left for the board itself so it
    // never gets clipped or pushed off screen on smaller devices.
    const headerHeight = 90.0;
    const spacingHeight = 20.0 + 10.0 + 20.0;
    const resultTextHeight = 20.0;
    // Only reserve banner space when ads can actually show.
    final adReservedHeight = AdsManager.adsEnabled ? 60.0 : 0.0;
    const verticalPadding = 30.0 + 20.0;

    final needsHintButton = !widget.settings.twoPlayerMode &&
        widget.settings.difficulty != Difficulty.easy &&
        !_hintsUnlocked;
    final needsRewardedUndo = !widget.settings.twoPlayerMode &&
        widget.settings.difficulty == Difficulty.hard;

    return Container(
      padding: EdgeInsets.only(top: 30.0, left: 15.0, right: 15.0),
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
        child: LayoutBuilder(builder: (context, constraints) {
          double width = constraints.maxWidth;
          double sideMargin = max(width * 0.08, 15);
          double widthBasedBoxWidth = (width - sideMargin * 2 - 7) / 8;

          // Always reserve space for (when enabled) the banner ad, even before
          // it appears: the board must keep the exact same size for the whole
          // game, never resizing mid-play when the ad loads.
          double reservedHeight = headerHeight +
              spacingHeight +
              verticalPadding +
              resultTextHeight +
              adReservedHeight;
          double availableBoardHeight = constraints.maxHeight - reservedHeight;
          double heightBasedBoxWidth = (availableBoardHeight - 7) / 8;

          double boxWidth = min(widthBasedBoxWidth, heightBasedBoxWidth)
              .clamp(20.0, widthBasedBoxWidth);

          final undoEnabled = _canUndo &&
              (_freeUndoAllowed ||
                  _rewardedUndoCharges > 0 ||
                  needsRewardedUndo);

          return SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildScoreBox(PieceType.black, model, theme),
                    _buildScoreBox(PieceType.white, model, theme),
                    SizedBox(
                      width: 52,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: undoEnabled
                            ? () {
                                if (_undoAllowed) {
                                  _undoLastMove();
                                } else if (needsRewardedUndo && _canUndo) {
                                  _requestRewardedUndo();
                                }
                              }
                            : null,
                        child: Icon(
                          CupertinoIcons.arrow_uturn_left,
                          size: 20,
                          color: Color(0xffffffff),
                        ),
                        style: _circleButtonStyle.copyWith(
                          backgroundColor:
                              WidgetStatePropertyAll(theme.buttonFill),
                        ),
                      ),
                    ),
                    if (needsHintButton)
                      SizedBox(
                        width: 52,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: model.gameIsOver
                              ? null
                              : _requestRewardedHints,
                          child: Icon(
                            CupertinoIcons.lightbulb,
                            size: 20,
                            color: Color(0xffffffff),
                          ),
                          style: _circleButtonStyle.copyWith(
                            backgroundColor:
                                WidgetStatePropertyAll(theme.buttonFill),
                          ),
                        ),
                      ),
                    SizedBox(
                      width: 52,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            fadeRoute((context) => const StartScreen()),
                          );
                        },
                        child: Icon(
                          CupertinoIcons.refresh_bold,
                          size: 20,
                          color: Color(0xffffffff),
                        ),
                        style: _circleButtonStyle.copyWith(
                          backgroundColor:
                              WidgetStatePropertyAll(theme.buttonFill),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 52,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => const MorePage()));
                        },
                        child: Icon(
                          CupertinoIcons.question,
                          size: 20,
                          color: Color(0xffffffff),
                        ),
                        style: _circleButtonStyle.copyWith(
                          backgroundColor:
                              WidgetStatePropertyAll(theme.buttonFill),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20),
                ThinkingIndicator(
                  color: theme.thinking,
                  height: Styling.thinkingSize,
                  visible: model.player == _computerColor,
                ),
                SizedBox(height: 10),
                ..._buildGameBoardDisplay(context, model, boxWidth, theme),
                SizedBox(height: 20),
                // The banner ad sits below the board in normal document
                // flow so it can never overlap or block board taps.
                if (_isAdLoaded)
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
                    height: 50.0,
                    child: AdWidget(ad: _ad!),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

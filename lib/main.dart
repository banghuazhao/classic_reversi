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
import 'game_board.dart';
import 'game_model.dart';
import 'game_settings.dart';
import 'generated/l10n.dart';
import 'more_page.dart';
import 'move_finder.dart';
import 'settings_service.dart';
import 'start_screen.dart';
import 'styling.dart';
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

    // Ad SDK initialization must never be allowed to take down app startup:
    // a bad network response, missing config, or SDK bug here would
    // otherwise crash the app on every single launch.
    () async {
      try {
        await MobileAds.instance.initialize();
      } catch (error) {
        print('MobileAds initialization failed: $error');
      }
    }();

    try {
      AdsManager.debugPrintID();
    } catch (error) {
      print('debugPrintID failed: $error');
    }

    InAppReviewHelper.checkAndAskForReview().catchError((Object error) {
      print('In-app review check failed: $error');
    });

    SystemChrome.setPreferredOrientations(
            [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
        .then((_) {
      runApp(MyApp());
    }).catchError((Object error) {
      // Even if setting the preferred orientation fails, the app must still launch.
      print('setPreferredOrientations failed: $error');
      runApp(MyApp());
    });
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
      localeResolutionCallback: (locale, supportLocales) {
        print(locale);
        // 中文 简繁体处理
        if (locale?.languageCode == 'zh') {
          if (locale?.scriptCode == 'Hant') {
            return const Locale('zh', 'HK'); //繁体
          } else {
            return const Locale('zh', ''); //简体
          }
        }
        if (locale?.languageCode == 'ja') {
          return const Locale('ja', ''); //日语
        }
        return Locale('en', '');
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

  AppLifecycleReactor? _appLifecycleReactor;

  // The square the most recently placed piece landed on, so it can be
  // highlighted and is easy to spot (especially after the CPU moves).
  Position? _lastMove;

  // Snapshots of the board from just before each human move, used to
  // support taking a move back. Cleared on undo so only one undo can be
  // used per turn until another move is made.
  final List<GameModel> _historyStack = [];
  bool _canUndo = false;

  PieceType get _computerColor => widget.settings.twoPlayerMode
      ? PieceType.empty
      : getOpponent(widget.settings.humanColor);

  bool get _undoAllowed =>
      _canUndo &&
      (widget.settings.twoPlayerMode ||
          widget.settings.difficulty != Difficulty.hard);

  // Below is the combination of streams that controls the flow of the game.
  // There are two streams of models produced by player interaction (either by
  // restarting the game, which produces a brand new game model and sends it
  // downstream, or tapping on one of the board locations to play a piece, and
  // which creates a new board model with the result of the move and sends it
  // downstream. The StreamGroup combines these into a single stream, then
  // does a little trick with asyncExpand.
  //
  // The function used in asyncExpand checks to see if it's the CPU's turn,
  // and if so creates a [MoveFinder] to look for the best move. It awaits the
  // calculation, and then creates a new [GameModel] with the result of that
  // move and sends it downstream by yielding it. If it's still the CPU's turn
  // after making that move (which can happen in reversi), this is repeated.
  // In 2-player mode there is no CPU, so this loop never runs.
  //
  // The final stream of models that exits the asyncExpand call is a
  // combination of "new game" models, models with the results of player
  // moves, and models with the results of CPU moves. These are fed into the
  // StreamBuilder in [build], and used to create the widgets that comprise
  // the game's display.
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
          newModel = newModel.updateForMove(move.x, move.y);
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
    _restartController.add(GameModel(board: GameBoard()));

    if (!kIsWeb) {
      // Ad setup must never be able to crash the game screen: a failure here
      // (bad ad unit config, SDK not ready, etc.) should just mean no ads.
      try {
        _ad = BannerAd(
          adUnitId: AdsManager.bannerAdUnitId,
          size: AdSize.banner,
          request: AdRequest(),
          listener: BannerAdListener(
            onAdLoaded: (_) {
              if (mounted) {
                setState(() {
                  _isAdLoaded = true;
                });
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

        AppOpenAdManager appOpenAdManager = AppOpenAdManager()..loadAd();
        _appLifecycleReactor =
            AppLifecycleReactor(appOpenAdManager: appOpenAdManager);
        _appLifecycleReactor?.listenToAppStateChanges();
      } catch (error) {
        print('Ad setup failed: $error');
      }
    }
  }

  // Thou shalt tidy up thy stream controllers.
  @override
  void dispose() {
    _userMovesController.close();
    _restartController.close();
    super.dispose();
  }

  /// The build method mostly just sets up the StreamBuilder and leaves the
  /// details to _buildWidgets.
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<GameModel>(
      stream: _modelStream,
      builder: (context, snapshot) {
        final model =
            snapshot.hasData ? snapshot.data! : GameModel(board: GameBoard());
        _handleGameOverIfNeeded(model);
        return _buildWidgets(context, model);
      },
    );
  }

  // Records the win/loss record and, the very first time the player ever
  // wins, prompts for a store review at that high point. Single-player only:
  // 2-player local matches aren't attributed to either side. Guarded so it
  // only fires once per game, right as it ends.
  bool _gameOverHandled = false;

  void _handleGameOverIfNeeded(GameModel model) {
    if (!model.gameIsOver) {
      _gameOverHandled = false;
      return;
    }
    if (_gameOverHandled || widget.settings.twoPlayerMode) {
      return;
    }
    _gameOverHandled = true;

    if (model.blackScore == model.whiteScore) {
      return;
    }

    final humanWon = model.blackScore > model.whiteScore
        ? widget.settings.humanColor == PieceType.black
        : widget.settings.humanColor == PieceType.white;

    if (humanWon) {
      SettingsService.incrementWins();
      SettingsService.getHasWonOnce().then((hasWonOnce) {
        if (!hasWonOnce) {
          SettingsService.setHasWonOnce();
          InAppReviewHelper.requestReviewAfterFirstWin();
        }
      });
    } else {
      SettingsService.incrementLosses();
    }
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
      _userMovesController.add(model.updateForMove(x, y));
    }
  }

  void _undoLastMove() {
    if (!_undoAllowed || _historyStack.isEmpty) {
      return;
    }
    final previousModel = _historyStack.removeLast();
    _canUndo = false;
    _lastMove = null;
    _restartController.add(previousModel);
  }

  static final ButtonStyle _circleButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: Color(0x60421E08),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35.0)),
    padding: EdgeInsets.zero,
    minimumSize: Size.zero,
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    elevation: 0,
  );

  Widget _buildScoreBox(PieceType player, GameModel model) {
    var label = player == PieceType.black ? 'black' : 'white';
    var scoreText = player == PieceType.black
        ? '${model.blackScore}'
        : '${model.whiteScore}';

    return DecoratedBox(
      decoration: (model.player == player)
          ? (player == PieceType.black
              ? Styling.activePlayerIndicatorBlack
              : Styling.activePlayerIndicator)
          : Styling.inactivePlayerIndicator,
      child: Column(
        children: <Widget>[
          Text(
            label,
            textAlign: TextAlign.center,
            style: player == PieceType.black
                ? Styling.scoreLabelTextBlack
                : Styling.scoreLabelText,
          ),
          Text(
            scoreText,
            textAlign: TextAlign.center,
            style: player == PieceType.black
                ? Styling.scoreTextBlack
                : Styling.scoreText,
          )
        ],
      ),
    );
  }

  List<Widget> _buildGameBoardDisplay(
      BuildContext context, GameModel model, double boxWidth) {
    final rows = <Widget>[];

    double lineMargin = boxWidth > 40 ? 2.0 : 1.0;

    // On Easy difficulty (single-player only), show a subtle marker on every
    // legal move so beginners can learn the rules without getting stuck.
    final showLegalMoveHints = !widget.settings.twoPlayerMode &&
        widget.settings.difficulty == Difficulty.easy;
    final legalMoveHints = showLegalMoveHints && model.player != _computerColor
        ? model.board.getMovesForPlayer(model.player)
        : const <Position>[];

    for (var y = 0; y < GameBoard.height; y++) {
      final spots = <Widget>[];

      for (var x = 0; x < GameBoard.width; x++) {
        PieceType type = model.board.getPieceAtLocation(x, y);
        final isLastMove = _lastMove?.x == x && _lastMove?.y == y;
        final isLegalMoveHint = type == PieceType.empty &&
            legalMoveHints.any((p) => p.x == x && p.y == y);

        spots.add(AnimatedContainer(
          duration: Duration(
            milliseconds: 500,
          ),
          margin: EdgeInsets.all(lineMargin),
          decoration: BoxDecoration(
              gradient: Styling.pieceGradients[type],
              border: isLastMove
                  ? Border.all(
                      color: Color(0xffFFC107),
                      width: max(boxWidth * 0.08, 3),
                      strokeAlign: BorderSide.strokeAlignInside,
                    )
                  : null,
              borderRadius: BorderRadius.all(
                  Radius.circular(type == PieceType.empty ? 0 : boxWidth))),
          child: SizedBox(
            width: boxWidth,
            height: boxWidth,
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (isLegalMoveHint)
                  Container(
                    width: boxWidth * 0.3,
                    height: boxWidth * 0.3,
                    decoration: BoxDecoration(
                      color: Color(0x60ffffff),
                      shape: BoxShape.circle,
                    ),
                  ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    _attemptUserMove(model, x, y);
                  },
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
    // Fixed-height chrome that always surrounds the board, used to work out
    // how much vertical space is actually left for the board itself so it
    // never gets clipped or pushed off screen on smaller devices.
    const headerHeight = 90.0;
    const spacingHeight = 20.0 + 10.0 + 20.0;
    const resultTextHeight = 70.0;
    const adReservedHeight = 60.0;
    const verticalPadding = 30.0 + 20.0;

    return Container(
      padding: EdgeInsets.only(top: 30.0, left: 15.0, right: 15.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Styling.backgroundStartColor,
            Styling.backgroundFinishColor,
          ],
        ),
      ),
      child: SafeArea(
        child: LayoutBuilder(builder: (context, constraints) {
          double width = constraints.maxWidth;
          double sideMargin = max(width * 0.08, 15);
          double widthBasedBoxWidth = (width - sideMargin * 2 - 7) / 8;

          double reservedHeight = headerHeight +
              spacingHeight +
              verticalPadding +
              (model.gameIsOver ? resultTextHeight : 0) +
              (_isAdLoaded ? adReservedHeight : 0);
          double availableBoardHeight = constraints.maxHeight - reservedHeight;
          double heightBasedBoxWidth = (availableBoardHeight - 7) / 8;

          double boxWidth = min(widthBasedBoxWidth, heightBasedBoxWidth)
              .clamp(20.0, widthBasedBoxWidth);

          return SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildScoreBox(PieceType.black, model),
                    _buildScoreBox(PieceType.white, model),
                    SizedBox(
                      width: 56,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _undoAllowed ? _undoLastMove : null,
                        child: Icon(
                          CupertinoIcons.arrow_uturn_left,
                          size: 22,
                          color: Color(0xffffffff),
                        ),
                        style: _circleButtonStyle,
                      ),
                    ),
                    SizedBox(
                      width: 56,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            fadeRoute((context) => const StartScreen()),
                          );
                        },
                        child: Icon(
                          CupertinoIcons.refresh_bold,
                          size: 22,
                          color: Color(0xffffffff),
                        ),
                        style: _circleButtonStyle,
                      ),
                    ),
                    SizedBox(
                      width: 56,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => const MorePage()));
                        },
                        child: Icon(
                          CupertinoIcons.question,
                          size: 22,
                          color: Color(0xffffffff),
                        ),
                        style: _circleButtonStyle,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20),
                ThinkingIndicator(
                  color: Styling.thinkingColor,
                  height: Styling.thinkingSize,
                  visible: model.player == _computerColor,
                ),
                SizedBox(height: 10),
                ..._buildGameBoardDisplay(context, model, boxWidth),
                SizedBox(height: 20),
                if (model.gameIsOver)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                    child: Text(
                      model.gameResultString,
                      style: Styling.resultText,
                    ),
                  ),
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

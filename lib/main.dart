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
import 'Tools/in_app_reviewer_helper.dart' if (dart.library.io) 'Tools/in_app_reviewer_helper.dart';
import 'game_board.dart';
import 'game_model.dart';
import 'generated/l10n.dart';
import 'more_page.dart';
import 'move_finder.dart';
import 'styling.dart';
import 'thinking_indicator.dart';

/// Main function for the app. Turns off the system overlays and locks portrait
/// orientation for a more game-like UI, and then runs the [Widget] tree.
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb) {
    Future.delayed(const Duration(seconds: 1), () {
      AppTrackingTransparency.requestTrackingAuthorization();
    });

    MobileAds.instance.initialize();

    AdsManager.debugPrintID();

    InAppReviewHelper.checkAndAskForReview();

    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
      runApp(MyApp());
    });
  } else {
    runApp(MyApp());
  }
}

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

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
          pageBuilder: (context, animation, secondaryAnimation) => GameScreen(),
        );
      },
    );
  }
}

/// The [GameScreen] Widget represents the entire game
/// display, from scores to board state and everything in between.
class GameScreen extends StatefulWidget {
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
  final StreamController<GameModel> _userMovesController = StreamController<GameModel>();
  final StreamController<GameModel> _restartController = StreamController<GameModel>();
  Stream<GameModel>? _modelStream;

  BannerAd? _ad;

  bool _isAdLoaded = false;

  AppLifecycleReactor? _appLifecycleReactor;

  _GameScreenState() {
    // Below is the combination of streams that controls the flow of the game.
    // There are two streams of models produced by player interaction (either by
    // restarting the game, which produces a brand new game model and sends it
    // downstream, or tapping on one of the board locations to play a piece, and
    // which creates a new board model with the result of the move and sends it
    // downstream. The StreamGroup combines these into a single stream, then
    // does a little trick with asyncExpand.
    //
    // The function used in asyncExpand checks to see if it's the CPU's turn
    // (white), and if so creates a [MoveFinder] to look for the best move. It
    // awaits the calculation, and then creates a new [GameModel] with the
    // result of that move and sends it downstream by yielding it. If it's still
    // the CPU's turn after making that move (which can happen in reversi), this
    // is repeated.
    //
    // The final stream of models that exits the asyncExpand call is a
    // combination of "new game" models, models with the results of player
    // moves, and models with the results of CPU moves. These are fed into the
    // StreamBuilder in [build], and used to create the widgets that comprise
    // the game's display.
    _modelStream = StreamGroup.merge([
      _userMovesController.stream,
      _restartController.stream,
    ]).asyncExpand((model) async* {
      yield model;

      var newModel = model;

      while (newModel.player == PieceType.white) {
        final finder = MoveFinder(newModel.board);
        final move = await finder.findNextMove(newModel.player, 5);
        if (move != null) {
          newModel = newModel.updateForMove(move.x, move.y);
          yield newModel;
        }
      }
    });
  }

  @override
  initState() {
    super.initState();

    if (!kIsWeb) {
      _ad = BannerAd(
        adUnitId: AdsManager.bannerAdUnitId,
        size: AdSize.banner,
        request: AdRequest(),
        listener: BannerAdListener(
          onAdLoaded: (_) {
            setState(() {
              _isAdLoaded = true;
            });
          },
          onAdFailedToLoad: (ad, error) {
            // Releases an ad resource when it fails to load
            ad.dispose();

            print('Ad load failed (code=${error.code} message=${error.message})');
          },
        ),
      );

      _ad?.load();

      AppOpenAdManager appOpenAdManager = AppOpenAdManager()..loadAd();
      _appLifecycleReactor = AppLifecycleReactor(appOpenAdManager: appOpenAdManager);
      _appLifecycleReactor?.listenToAppStateChanges();
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
        return _buildWidgets(
          context,
          snapshot.hasData ? snapshot.data! : GameModel(board: GameBoard()),
        );
      },
    );
  }

  // Called when the user taps on the game's board display. If it's the player's
  // turn, this method will attempt to make the move, creating a new GameModel
  // in the process.
  void _attemptUserMove(GameModel model, int x, int y) {
    if (model.player == PieceType.black && model.board.isLegalMove(x, y, model.player)) {
      _userMovesController.add(model.updateForMove(x, y));
    }
  }

  Widget _buildScoreBox(PieceType player, GameModel model) {
    var label = player == PieceType.black ? 'black' : 'white';
    var scoreText = player == PieceType.black ? '${model.blackScore}' : '${model.whiteScore}';

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
            style: player == PieceType.black ? Styling.scoreLabelTextBlack : Styling.scoreLabelText,
          ),
          Text(
            scoreText,
            textAlign: TextAlign.center,
            style: player == PieceType.black ? Styling.scoreTextBlack : Styling.scoreText,
          )
        ],
      ),
    );
  }

  List<Widget> _buildGameBoardDisplay(BuildContext context, GameModel model) {
    final rows = <Widget>[];

    double width = MediaQuery.of(context).size.width;

    double sideMargin = max(width * 0.08, 15);
    double boxWidth;
    if (kIsWeb) {
      boxWidth = 40;
    } else {
      boxWidth = (width - sideMargin * 2 - 7) / 8;
    }
    double lineMargin = sideMargin > 40 ? 2.0 : 1.0;

    for (var y = 0; y < GameBoard.height; y++) {
      final spots = <Widget>[];

      for (var x = 0; x < GameBoard.width; x++) {
        PieceType type = model.board.getPieceAtLocation(x, y);

        spots.add(AnimatedContainer(
          duration: Duration(
            milliseconds: 500,
          ),
          margin: EdgeInsets.all(lineMargin),
          decoration: BoxDecoration(
              gradient: Styling.pieceGradients[type],
              borderRadius:
                  BorderRadius.all(Radius.circular(type == PieceType.empty ? 0 : boxWidth))),
          child: SizedBox(
            width: boxWidth,
            height: boxWidth,
            child: GestureDetector(
              onTap: () {
                _attemptUserMove(model, x, y);
              },
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
        child: Stack(children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildScoreBox(PieceType.black, model),
                  _buildScoreBox(PieceType.white, model),
                  SizedBox(
                    width: 70,
                    height: 70,
                    child: ElevatedButton(
                      onPressed: () {
                        _restartController.add(
                          GameModel(board: GameBoard()),
                        );
                      },
                      child: Icon(
                        Icons.refresh_rounded,
                        size: 36,
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Color(0x60421E08)),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(35.0)))),
                    ),
                  ),
                  SizedBox(
                    width: 70,
                    height: 70,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context, CupertinoPageRoute(builder: (context) => const MorePage()));
                      },
                      child: Icon(
                        Icons.help_outline_rounded,
                        size: 36,
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Color(0x60421E08)),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(35.0)))),
                    ),
                  )
                ],
              ),
              SizedBox(height: 20),
              ThinkingIndicator(
                color: Styling.thinkingColor,
                height: Styling.thinkingSize,
                visible: model.player == PieceType.white,
              ),
              SizedBox(height: 20),
              ..._buildGameBoardDisplay(context, model),
              SizedBox(height: 30),
              if (model.gameIsOver)
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                  child: Text(
                    model.gameResultString,
                    style: Styling.resultText,
                  ),
                ),
            ],
          ),
          if (_isAdLoaded)
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
                child: AdWidget(ad: _ad!),
                height: 50.0,
              ),
            ),
        ]),
      ),
    );
  }
}

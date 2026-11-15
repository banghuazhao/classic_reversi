// Renders the Mac App Store screenshots from the real macOS app at 2880x1800.
//
//   flutter drive -d macos \
//     --driver=test_driver/integration_test.dart \
//     --target=integration_test/mac_store_screenshots_test.dart
//
// PNGs land in build/mac_store_screenshots (override with SCREENSHOTS_DIR).
import 'dart:convert';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:classic_reversi/Tools/ads_manager.dart';
import 'package:classic_reversi/Tools/purchase_service.dart';
import 'package:classic_reversi/app_theme.dart';
import 'package:classic_reversi/game_board.dart';
import 'package:classic_reversi/game_model.dart';
import 'package:classic_reversi/game_review_screen.dart';
import 'package:classic_reversi/game_session.dart';
import 'package:classic_reversi/game_settings.dart';
import 'package:classic_reversi/main.dart';
import 'package:classic_reversi/premium_screen.dart';
import 'package:classic_reversi/settings_service.dart';
import 'package:classic_reversi/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 16:10, the Mac App Store's 1440x900 screenshot size at 2x.
const _logicalSize = Size(1440, 900);
const _pixelRatio = 2.0;

const _vsComputer = GameSettings(
  difficulty: Difficulty.hard,
  twoPlayerMode: false,
);

final _frame = GlobalKey();
final _shots = <String, String>{};

/// A plausible game: random legal moves from a fixed seed.
List<GameModel> _playedGame({required int seed, int? moves}) {
  final random = Random(seed);
  final history = [GameModel.initial()];
  while (
      !history.last.gameIsOver && (moves == null || history.length <= moves)) {
    final model = history.last;
    final legal = model.board.getMovesForPlayer(model.player);
    final move = legal[random.nextInt(legal.length)];
    history.add(model.updateForMove(move.x, move.y)!);
  }
  return history;
}

/// A mid-game position where it is the human's (black's) turn.
List<GameModel> _midGame() {
  for (var seed = 3;; seed++) {
    final history = _playedGame(seed: seed, moves: 24);
    final model = history.last;
    if (!model.gameIsOver &&
        model.player == PieceType.black &&
        (model.blackScore - model.whiteScore).abs() <= 6) {
      return history;
    }
  }
}

/// A finished game the black player won, for the review screen.
List<GameModel> _finishedGame() {
  for (var seed = 11;; seed++) {
    final history = _playedGame(seed: seed);
    final model = history.last;
    if (model.blackScore > model.whiteScore + 6) return history;
  }
}

Future<void> _settle(WidgetTester tester, [int seconds = 1]) async {
  await tester.pumpAndSettle();
  await Future<void>.delayed(Duration(seconds: seconds));
  await tester.pumpAndSettle();
}

Future<void> _capture(WidgetTester tester, String name) async {
  await _settle(tester);
  final boundary =
      _frame.currentContext!.findRenderObject()! as RenderRepaintBoundary;
  final image = await boundary.toImage(pixelRatio: _pixelRatio);
  final png = await image.toByteData(format: ui.ImageByteFormat.png);
  image.dispose();
  _shots[name] = base64Encode(png!.buffer.asUint8List());
}

NavigatorState _navigator(WidgetTester tester) =>
    tester.state<NavigatorState>(find.byType(Navigator).first);

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Mac App Store screenshots', (tester) async {
    tester.view.physicalSize = _logicalSize * _pixelRatio;
    tester.view.devicePixelRatio = _pixelRatio;
    tester.platformDispatcher.localesTestValue = const [Locale('en', 'US')];
    tester.platformDispatcher.localeTestValue = const Locale('en', 'US');
    addTearDown(tester.view.reset);
    addTearDown(tester.platformDispatcher.clearAllTestValues);

    // Keep the user's real preferences untouched and the run silent.
    SharedPreferences.setMockInitialValues({
      'soundEnabled': false,
      'hapticsEnabled': false,
    });
    AdsManager.disableAllAdsForScreenshot = true;
    await ThemeController.instance.load();
    await GameSessionService.save(GameSession(
      settings: _vsComputer,
      timeline: _midGame(),
    ));

    await tester.pumpWidget(RepaintBoundary(key: _frame, child: const MyApp()));
    await _capture(tester, '01_home');

    _navigator(tester).push(fadeRoute((_) => const PremiumScreen()));
    await _capture(tester, '05_premium');
    _navigator(tester).pop();
    await _settle(tester);

    await PurchaseService.instance.debugSetPremium(true);
    await tester.tap(find.text('Continue game'));
    await _capture(tester, '02_game');

    // The tip's explanation is a snack bar; capture it while it is showing.
    await tester.tap(find.byTooltip('Coach tip'));
    for (var i = 0; i < 100 && find.byType(SnackBar).evaluate().isEmpty; i++) {
      await Future<void>.delayed(const Duration(milliseconds: 100));
      await tester.pump();
    }
    await _capture(tester, '03_coach_tip');

    _navigator(tester).push(fadeRoute((_) => GameReviewScreen(
          history: _finishedGame(),
          settings: _vsComputer,
          playedAt: DateTime.now(),
        )));
    await _settle(tester, 6);
    await Scrollable.ensureVisible(
      tester.element(find.text('Game analysis').last),
      alignment: 0.05,
    );
    await _capture(tester, '04_game_analysis');
    _navigator(tester).pop();
    await _settle(tester);

    await ThemeController.instance.setTheme(BoardThemeId.royal);
    await _capture(tester, '06_royal_theme');

    // Leave the shared singletons as a fresh launch would find them.
    await ThemeController.instance.setTheme(BoardThemeId.classic);
    await PurchaseService.instance.debugSetPremium(false);
    await SettingsService.setPremiumUnlocked(false);
    binding.reportData = _shots;
  });
}

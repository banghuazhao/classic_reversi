import 'dart:ui' as ui;

import 'package:classic_reversi/app_theme.dart';
import 'package:classic_reversi/game_model.dart';
import 'package:classic_reversi/game_settings.dart';
import 'package:classic_reversi/gameplay_activity.dart';
import 'package:classic_reversi/generated/l10n.dart';
import 'package:classic_reversi/result_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:share_plus/share_plus.dart';

GameModel finishedGame({int size = 8}) {
  var model = GameModel.initial(boardSize: size);
  while (!model.gameIsOver) {
    final move = model.board.getMovesForPlayer(model.player).first;
    model = model.updateForMove(move.x, move.y)!;
  }
  return model;
}

ResultCardData cardData(GameModel model) => ResultCardData(
      model: model,
      title: 'Classic Reversi',
      result: 'A finished game',
      mode: 'Easy',
      date: 'Oct 24, 2026',
      blackLabel: 'Black',
      whiteLabel: 'White',
      shareText: 'A finished game of Classic Reversi',
      semanticLabel: 'Final board and scores',
    );

Widget app(Widget screen, {double scale = 1}) => MaterialApp(
      locale: const Locale('en'),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: S.delegate.supportedLocales,
      builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaler: TextScaler.linear(scale)),
          child: child!),
      home: screen,
    );

void main() {
  testWidgets('preparing a result card fits the largest text on a small phone',
      (tester) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(320, 568);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);
    await tester.pumpWidget(app(
        Builder(
            builder: (context) => Scaffold(
                  body: TextButton(
                      onPressed: () => showResultCard(context,
                          model: finishedGame(),
                          settings: const GameSettings(
                              difficulty: Difficulty.easy,
                              twoPlayerMode: false)),
                      child: const Text('Open')),
                )),
        scale: 3.2));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Open'));
    await tester.pump();
    expect(find.text('Creating your result card…'), findsOneWidget);
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox());
    await tester.pumpAndSettle();
  });

  for (final size in [6, 8]) {
    testWidgets('result PNG includes an opaque full-size $size by $size board',
        (tester) async {
      await tester.runAsync(() async {
        final data = cardData(finishedGame(size: size));
        final bytes = await renderResultCard(data, AppTheme.classic);
        expect(bytes.take(8), orderedEquals([137, 80, 78, 71, 13, 10, 26, 10]));
        final codec = await ui.instantiateImageCodec(bytes);
        final frame = await codec.getNextFrame();
        expect(frame.image.width, 1080);
        expect(frame.image.height, 1600);
        final raw =
            await frame.image.toByteData(format: ui.ImageByteFormat.rawRgba);
        expect(raw!.getUint8(3), 255);
        frame.image.dispose();
        codec.dispose();
        final night = await renderResultCard(data, AppTheme.night);
        expect(night, isNot(orderedEquals(bytes)));
      });
    });
  }

  testWidgets(
      'export represents the supplied board and tolerates long localized labels',
      (tester) async {
    await tester.runAsync(() async {
      final first = cardData(finishedGame());
      final other = ResultCardData(
        model: GameModel.initial(),
        title: first.title,
        result: first.result,
        mode: first.mode,
        date: first.date,
        blackLabel: first.blackLabel,
        whiteLabel: first.whiteLabel,
        shareText: first.shareText,
        semanticLabel: first.semanticLabel,
      );
      final bytes = await renderResultCard(first, AppTheme.classic);
      final opening = await renderResultCard(other, AppTheme.classic);
      expect(opening, isNot(orderedEquals(bytes)));
      final localized = ResultCardData(
        model: first.model,
        title: 'クラシックリバーシ・本日のチャレンジ',
        result: 'Поздравляем с завершением игры!',
        mode: 'Два игрока на одном устройстве — дружеский матч',
        date: '24 ottobre 2026',
        blackLabel: 'Черные',
        whiteLabel: 'Белые',
        shareText: first.shareText,
        semanticLabel: first.semanticLabel,
      );
      expect(await renderResultCard(localized, AppTheme.contrast), isNotEmpty);
    });
  });

  testWidgets(
      'preview shows share failures in the sheet and retries the PNG attachment',
      (tester) async {
    ShareParams? captured;
    var attempts = 0;
    final model = finishedGame();
    await tester.pumpWidget(app(Builder(
        builder: (context) => Scaffold(
              body: TextButton(
                  onPressed: () => showResultCard(
                        context,
                        model: model,
                        settings: const GameSettings(
                            difficulty: Difficulty.easy, twoPlayerMode: false),
                        playedAt: DateTime(2026, 10, 24),
                        shareAction: (params) async {
                          attempts++;
                          if (attempts == 1) {
                            throw StateError('Share service unavailable');
                          }
                          captured = params;
                          return const ShareResult(
                              'test', ShareResultStatus.success);
                        },
                      ),
                  child: const Text('Open result card')),
            ))));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Open result card'));
    await tester.pump();
    for (var attempt = 0;
        attempt < 50 && find.byType(Image).evaluate().isEmpty;
        attempt++) {
      await tester.runAsync(
          () => Future<void>.delayed(const Duration(milliseconds: 20)));
      await tester.pump(const Duration(milliseconds: 20));
    }
    expect(find.byType(Image), findsOneWidget);
    expect(GameplayActivity.isPlaying, isTrue);
    await tester.ensureVisible(find.text('Share'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Share'));
    await tester.pumpAndSettle();
    final error = find.byKey(const ValueKey('result-share-error'));
    expect(find.descendant(of: find.byType(BottomSheet), matching: error),
        findsOneWidget);
    expect(captured, isNull);
    await tester.ensureVisible(error);
    await tester.pumpAndSettle();
    expect(tester.getRect(error).bottom, lessThanOrEqualTo(600));
    await tester.ensureVisible(find.text('Share'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Share'));
    await tester.pumpAndSettle();
    expect(error, findsNothing);
    expect(attempts, 2);
    expect(captured, isNotNull);
    expect(captured!.files, hasLength(1));
    expect(captured!.files!.single.mimeType, 'image/png');
    expect(captured!.fileNameOverrides, ['classic-reversi.png']);
    expect(captured!.text, contains('Classic Reversi'));
    expect(captured!.sharePositionOrigin!.width, greaterThan(0));
    final bytes =
        await tester.runAsync(() => captured!.files!.single.readAsBytes());
    expect(bytes!.take(8), orderedEquals([137, 80, 78, 71, 13, 10, 26, 10]));
    await tester.pumpWidget(const SizedBox());
    await tester.pumpAndSettle();
    expect(GameplayActivity.isPlaying, isFalse);
  });
}

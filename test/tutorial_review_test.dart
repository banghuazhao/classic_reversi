import 'package:classic_reversi/accessible_board.dart';
import 'package:classic_reversi/game_board.dart';
import 'package:classic_reversi/game_materials.dart';
import 'package:classic_reversi/game_model.dart';
import 'package:classic_reversi/game_review_screen.dart';
import 'package:classic_reversi/gameplay_activity.dart';
import 'package:classic_reversi/generated/l10n.dart';
import 'package:classic_reversi/tutorial_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _app(Widget child, {double textScale = 1}) {
  return MaterialApp(
    localizationsDelegates: const [
      S.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: S.delegate.supportedLocales,
    builder: (context, child) => MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaler: TextScaler.linear(textScale),
        disableAnimations: true,
      ),
      child: child!,
    ),
    home: child,
  );
}

Future<void> _tapVisible(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

List<GameModel> _history() {
  final opening = GameModel.initial();
  final first = opening.board.getMovesForPlayer(opening.player).first;
  final afterFirst = opening.updateForMove(first.x, first.y)!;
  final second = afterFirst.board.getMovesForPlayer(afterFirst.player).first;
  return [opening, afterFirst, afterFirst.updateForMove(second.x, second.y)!];
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUp(() {
    // Feedback preferences are shared with gameplay. Stub the existing audio
    // service's constructor channels so these UI tests need no native plugin.
    final messenger =
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
    messenger.setMockMethodCallHandler(
      const MethodChannel('xyz.luan/audioplayers.global'),
      (_) async => null,
    );
    messenger.setMockMethodCallHandler(
      const MethodChannel('xyz.luan/audioplayers.global/events'),
      (_) async => null,
    );
    messenger.setMockMethodCallHandler(
      const MethodChannel('xyz.luan/audioplayers'),
      (call) async {
        if (call.method == 'create') {
          final playerId = (call.arguments as Map)['playerId'];
          messenger.setMockMethodCallHandler(
            MethodChannel('xyz.luan/audioplayers/events/$playerId'),
            (_) async => null,
          );
        }
        return null;
      },
    );
  });

  testWidgets(
    'tutorial requires legal captures and a corner before completion',
    (tester) async {
      bool? completed;
      await tester.pumpWidget(
        _app(
          Builder(
            builder: (context) => Scaffold(
              body: ElevatedButton(
                onPressed: () async {
                  completed = await Navigator.of(context).push<bool>(
                    MaterialPageRoute(builder: (_) => const TutorialScreen()),
                  );
                },
                child: const Text('Open tutorial'),
              ),
            ),
          ),
        ),
      );
      await _tapVisible(tester, find.text('Open tutorial'));
      expect(GameplayActivity.isPlaying, isTrue);
      expect(find.byKey(const ValueKey('tutorial-continue')), findsNothing);

      // A move outside the marked legal squares does not advance the lesson.
      await _tapVisible(
        tester,
        find.byKey(const ValueKey('accessible-cell-0-0')),
      );
      expect(find.text('Make your first capture'), findsOneWidget);
      final opening = tester.widget<AccessibleBoard>(
        find.byType(AccessibleBoard),
      );
      final first = opening.legalMoves.first;
      await _tapVisible(
        tester,
        find.byKey(ValueKey('accessible-cell-${first.x}-${first.y}')),
      );
      expect(find.text('That is a capture'), findsOneWidget);
      await _tapVisible(
        tester,
        find.byKey(const ValueKey('tutorial-continue')),
      );

      // White has made a real response, and the next legal move belongs to Black.
      final reply = tester.widget<AccessibleBoard>(
        find.byType(AccessibleBoard),
      );
      expect(reply.board.getPieceCount(PieceType.empty), 30);
      expect(reply.legalMoves, isNotEmpty);
      final second = reply.legalMoves.first;
      await _tapVisible(
        tester,
        find.byKey(ValueKey('accessible-cell-${second.x}-${second.y}')),
      );
      await _tapVisible(
        tester,
        find.byKey(const ValueKey('tutorial-continue')),
      );
      expect(find.text('Claim a corner'), findsOneWidget);
      final corner = tester.widget<AccessibleBoard>(
        find.byType(AccessibleBoard),
      );
      expect(corner.legalMoves, hasLength(1));
      expect(corner.board.isLegalMove(0, 0, PieceType.black), isTrue);
      await _tapVisible(
        tester,
        find.byKey(const ValueKey('accessible-cell-0-0')),
      );
      expect(find.text('You are ready'), findsOneWidget);
      final finished = tester.widget<AccessibleBoard>(
        find.byType(AccessibleBoard),
      );
      expect(finished.board.getPieceAtLocation(0, 0), PieceType.black);
      expect(finished.board.getPieceAtLocation(1, 0), PieceType.black);
      await _tapVisible(tester, find.text('Play an Easy game'));
      expect(completed, isTrue);
      expect(GameplayActivity.isPlaying, isFalse);
    },
  );

  testWidgets('skipping the tutorial returns false', (tester) async {
    bool? completed;
    await tester.pumpWidget(
      _app(
        Builder(
          builder: (context) => Scaffold(
            body: ElevatedButton(
              onPressed: () async {
                completed = await Navigator.of(context).push<bool>(
                  MaterialPageRoute(builder: (_) => const TutorialScreen()),
                );
              },
              child: const Text('Open tutorial'),
            ),
          ),
        ),
      ),
    );
    await _tapVisible(tester, find.text('Open tutorial'));
    await _tapVisible(tester, find.text('Skip tutorial'));
    expect(completed, isFalse);
    expect(GameplayActivity.isPlaying, isFalse);
  });

  testWidgets('board can be played with arrow keys and Enter', (tester) async {
    await tester.pumpWidget(_app(const TutorialScreen()));
    await tester.pumpAndSettle();
    Focus.of(tester.element(find.byType(MaterialBoard))).requestFocus();
    await tester.pump();
    // The first legal square is initially selected. Up goes to an invalid
    // square; returning Down and pressing Enter makes the legal capture.
    await tester.sendKeyEvent(LogicalKeyboardKey.arrowUp);
    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    await tester.pump();
    expect(find.text('Make your first capture'), findsOneWidget);
    await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);
    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    await tester.pumpAndSettle();
    expect(find.text('That is a capture'), findsOneWidget);
    await tester.pumpWidget(const SizedBox());
    expect(GameplayActivity.isPlaying, isFalse);
  });

  testWidgets(
    'review starts at the final board and replays without changing history',
    (tester) async {
      final history = _history();
      final firstMoveBoard =
          history[1].board.rows.map((row) => row.toList()).toList();
      await tester.pumpWidget(_app(GameReviewScreen(history: history)));
      await tester.pumpAndSettle();
      expect(find.text('Final position'), findsOneWidget);
      expect(tester.widget<Slider>(find.byType(Slider)).value, 2);
      expect(
        tester.widget<AccessibleBoard>(find.byType(AccessibleBoard)).board,
        same(history.last.board),
      );
      await _tapVisible(tester, find.byKey(const ValueKey('review-previous')));
      expect(
        tester.widget<AccessibleBoard>(find.byType(AccessibleBoard)).board,
        same(history[1].board),
      );
      await _tapVisible(tester, find.byKey(const ValueKey('review-first')));
      expect(find.text('Starting position'), findsOneWidget);
      expect(tester.widget<Slider>(find.byType(Slider)).value, 0);
      await _tapVisible(tester, find.byKey(const ValueKey('review-next')));
      expect(tester.widget<Slider>(find.byType(Slider)).value, 1);
      await _tapVisible(tester, find.byKey(const ValueKey('review-last')));
      expect(find.text('Final position'), findsOneWidget);
      expect(history[1].board.rows, firstMoveBoard);
      expect(history, hasLength(3));
      await tester.pumpWidget(const SizedBox());
      expect(GameplayActivity.isPlaying, isFalse);
    },
  );

  testWidgets('practice and review cells have coordinate and piece semantics', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();
    await tester.pumpWidget(_app(const TutorialScreen()));
    await tester.pumpAndSettle();
    expect(find.bySemanticsLabel('A1, Empty'), findsOneWidget);
    expect(find.bySemanticsLabel(RegExp('Legal move')), findsNWidgets(4));
    await tester.pumpWidget(_app(GameReviewScreen(history: _history())));
    await tester.pumpAndSettle();
    expect(find.bySemanticsLabel(RegExp('Last move')), findsOneWidget);
    expect(find.bySemanticsLabel(RegExp('Legal move')), findsNothing);
    semantics.dispose();
  });

  for (final size in const [Size(320, 568), Size(844, 390), Size(1024, 768)]) {
    testWidgets(
      'tutorial and review fit $size at 200% text with reduced motion',
      (tester) async {
        tester.view.devicePixelRatio = 1;
        tester.view.physicalSize = size;
        addTearDown(tester.view.resetDevicePixelRatio);
        addTearDown(tester.view.resetPhysicalSize);
        await tester.pumpWidget(_app(const TutorialScreen(), textScale: 2));
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
        await tester.ensureVisible(find.text('Skip tutorial'));
        expect(tester.takeException(), isNull);
        await tester.pumpWidget(
          _app(GameReviewScreen(history: _history()), textScale: 2),
        );
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
        await tester.ensureVisible(find.byKey(const ValueKey('review-first')));
        expect(tester.takeException(), isNull);
      },
    );
  }
}

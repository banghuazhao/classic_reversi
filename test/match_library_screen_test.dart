import 'package:classic_reversi/game_model.dart';
import 'package:classic_reversi/game_review_screen.dart';
import 'package:classic_reversi/game_settings.dart';
import 'package:classic_reversi/generated/l10n.dart';
import 'package:classic_reversi/match_library.dart';
import 'package:classic_reversi/match_library_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _settings =
    GameSettings(difficulty: Difficulty.superEasy, twoPlayerMode: true);

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('empty library explains how completed games appear',
      (tester) async {
    await tester.pumpWidget(_localized(const MatchLibraryScreen()));
    await tester.pumpAndSettle();

    expect(find.text('Your story starts here'), findsOneWidget);
    expect(find.textContaining('Finish a game'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('a completed card opens the full review at its final board',
      (tester) async {
    final history = _fullGame();
    await _flush(
        tester,
        MatchLibraryService.saveCompleted(
          settings: _settings,
          history: history,
          startedAt: DateTime.now().subtract(const Duration(minutes: 3)),
        ));
    await tester.pumpWidget(_localized(const MatchLibraryScreen()));
    await tester.pumpAndSettle();

    expect(find.text('Review match'), findsOneWidget);
    await tester.tap(find.text('Review match'));
    await tester.pumpAndSettle();

    final review =
        tester.widget<GameReviewScreen>(find.byType(GameReviewScreen));
    expect(review.history, hasLength(history.length));
    expect(review.history.last.board.rows, history.last.board.rows);
    expect(find.text('Final position'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets(
      'deletion is accessible, can be cancelled, and requires confirmation',
      (tester) async {
    await _flush(
        tester,
        MatchLibraryService.saveCompleted(
          settings: _settings,
          history: _fullGame(),
          startedAt: DateTime.now().subtract(const Duration(minutes: 3)),
        ));
    final saved = await _flush(tester, MatchLibraryService.load());
    final delete =
        find.byKey(ValueKey('delete-saved-match-${saved.single.id}'));
    await tester.pumpWidget(_localized(const MatchLibraryScreen()));
    await tester.pumpAndSettle();
    await tester.ensureVisible(delete);
    await tester.tap(delete);
    await tester.pumpAndSettle();

    expect(find.text('Delete this match?'), findsOneWidget);
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(await _flush(tester, MatchLibraryService.load()), hasLength(1));

    await tester.tap(delete);
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('confirm-delete-match')));
    await tester.pumpAndSettle();

    expect(find.text('Your story starts here'), findsOneWidget);
    expect(await _flush(tester, MatchLibraryService.load()), isEmpty);
    expect(tester.takeException(), isNull);
  });

  for (final size in [
    const Size(320, 640),
    const Size(640, 320),
    const Size(1024, 768)
  ]) {
    testWidgets('cards remain scrollable at ${size.width} wide with 320% text',
        (tester) async {
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = size;
      addTearDown(tester.view.resetDevicePixelRatio);
      addTearDown(tester.view.resetPhysicalSize);
      await _flush(
          tester,
          MatchLibraryService.saveCompleted(
            settings: _settings,
            history: _fullGame(),
            startedAt: DateTime.now().subtract(const Duration(minutes: 3)),
          ));
      await tester
          .pumpWidget(_localized(const MatchLibraryScreen(), scale: 3.2));
      await tester.pumpAndSettle();

      expect(find.byKey(const ValueKey('match-library-list')), findsOneWidget);
      await tester.drag(find.byKey(const ValueKey('match-library-list')),
          const Offset(0, -400));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    });
  }
}

Widget _localized(Widget home, {double scale = 1}) => MaterialApp(
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: const Locale('en'),
      supportedLocales: S.delegate.supportedLocales,
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: TextScaler.linear(scale)),
        child: child!,
      ),
      home: home,
    );

Future<T> _flush<T>(WidgetTester tester, Future<T> operation) async {
  late T result;
  Object? error;
  var complete = false;
  operation.then((value) {
    result = value;
    complete = true;
  }, onError: (Object failure) {
    error = failure;
    complete = true;
  });
  await tester.pump();
  expect(complete, isTrue);
  if (error != null) throw error!;
  return result;
}

List<GameModel> _fullGame() {
  final history = [GameModel.initial(boardSize: _settings.boardSize)];
  while (!history.last.gameIsOver) {
    final model = history.last;
    final move = model.board.getMovesForPlayer(model.player).first;
    history.add(model.updateForMove(move.x, move.y)!);
  }
  return history;
}

import 'package:classic_reversi/Tools/ads_manager.dart';
import 'package:classic_reversi/Tools/purchase_service.dart';
import 'package:classic_reversi/accessible_board.dart';
import 'package:classic_reversi/game_model.dart';
import 'package:classic_reversi/game_session.dart';
import 'package:classic_reversi/game_settings.dart';
import 'package:classic_reversi/generated/l10n.dart';
import 'package:classic_reversi/how_to_play_screen.dart';
import 'package:classic_reversi/main.dart';
import 'package:classic_reversi/purchase_screen.dart';
import 'package:classic_reversi/settings_screen.dart';
import 'package:classic_reversi/start_screen.dart';
import 'package:classic_reversi/stats_screen.dart';
import 'package:classic_reversi/tutorial_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:shared_preferences/shared_preferences.dart';
// Use the existing plugin contract to simulate an unsuccessful durable clear.
// ignore: depend_on_referenced_packages
import 'package:shared_preferences_platform_interface/shared_preferences_platform_interface.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
    AdsManager.disableAllAdsForScreenshot = true;
    final messenger =
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
    for (final channel in [
      'xyz.luan/audioplayers.global',
      'xyz.luan/audioplayers.global/events'
    ]) {
      messenger.setMockMethodCallHandler(
          MethodChannel(channel), (_) async => null);
    }
    messenger.setMockMethodCallHandler(
        const MethodChannel('xyz.luan/audioplayers'), (call) async {
      if (call.method == 'create') {
        final playerId = (call.arguments as Map)['playerId'];
        messenger.setMockMethodCallHandler(
            MethodChannel('xyz.luan/audioplayers/events/$playerId'),
            (_) async => null);
      }
      return null;
    });
  });

  for (final locale in S.delegate.supportedLocales) {
    for (final scenario in [
      (size: const Size(320, 568), scale: 3.2),
      (size: const Size(568, 320), scale: 2.0),
      (size: const Size(1024, 768), scale: 1.0),
    ]) {
      testWidgets(
          'core screens fit ${locale.toLanguageTag()} ${scenario.size} at ${scenario.scale}x',
          (tester) async {
        tester.view.physicalSize = scenario.size;
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);
        final screens = <String, Widget>{
          'Home': const StartScreen(),
          'Settings': const SettingsScreen(),
          'Stats': const StatsScreen(),
          'Purchase': PurchaseScreen(purchaseService: _FakePurchaseService()),
          'Rules': const HowToPlayScreen(),
          'Tutorial': const TutorialScreen(),
        };
        for (final entry in screens.entries) {
          await tester.pumpWidget(
              _app(entry.value, locale: locale, scale: scenario.scale));
          await tester.pumpAndSettle();
          expect(tester.takeException(), isNull,
              reason:
                  '${entry.key}, $locale, ${scenario.size}, ${scenario.scale}x');
          final scrollable = find.byType(Scrollable).first;
          await tester.scrollUntilVisible(
            find.byWidgetPredicate((widget) =>
                widget is Text && widget.data == _lastLabel(entry.key)),
            250,
            scrollable: scrollable,
            maxScrolls: 100,
          );
          await tester.pumpAndSettle();
          expect(tester.takeException(), isNull,
              reason:
                  'Scrolled ${entry.key}, $locale, ${scenario.size}, ${scenario.scale}x');
          await tester.pumpWidget(const SizedBox.shrink());
          await tester.pumpAndSettle();
        }
      });
    }
  }

  testWidgets(
      'setup remains scrollable with large Russian text on a small phone',
      (tester) async {
    tester.view.physicalSize = const Size(320, 568);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(
        _app(const StartScreen(), locale: const Locale('ru'), scale: 3.2));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text(S.current.Play));
    await tester.tap(find.text(S.current.Play));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    await tester.ensureVisible(find.text(S.current.PlayAgainstFriend));
    await tester.tap(find.text(S.current.PlayAgainstFriend));
    await tester.pumpAndSettle();
    expect(find.text(S.current.Difficulty), findsNothing);
    await tester.ensureVisible(find.text(S.current.StartGame));
    expect(tester.takeException(), isNull);
  });

  testWidgets(
      'failed active-game clearing preserves Continue and enables retry',
      (tester) async {
    final store = _FailingClearStore();
    SharedPreferencesStorePlatform.instance = store;
    SharedPreferences.resetStatic();
    const settings =
        GameSettings(difficulty: Difficulty.easy, twoPlayerMode: true);
    await tester.runAsync(() => GameSessionService.save(
        GameSession(settings: settings, timeline: [GameModel.initial()])));
    await tester.pumpWidget(_app(const StartScreen()));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text(S.current.NewGame));
    await tester.tap(find.text(S.current.NewGame));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text(S.current.StartGame));
    await tester.tap(find.text(S.current.StartGame));
    await tester.pumpAndSettle();
    store.failClear = true;
    await tester.tap(find.text(S.current.StartNewGame));
    await tester.pumpAndSettle();
    expect(find.byType(StartScreen), findsOneWidget);
    expect(find.byType(GameScreen), findsNothing);
    expect(find.text(S.current.GameSaveFailed), findsOneWidget);
    final continueButton = tester.widget<ElevatedButton>(find
        .ancestor(
            of: find.text(S.current.ContinueGame),
            matching:
                find.byWidgetPredicate((widget) => widget is ElevatedButton))
        .first);
    expect(continueButton.onPressed, isNotNull);
    await tester.ensureVisible(find.text(S.current.ContinueGame));
    await tester.tap(find.text(S.current.ContinueGame));
    await tester.pumpAndSettle();
    expect(find.byType(GameScreen), findsOneWidget);
    expect(tester.widget<GameScreen>(find.byType(GameScreen)).savedSession,
        isNotNull);
    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets(
      'an unexpected purchase exception resets busy state and permits retry',
      (tester) async {
    final service = _FakePurchaseService()..failNext = true;
    await tester.pumpWidget(_app(PurchaseScreen(purchaseService: service)));
    await tester.pumpAndSettle();
    final purchase =
        find.byWidgetPredicate((widget) => widget is ElevatedButton);
    await tester.scrollUntilVisible(purchase, 250,
        scrollable: find.byType(Scrollable).first);
    await tester.tap(purchase);
    await tester.pumpAndSettle();
    expect(find.text(S.current.PurchaseFailed), findsOneWidget);
    expect(tester.widget<ElevatedButton>(purchase).onPressed, isNotNull);
    await tester.tap(purchase);
    await tester.pumpAndSettle();
    expect(service.buyCalls, 2);
    expect(find.text(S.current.PurchaseSuccess), findsOneWidget);
  });

  testWidgets(
      'pointer activation updates the board keyboard and spoken selection',
      (tester) async {
    final model = GameModel.initial();
    final moves = model.board.getMovesForPlayer(model.player);
    final target = moves.last;
    final semantics = tester.ensureSemantics();
    await tester.pumpWidget(_app(Scaffold(
        body: AccessibleBoard(
      board: model.board,
      label: 'Practice board',
      legalMoves: moves,
      onMove: (_, __) {},
    ))));
    await tester.pumpAndSettle();
    final focus = tester.widget<Focus>(find.byWidgetPredicate((widget) =>
        widget is Focus &&
        widget.focusNode?.debugLabel == 'Practice and review board'));
    focus.focusNode!.requestFocus();
    await tester.pumpAndSettle();
    // No parent rebuild or focus change follows the tap. The board itself
    // must publish the newly selected square.
    await tester
        .tap(find.byKey(ValueKey('accessible-cell-${target.x}-${target.y}')));
    await tester.pumpAndSettle();
    final selected = find.byWidgetPredicate(
        (widget) => widget is Semantics && widget.properties.selected == true);
    expect(selected, findsOneWidget);
    expect(tester.widget<Semantics>(selected).properties.label,
        contains('${String.fromCharCode(65 + target.x)}${target.y + 1}'));
    await tester.pumpWidget(const SizedBox());
    await tester.pumpAndSettle();
    semantics.dispose();
  });

  testWidgets(
      'dark screen system chrome keeps status and navigation icons light',
      (tester) async {
    await tester.pumpWidget(_app(const HowToPlayScreen()));
    await tester.pumpAndSettle();
    final overlay = tester.widget<AnnotatedRegion<SystemUiOverlayStyle>>(
        find.byType(AnnotatedRegion<SystemUiOverlayStyle>).last);
    expect(overlay.value.statusBarIconBrightness, Brightness.light);
    expect(overlay.value.systemNavigationBarIconBrightness, Brightness.light);
  });
}

String _lastLabel(String screen) => switch (screen) {
      'Home' => S.current.Rules,
      'Settings' => S.current.PrivacyPolicySubtitle,
      'Stats' => S.current.AchGames50,
      'Purchase' => S.current.RestorePurchaseHelp,
      'Rules' => S.current.HowToControlsBody,
      'Tutorial' => S.current.TutorialSkip,
      _ => throw ArgumentError(screen),
    };

Widget _app(Widget home,
        {Locale locale = const Locale('en'), double scale = 1}) =>
    MaterialApp(
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: S.delegate.supportedLocales,
      locale: locale,
      theme: ThemeData(useMaterial3: true),
      builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(
              textScaler: TextScaler.linear(scale), disableAnimations: true),
          child: child!),
      home: home,
    );

class _FakePurchaseService extends PurchaseServiceBase {
  bool failNext = false;
  int buyCalls = 0;
  @override
  bool get isAdsRemoved => false;
  @override
  bool get isAvailable => true;
  @override
  bool get isPurchaseInProgress => false;
  @override
  bool get isSupportedPlatform => true;
  @override
  ProductDetails? get removeAdsProduct => null;
  @override
  String? get localizedPrice => r'$4.99';
  @override
  Future<void> init() async {}
  @override
  Future<void> disposeService() async {}
  @override
  Future<void> loadProducts() async {}
  @override
  Future<PurchaseFeedback> buyRemoveAds() async {
    buyCalls++;
    if (failNext) {
      failNext = false;
      throw StateError('Store request failed');
    }
    return PurchaseFeedback.success;
  }

  @override
  Future<PurchaseFeedback> restorePurchases({bool silent = false}) async =>
      PurchaseFeedback.restoreNothing;
}

class _FailingClearStore extends InMemorySharedPreferencesStore {
  _FailingClearStore() : super.empty();
  bool failClear = false;
  @override
  Future<bool> remove(String key) =>
      failClear && key == 'flutter.activeGameSession'
          ? Future.value(false)
          : super.remove(key);
}

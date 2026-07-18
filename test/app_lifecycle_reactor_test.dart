import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:classic_reversi/Tools/ads_manager.dart';
import 'package:classic_reversi/Tools/ads_ids_debug.dart';

class _FakeAppOpenAdManager extends AppOpenAdManager {
  int showCalls = 0;
  int cancelCalls = 0;

  @override
  void showAdIfAvailable() {
    showCalls++;
  }

  @override
  void cancelPendingShow() {
    cancelCalls++;
  }
}

class _NoLoadAppOpenAdManager extends AppOpenAdManager {
  int loadCalls = 0;

  @override
  void loadAd() {
    loadCalls++;
  }
}

void main() {
  test('debug app-open IDs use Google App Open test units', () {
    expect(
      AdsIdsDebug.openAdUnitIdAndroid,
      'ca-app-pub-3940256099942544/9257395921',
    );
    expect(
      AdsIdsDebug.openAdUnitIdIOS,
      'ca-app-pub-3940256099942544/5575463023',
    );
  });

  test('app-open ad only runs after a real background transition', () {
    final manager = _FakeAppOpenAdManager();
    final reactor = AppLifecycleReactor(appOpenAdManager: manager);

    reactor.didChangeAppLifecycleState(AppLifecycleState.inactive);
    reactor.didChangeAppLifecycleState(AppLifecycleState.resumed);
    expect(manager.showCalls, 0);

    reactor.didChangeAppLifecycleState(AppLifecycleState.paused);
    expect(manager.cancelCalls, 1);
    reactor.didChangeAppLifecycleState(AppLifecycleState.resumed);
    expect(manager.showCalls, 1);

    reactor.didChangeAppLifecycleState(AppLifecycleState.resumed);
    expect(manager.showCalls, 1);

    reactor.didChangeAppLifecycleState(AppLifecycleState.hidden);
    expect(manager.cancelCalls, 2);
    reactor.didChangeAppLifecycleState(AppLifecycleState.resumed);
    expect(manager.showCalls, 2);
  });

  test('show request waits for an app-open ad that is still loading', () {
    final manager = _NoLoadAppOpenAdManager();

    manager.showAdIfAvailable();

    expect(manager.hasPendingShow, isTrue);
    expect(manager.loadCalls, 1);

    manager.cancelPendingShow();
    expect(manager.hasPendingShow, isFalse);
  });
}

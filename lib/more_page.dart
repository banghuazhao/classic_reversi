import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'Tools/store_launcher.dart';
import 'app_chrome.dart';
import 'generated/l10n.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  MoreAppItem _app({
    required String asset,
    required String title,
    required String appStoreId,
    String? androidAppBundleId,
  }) {
    return MoreAppItem(
      assetPath: asset,
      title: title,
      onTap: () => launchStore(
        appStoreId: appStoreId,
        androidAppBundleId: androidAppBundleId ?? '',
      ),
    );
  }

  List<MoreAppItem> _items(BuildContext context) {
    if (kIsWeb) return const [];

    final s = S.of(context);
    final fallingBlockPuzzle = _app(
      asset: 'assets/app_icons/falling_block_puzzle.png',
      title: s.falling_block_puzzle,
      appStoreId: '1609440799',
    );
    final classicMemoryGame = _app(
      asset: 'assets/app_icons/classic_memory_game.png',
      title: s.Classic_Memory_Game,
      appStoreId: '1617593078',
    );
    final imageGuru = _app(
      asset: 'assets/app_icons/image_guru.png',
      title: s.Image_Guru,
      appStoreId: '1625021625',
    );
    final solitaireGuru = _app(
      asset: 'assets/app_icons/solitaire_guru.png',
      title: s.Solitaire_Guru,
      appStoreId: '1636116344',
      androidAppBundleId: 'com.appsbay.solitaire_guru',
    );
    final yesHabit = _app(
      asset: 'assets/app_icons/yes_habit.png',
      title: s.Yes_Habit,
      appStoreId: '1637643734',
    );
    final worldWeatherLive = _app(
      asset: 'assets/app_icons/world_weather_live.png',
      title: s.World_Weather_Live,
      appStoreId: '1612773646',
      androidAppBundleId: 'com.appsbay.world_weather_live',
    );
    final savingAmbulance = _app(
      asset: 'assets/app_icons/saving_ambulance.png',
      title: s.Saving_Ambulance,
      appStoreId: '1639693525',
      androidAppBundleId: 'com.appsbay.saving_ambulance',
    );
    final moneyTracker = _app(
      asset: 'assets/app_icons/money_tracker.png',
      title: s.Money_Tracker,
      appStoreId: '1534244892',
    );
    final sudokuLover = _app(
      asset: 'assets/app_icons/sudoku_lover.png',
      title: s.Sudoku_Lover,
      appStoreId: '1620749798',
      androidAppBundleId: 'com.appsbay.sudoku_lovers',
    );
    final flingKnife = _app(
      asset: 'assets/app_icons/fling_knife.png',
      title: s.Fling_Knife,
      appStoreId: '1636426217',
      androidAppBundleId: 'com.appsbay.fling_knife',
    );
    final novelsHub = _app(
      asset: 'assets/app_icons/novels_hub.png',
      title: s.Novels_Hub,
      appStoreId: '1528820845',
      androidAppBundleId: 'com.appsbay.novelshub',
    );
    final relaxingUp = _app(
      asset: 'assets/app_icons/relaxing_up.png',
      title: s.Relaxing_Up,
      appStoreId: '1618712178',
      androidAppBundleId: 'com.appsbay.relaxing_up',
    );
    final wePlayPiano = _app(
      asset: 'assets/app_icons/we_play_piano.png',
      title: s.We_Play_Piano,
      appStoreId: '1625018611',
      androidAppBundleId: 'com.appsbay.we_play_piano',
    );
    final simpleCalculator = _app(
      asset: 'assets/app_icons/simple_calculator.png',
      title: s.Simple_Calculator,
      appStoreId: '1610829871',
      androidAppBundleId: 'com.appsbay.simple_calculator',
    );
    final classic15Puzzle = _app(
      asset: 'assets/app_icons/classic_15_puzzle.png',
      title: s.Classic_15_Puzzle,
      appStoreId: '1611891108',
    );
    final gardenCatchBugs = _app(
      asset: 'assets/app_icons/garden_catch_bugs.png',
      title: s.Garden_Catch_Bugs,
      appStoreId: '1514979792',
    );
    final spaceJumper = _app(
      asset: 'assets/app_icons/space_jumper.png',
      title: s.Space_Jumper,
      appStoreId: '1516635884',
    );
    final crazyPyramid = _app(
      asset: 'assets/app_icons/crazy_pyramid.png',
      title: s.Crazy_Pyramid,
      appStoreId: '1495037584',
    );

    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return [
        fallingBlockPuzzle,
        classicMemoryGame,
        imageGuru,
        solitaireGuru,
        yesHabit,
        worldWeatherLive,
        savingAmbulance,
        moneyTracker,
        sudokuLover,
        flingKnife,
        novelsHub,
        relaxingUp,
        wePlayPiano,
        simpleCalculator,
        classic15Puzzle,
        gardenCatchBugs,
        spaceJumper,
        crazyPyramid,
      ];
    }

    return [
      classicMemoryGame,
      classic15Puzzle,
      solitaireGuru,
      worldWeatherLive,
      savingAmbulance,
      sudokuLover,
      flingKnife,
      relaxingUp,
      wePlayPiano,
      simpleCalculator,
    ];
  }

  @override
  Widget build(BuildContext context) {
    final items = _items(context);
    return AppGradientScaffold(
      title: S.of(context).MoreApps,
      maxContentWidth: 760,
      child: items.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  S.of(context).MoreAppsUnavailable,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 16,
                    color: AppChrome.primaryText,
                  ),
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
              itemCount: items.length,
              itemBuilder: (context, index) => MoreAppsRow(item: items[index]),
            ),
    );
  }
}

class MoreAppItem {
  const MoreAppItem({
    required this.assetPath,
    required this.title,
    required this.onTap,
  });

  final String assetPath;
  final String title;
  final VoidCallback onTap;
}

class MoreAppsRow extends StatelessWidget {
  const MoreAppsRow({super.key, required this.item});

  final MoreAppItem item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: AppChrome.cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: const BorderSide(color: AppChrome.borderColor),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: item.onTap,
          child: ListTile(
            minVerticalPadding: 12,
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                item.assetPath,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
            trailing: const Icon(
              Icons.chevron_right_rounded,
              color: AppChrome.primaryText,
            ),
            title: Text(
              item.title,
              style: const TextStyle(
                fontFamily: 'Roboto',
                fontSize: 15,
                fontWeight: FontWeight.w800,
                color: AppChrome.primaryText,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'Tools/purchase_service.dart';
import 'Tools/store_launcher.dart';
import 'generated/l10n.dart';

class MorePage extends StatefulWidget {
  const MorePage({Key? key}) : super(key: key);

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    PurchaseService.instance.addListener(_onPurchaseChanged);
    if (PurchaseService.instance.isSupportedPlatform) {
      PurchaseService.instance.loadProducts();
    }
  }

  @override
  void dispose() {
    PurchaseService.instance.removeListener(_onPurchaseChanged);
    super.dispose();
  }

  void _onPurchaseChanged() {
    if (mounted) {
      setState(() {});
    }
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

  String _messageFor(PurchaseFeedback feedback) {
    final s = S.of(context);
    switch (feedback) {
      case PurchaseFeedback.success:
        return s.PurchaseSuccess;
      case PurchaseFeedback.restoreSuccess:
        return s.RestoreSuccess;
      case PurchaseFeedback.restoreNothing:
        return s.RestoreNothing;
      case PurchaseFeedback.cancelled:
        return s.PurchaseCancelled;
      case PurchaseFeedback.pending:
        return s.PurchasePending;
      case PurchaseFeedback.failed:
        return s.PurchaseFailed;
      case PurchaseFeedback.unavailable:
        return s.PurchaseUnavailable;
      case PurchaseFeedback.alreadyOwned:
        return s.PurchaseAlreadyOwned;
    }
  }

  Future<void> _buyRemoveAds() async {
    if (_busy) {
      return;
    }
    setState(() => _busy = true);
    final feedback = await PurchaseService.instance.buyRemoveAds();
    if (!mounted) {
      return;
    }
    setState(() => _busy = false);
    _showMessage(_messageFor(feedback));
  }

  Future<void> _restorePurchases() async {
    if (_busy) {
      return;
    }
    setState(() => _busy = true);
    final feedback = await PurchaseService.instance.restorePurchases();
    if (!mounted) {
      return;
    }
    setState(() => _busy = false);
    _showMessage(_messageFor(feedback));
  }

  Widget _buildPurchaseSection(BuildContext context) {
    if (!PurchaseService.instance.isSupportedPlatform) {
      return const SizedBox.shrink();
    }

    final purchase = PurchaseService.instance;
    final s = S.of(context);
    final price = purchase.localizedPrice;
    final removeAdsTitle = purchase.isAdsRemoved
        ? s.AdsRemoved
        : (price != null ? '${s.RemoveAds} · $price' : s.RemoveAds);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          decoration: const BoxDecoration(
            color: Colors.white60,
            borderRadius: BorderRadius.all(Radius.circular(24)),
          ),
          child: Column(
            children: [
              MoreRow(
                leadingIcon: Icons.money_off,
                title: removeAdsTitle,
                onTap: purchase.isAdsRemoved || _busy
                    ? () {}
                    : () {
                        if (!purchase.isAvailable ||
                            purchase.removeAdsProduct == null) {
                          _showMessage(s.PurchaseUnavailable);
                          return;
                        }
                        _buyRemoveAds();
                      },
              ),
              const Divider(height: 1, indent: 16, endIndent: 16),
              MoreRow(
                leadingIcon: Icons.restore,
                title: s.RestorePurchases,
                onTap: _busy ? () {} : _restorePurchases,
              ),
            ],
          ),
        ),
        if (_busy || purchase.isPurchaseInProgress)
          const Padding(
            padding: EdgeInsets.only(top: 12),
            child: Center(
              child: SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    List<MoreAppItem> _items = [];

    if (!kIsWeb) {
      var falling_block_puzzle = MoreAppItem(
          Image.asset("assets/app_icons/falling_block_puzzle.png"),
          S.of(context).falling_block_puzzle, () {
        launchStore(appStoreId: "1609440799");
      });

      var Classic_Memory_Game = MoreAppItem(
          Image.asset("assets/app_icons/classic_memory_game.png"),
          S.of(context).Classic_Memory_Game, () {
        launchStore(appStoreId: "1617593078");
      });

      var Image_Guru = MoreAppItem(
          Image.asset("assets/app_icons/image_guru.png"),
          S.of(context).Image_Guru, () {
        launchStore(appStoreId: "1625021625");
      });

      var Solitaire_Guru = MoreAppItem(
          Image.asset("assets/app_icons/solitaire_guru.png"),
          S.of(context).Solitaire_Guru, () {
        launchStore(
          appStoreId: "1636116344",
          androidAppBundleId: "com.appsbay.solitaire_guru",
        );
      });

      var Yes_Habit = MoreAppItem(Image.asset("assets/app_icons/yes_habit.png"),
          S.of(context).Yes_Habit, () {
        launchStore(appStoreId: "1637643734");
      });

      var Instant_Face = MoreAppItem(
          Image.asset("assets/app_icons/instant_face.png"),
          S.of(context).Instant_Face, () {
        launchStore(
          appStoreId: "1638563222",
          androidAppBundleId: "com.appsbay.instant_face",
        );
      });

      var World_Weather_Live = MoreAppItem(
          Image.asset("assets/app_icons/world_weather_live.png"),
          S.of(context).World_Weather_Live, () {
        launchStore(
          appStoreId: "1612773646",
          androidAppBundleId: "com.appsbay.world_weather_live",
        );
      });

      var Saving_Ambulance = MoreAppItem(
          Image.asset("assets/app_icons/saving_ambulance.png"),
          S.of(context).Saving_Ambulance, () {
        launchStore(
          appStoreId: "1639693525",
          androidAppBundleId: "com.appsbay.saving_ambulance",
        );
      });

      var Money_Tracker = MoreAppItem(
          Image.asset("assets/app_icons/money_tracker.png"),
          S.of(context).Money_Tracker, () {
        launchStore(appStoreId: "1534244892");
      });

      var Sudoku_Lover = MoreAppItem(
          Image.asset("assets/app_icons/sudoku_lover.png"),
          S.of(context).Sudoku_Lover, () {
        launchStore(
          appStoreId: "1620749798",
          androidAppBundleId: "com.appsbay.sudoku_lovers",
        );
      });

      var Fling_Knife = MoreAppItem(
          Image.asset("assets/app_icons/fling_knife.png"),
          S.of(context).Fling_Knife, () {
        launchStore(
          appStoreId: "1636426217",
          androidAppBundleId: "com.appsbay.fling_knife",
        );
      });

      var Mint_Translate = MoreAppItem(
          Image.asset("assets/app_icons/mint_translate.png"),
          S.of(context).Mint_Translate, () {
        launchStore(
          appStoreId: "1638456603",
          androidAppBundleId: "com.appsbay.mint_translate",
        );
      });

      var Novels_Hub = MoreAppItem(
          Image.asset("assets/app_icons/novels_hub.png"),
          S.of(context).Novels_Hub, () {
        launchStore(
          appStoreId: "1528820845",
          androidAppBundleId: "com.appsbay.novelshub",
        );
      });

      var Relaxing_Up = MoreAppItem(
          Image.asset("assets/app_icons/relaxing_up.png"),
          S.of(context).Relaxing_Up, () {
        launchStore(
          appStoreId: "1618712178",
          androidAppBundleId: "com.appsbay.relaxing_up",
        );
      });

      var We_Play_Piano = MoreAppItem(
          Image.asset("assets/app_icons/we_play_piano.png"),
          S.of(context).We_Play_Piano, () {
        launchStore(
          appStoreId: "1625018611",
          androidAppBundleId: "com.appsbay.we_play_piano",
        );
      });

      var Simple_Calculator = MoreAppItem(
          Image.asset("assets/app_icons/simple_calculator.png"),
          S.of(context).Simple_Calculator, () {
        launchStore(
          appStoreId: "1610829871",
          androidAppBundleId: "com.appsbay.simple_calculator",
        );
      });

      var Classic_15_Puzzle = MoreAppItem(
          Image.asset("assets/app_icons/classic_15_puzzle.png"),
          S.of(context).Classic_15_Puzzle, () {
        launchStore(appStoreId: "1611891108");
      });

      var Garden_Catch_Bugs = MoreAppItem(
          Image.asset("assets/app_icons/garden_catch_bugs.png"),
          S.of(context).Garden_Catch_Bugs, () {
        launchStore(appStoreId: "1514979792");
      });

      var Space_Jumper = MoreAppItem(
          Image.asset("assets/app_icons/space_jumper.png"),
          S.of(context).Space_Jumper, () {
        launchStore(appStoreId: "1516635884");
      });

      var Crazy_Pyramid = MoreAppItem(
          Image.asset("assets/app_icons/crazy_pyramid.png"),
          S.of(context).Crazy_Pyramid, () {
        launchStore(appStoreId: "1495037584");
      });

      if (defaultTargetPlatform == TargetPlatform.iOS) {
        _items = [
          falling_block_puzzle,
          Classic_Memory_Game,
          Image_Guru,
          Solitaire_Guru,
          Yes_Habit,
          Instant_Face,
          World_Weather_Live,
          Saving_Ambulance,
          Money_Tracker,
          Sudoku_Lover,
          Fling_Knife,
          Mint_Translate,
          Novels_Hub,
          Relaxing_Up,
          We_Play_Piano,
          Simple_Calculator,
          Classic_15_Puzzle,
          Garden_Catch_Bugs,
          Space_Jumper,
          Crazy_Pyramid
        ];
      } else {
        _items = [
          Classic_Memory_Game,
          Classic_15_Puzzle,
          Solitaire_Guru,
          Instant_Face,
          World_Weather_Live,
          Saving_Ambulance,
          Sudoku_Lover,
          Fling_Knife,
          Mint_Translate,
          Relaxing_Up,
          We_Play_Piano,
          Simple_Calculator
        ];
      }
    }
    return Scaffold(
        appBar: AppBar(
          title: Text(
            S.of(context).More,
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          // elevation: 0,
          backgroundColor: Color(0xb07F451B),
        ),
        backgroundColor: Color(0xb0DFC9B4).withOpacity(0.8),
        body: ListView(
          children: [
            _buildPurchaseSection(context),
            Container(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Text(
                  S.of(context).How_to_play,
                  style: !kIsWeb
                      ? TextStyle(fontSize: 24)
                      : TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                )),
            Container(
                padding: EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: Text(
                  S.of(context).How_to_play_explain,
                  style: !kIsWeb
                      ? TextStyle(fontSize: 16)
                      : TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                )),
            if (!kIsWeb)
              Container(
                  padding: EdgeInsets.fromLTRB(20, 24, 20, 0),
                  child: Text(
                    S.of(context).MoreApps,
                    style: TextStyle(fontSize: 24),
                  )),
            if (!kIsWeb)
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  return MoreAppsRow.factory(_items[index]);
                },
              ),
            SizedBox(
              height: 50,
            )
          ],
        ));
  }
}

class MoreAppItem {
  Image appIcon;
  String title;
  void Function() onTap;

  MoreAppItem(this.appIcon, this.title, this.onTap);
}

class MoreAppsRow extends StatelessWidget {
  late Image appIcon;
  late IconData trailingIcon;
  late String title;
  late void Function() onTap;

  MoreAppsRow(
      {Key? key,
      this.trailingIcon = Icons.chevron_right_rounded,
      required this.appIcon,
      required this.title,
      required this.onTap})
      : super(key: key);

  MoreAppsRow.factory(MoreAppItem moreAppItem) {
    appIcon = moreAppItem.appIcon;
    trailingIcon = Icons.chevron_right_rounded;
    title = moreAppItem.title;
    onTap = moreAppItem.onTap;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 16, 20, 0),
      decoration: const BoxDecoration(
        color: Colors.white60,
        borderRadius: BorderRadius.all(Radius.circular(24)),
      ),
      child: InkWell(
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onTap: onTap,
        child: ListTile(
          visualDensity: VisualDensity(vertical: 4), // to compact
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              height: 50,
              width: 50,
              child: appIcon,
            ),
          ),
          trailing: Icon(trailingIcon),
          title: Text(
            title,
          ),
        ),
      ),
    );
  }
}

class MoreRow extends StatelessWidget {
  IconData leadingIcon;
  IconData trailingIcon;
  String title;
  void Function() onTap;

  MoreRow(
      {Key? key,
      this.trailingIcon = Icons.chevron_right_rounded,
      required this.leadingIcon,
      required this.title,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        leading: Icon(leadingIcon),
        trailing: Icon(trailingIcon),
        title: Text(
          title,
        ),
      ),
    );
  }
}

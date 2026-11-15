import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Tools/ads_manager.dart';
import 'Tools/purchase_service.dart';
import 'app_chrome.dart';
import 'generated/l10n.dart';
import 'theme_controller.dart';

/// Explains and sells the one-time Premium unlock, or confirms it is active.
class PremiumScreen extends StatefulWidget {
  const PremiumScreen({super.key, this.purchaseService});

  final PurchaseServiceBase? purchaseService;

  @override
  State<PremiumScreen> createState() => _PremiumScreenState();
}

class _PremiumScreenState extends State<PremiumScreen> {
  bool _busy = false;
  PurchaseServiceBase get _purchase =>
      widget.purchaseService ?? PurchaseService.instance;

  @override
  void initState() {
    super.initState();
    _purchase.addListener(_onPurchaseChanged);
    ThemeController.instance.addListener(_onPurchaseChanged);
    _purchase.loadProducts();
  }

  @override
  void dispose() {
    _purchase.removeListener(_onPurchaseChanged);
    ThemeController.instance.removeListener(_onPurchaseChanged);
    super.dispose();
  }

  void _onPurchaseChanged() {
    if (mounted) setState(() {});
  }

  String _messageFor(PurchaseFeedback feedback) {
    final s = S.of(context);
    return switch (feedback) {
      PurchaseFeedback.success => s.PurchaseSuccess,
      PurchaseFeedback.restoreSuccess => s.RestoreSuccess,
      PurchaseFeedback.restoreNothing => s.RestoreNothing,
      PurchaseFeedback.cancelled => s.PurchaseCancelled,
      PurchaseFeedback.pending => s.PurchasePending,
      PurchaseFeedback.failed => s.PurchaseFailed,
      PurchaseFeedback.unavailable => s.PurchaseUnavailable,
      PurchaseFeedback.alreadyOwned => s.PurchaseAlreadyOwned,
    };
  }

  void _showMessage(String message) {
    final messenger = ScaffoldMessenger.of(context);
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _run(Future<PurchaseFeedback> Function() action) async {
    if (_busy) return;
    setState(() => _busy = true);
    var feedback = PurchaseFeedback.failed;
    try {
      feedback = await action();
    } catch (error) {
      debugPrint('Purchase action failed: $error');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
    if (mounted) _showMessage(_messageFor(feedback));
  }

  static IconData _iconFor(PremiumFeature feature) => switch (feature) {
        PremiumFeature.adFree => CupertinoIcons.nosign,
        PremiumFeature.unlimitedUndo => CupertinoIcons.arrow_uturn_left,
        PremiumFeature.unlimitedTips => CupertinoIcons.wand_stars,
        PremiumFeature.hints => CupertinoIcons.lightbulb,
        PremiumFeature.expertAi => CupertinoIcons.flame,
        PremiumFeature.gameAnalysis => CupertinoIcons.chart_pie,
        PremiumFeature.themes => CupertinoIcons.paintbrush,
      };

  static (String, String) _copyFor(S s, PremiumFeature feature) =>
      switch (feature) {
        PremiumFeature.adFree => (s.PremiumAdFreeTitle, s.PremiumAdFreeBody),
        PremiumFeature.unlimitedUndo => (s.PremiumUndoTitle, s.PremiumUndoBody),
        PremiumFeature.unlimitedTips => (
            s.PremiumTipsTitle,
            s.PremiumTipsBody(kFreeDailyCoachTips)
          ),
        PremiumFeature.hints => (
            s.PremiumHintsTitle,
            AdsManager.platformSupportsAds
                ? s.PremiumHintsBody
                : s.PremiumHintsBodyNoAds
          ),
        PremiumFeature.expertAi => (s.PremiumExpertTitle, s.PremiumExpertBody),
        PremiumFeature.gameAnalysis => (
            s.PremiumAnalysisTitle,
            s.PremiumAnalysisBody
          ),
        PremiumFeature.themes => (s.PremiumThemesTitle, s.PremiumThemesBody),
      };

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final purchase = _purchase;
    final palette = ThemeController.instance.theme;
    final supported = purchase.isSupportedPlatform;
    final owned = purchase.isPremium;
    final price = purchase.localizedPrice;
    final buyLabel = owned
        ? s.PremiumActive
        : price == null
            ? s.GetPremium
            : s.GetPremiumWithPrice(price);
    final working = _busy || purchase.isPurchaseInProgress;
    // The Mac build never shows ads, so "ad-free" is not a Premium benefit there.
    final features = [
      for (final feature in PremiumFeature.values)
        if (feature != PremiumFeature.adFree || AdsManager.platformSupportsAds)
          feature,
    ];

    return AppGradientScaffold(
      title: s.Premium,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
        children: [
          AppInfoCard(
            child: Column(
              children: [
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        palette.lastMoveBorder,
                        Color.lerp(palette.lastMoveBorder, Colors.black, 0.25)!,
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: palette.lastMoveBorder.withAlpha(90),
                        blurRadius: 18,
                      ),
                    ],
                  ),
                  child: Icon(
                    owned
                        ? Icons.verified_rounded
                        : Icons.workspace_premium_rounded,
                    color: const Color(0xFF111111),
                    size: 38,
                  ),
                ),
                const SizedBox(height: 16),
                Semantics(
                  header: true,
                  child: Text(
                    owned ? s.PremiumWelcomeTitle : s.PremiumHeadline,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: AppChrome.primaryText,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  owned
                      ? s.PremiumWelcomeBody
                      : AdsManager.platformSupportsAds
                          ? s.PremiumSubheadline
                          : s.PremiumSubheadlineNoAds,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 15,
                    height: 1.5,
                    color: AppChrome.secondaryText,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          AppSectionTitle(s.PremiumIncludes),
          AppInfoCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (final feature in features) ...[
                  if (feature != features.first) const SizedBox(height: 18),
                  _Benefit(
                    icon: _iconFor(feature),
                    title: _copyFor(s, feature).$1,
                    body: _copyFor(s, feature).$2,
                    unlocked: owned,
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 18),
          if (!supported)
            AppInfoCard(
              child: Text(
                s.PurchaseUnavailable,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 15,
                  color: AppChrome.primaryText,
                ),
              ),
            )
          else ...[
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                key: const ValueKey('premium-buy'),
                onPressed:
                    working || owned ? null : () => _run(purchase.buyPremium),
                style: appPrimaryButtonStyle(palette),
                icon: working && !owned
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Icon(
                        owned
                            ? CupertinoIcons.check_mark_circled_solid
                            : Icons.workspace_premium_rounded,
                      ),
                label: Text(buyLabel, textAlign: TextAlign.center),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              s.PremiumOneTime(purchase.storeName),
              textAlign: TextAlign.center,
              style: AppChrome.bodyStyle.copyWith(fontSize: 13),
            ),
            const SizedBox(height: 12),
            AppMenuRow(
              icon: CupertinoIcons.refresh,
              title: s.RestorePurchases,
              subtitle: s.RestorePurchaseHelp(purchase.storeName),
              onTap: working ? null : () => _run(purchase.restorePurchases),
              trailing: working
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppChrome.primaryText,
                      ),
                    )
                  : null,
            ),
          ],
        ],
      ),
    );
  }
}

class _Benefit extends StatelessWidget {
  const _Benefit({
    required this.icon,
    required this.title,
    required this.body,
    required this.unlocked,
  });

  final IconData icon;
  final String title;
  final String body;
  final bool unlocked;

  @override
  Widget build(BuildContext context) {
    final accent = ThemeController.instance.theme.lastMoveBorder;
    return MergeSemantics(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: accent.withAlpha(38),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 20, color: accent),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppChrome.bodyStyle.copyWith(
                    color: AppChrome.primaryText,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(body, style: AppChrome.bodyStyle.copyWith(fontSize: 14)),
              ],
            ),
          ),
          if (unlocked) ...[
            const SizedBox(width: 8),
            ExcludeSemantics(
              child:
                  Icon(CupertinoIcons.checkmark_alt, size: 18, color: accent),
            ),
          ],
        ],
      ),
    );
  }
}

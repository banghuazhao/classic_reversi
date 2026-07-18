import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Tools/purchase_service.dart';
import 'app_chrome.dart';
import 'generated/l10n.dart';
import 'theme_controller.dart';

class PurchaseScreen extends StatefulWidget {
  const PurchaseScreen({super.key});

  @override
  State<PurchaseScreen> createState() => _PurchaseScreenState();
}

class _PurchaseScreenState extends State<PurchaseScreen> {
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    PurchaseService.instance.addListener(_onPurchaseChanged);
    PurchaseService.instance.loadProducts();
  }

  @override
  void dispose() {
    PurchaseService.instance.removeListener(_onPurchaseChanged);
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
    final feedback = await action();
    if (!mounted) return;
    setState(() => _busy = false);
    _showMessage(_messageFor(feedback));
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final purchase = PurchaseService.instance;
    final palette = ThemeController.instance.theme;
    final supported = purchase.isSupportedPlatform;
    final price = purchase.localizedPrice;
    final title = purchase.isAdsRemoved
        ? s.AdsRemoved
        : price == null
            ? s.RemoveAds
            : '${s.RemoveAds} · $price';
    final working = _busy || purchase.isPurchaseInProgress;

    return AppGradientScaffold(
      title: s.RemoveAds,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
        children: [
          AppInfoCard(
            child: Column(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: palette.lastMoveBorder,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    purchase.isAdsRemoved
                        ? CupertinoIcons.checkmark_shield_fill
                        : CupertinoIcons.shield_fill,
                    color: const Color(0xFF111111),
                    size: 32,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: AppChrome.primaryText,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  s.PurchaseBenefits,
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
                onPressed: working || purchase.isAdsRemoved
                    ? null
                    : () => _run(purchase.buyRemoveAds),
                style: appPrimaryButtonStyle(palette),
                icon: Icon(
                  purchase.isAdsRemoved
                      ? CupertinoIcons.check_mark_circled_solid
                      : CupertinoIcons.cart_fill,
                ),
                label: Text(title),
              ),
            ),
            const SizedBox(height: 12),
            AppMenuRow(
              icon: CupertinoIcons.refresh,
              title: s.RestorePurchases,
              subtitle: s.RestorePurchaseHelp,
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

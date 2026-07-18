import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Tools/purchase_service.dart';
import 'app_theme.dart';
import 'generated/l10n.dart';
import 'settings_service.dart';
import 'theme_controller.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _sound = true;
  bool _haptics = true;
  BoardThemeId _theme = BoardThemeId.classic;
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final sound = await SettingsService.getSoundEnabled();
    final haptics = await SettingsService.getHapticsEnabled();
    final theme = await SettingsService.getBoardTheme();
    if (!mounted) return;
    setState(() {
      _sound = sound;
      _haptics = haptics;
      _theme = theme;
    });
  }

  AppTheme get _palette => ThemeController.instance.theme;

  Widget _toggle(bool value) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      width: 46,
      height: 28,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: value ? const Color(0xffffffff) : const Color(0x60ffffff),
        borderRadius: BorderRadius.circular(14),
      ),
      child: AnimatedAlign(
        duration: const Duration(milliseconds: 150),
        alignment: value ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            color: value ? _palette.backgroundFinish : const Color(0xffffffff),
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }

  Widget _row({
    required String label,
    required Widget trailing,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        decoration: BoxDecoration(
          color: const Color(0x40ffffff),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Color(0xffffffff),
                ),
              ),
            ),
            trailing,
          ],
        ),
      ),
    );
  }

  Future<void> _restore() async {
    if (_busy || !PurchaseService.instance.isSupportedPlatform) {
      return;
    }
    setState(() => _busy = true);
    final feedback = await PurchaseService.instance.restorePurchases();
    if (!mounted) return;
    setState(() => _busy = false);
    final s = S.of(context);
    final message = switch (feedback) {
      PurchaseFeedback.restoreSuccess => s.RestoreSuccess,
      PurchaseFeedback.restoreNothing => s.RestoreNothing,
      PurchaseFeedback.alreadyOwned => s.PurchaseAlreadyOwned,
      PurchaseFeedback.unavailable => s.PurchaseUnavailable,
      _ => s.PurchaseFailed,
    };
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final palette = _palette;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [palette.backgroundStart, palette.backgroundFinish],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(CupertinoIcons.back,
                          color: Color(0xffffffff)),
                    ),
                    Expanded(
                      child: Text(
                        s.Settings,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          color: Color(0xffffffff),
                        ),
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                  children: [
                    _row(
                      label: s.Sound,
                      trailing: _toggle(_sound),
                      onTap: () async {
                        final next = !_sound;
                        setState(() => _sound = next);
                        await SettingsService.setSoundEnabled(next);
                      },
                    ),
                    _row(
                      label: s.Haptics,
                      trailing: _toggle(_haptics),
                      onTap: () async {
                        final next = !_haptics;
                        setState(() => _haptics = next);
                        await SettingsService.setHapticsEnabled(next);
                      },
                    ),
                    const SizedBox(height: 8),
                    Text(
                      s.Theme,
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: palette.scoreWhite,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: BoardThemeId.values.map((id) {
                        final selected = id == _theme;
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: GestureDetector(
                              onTap: () async {
                                setState(() => _theme = id);
                                await ThemeController.instance.setTheme(id);
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: selected
                                      ? const Color(0xffffffff)
                                      : const Color(0x40ffffff),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  id.label(context),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13,
                                    color: selected
                                        ? const Color(0xff000000)
                                        : const Color(0xffffffff),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    if (PurchaseService.instance.isSupportedPlatform) ...[
                      const SizedBox(height: 28),
                      ElevatedButton(
                        onPressed: _busy ? null : _restore,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffffffff),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: Text(
                          s.RestorePurchases,
                          style: const TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: Color(0xff000000),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

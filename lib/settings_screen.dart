import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Tools/ads_manager.dart';
import 'app_chrome.dart';
import 'app_theme.dart';
import 'feedback_service.dart';
import 'generated/l10n.dart';
import 'how_to_play_screen.dart';
import 'main.dart';
import 'more_page.dart';
import 'purchase_screen.dart';
import 'settings_service.dart';
import 'theme_controller.dart';

const _privacyPolicyUri = 'https://appsbay.com/privacy';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _sound = true;
  bool _haptics = true;
  BoardThemeId _theme = BoardThemeId.classic;
  bool _privacyOptionsRequired = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final sound = await SettingsService.getSoundEnabled();
    final haptics = await SettingsService.getHapticsEnabled();
    final theme = await SettingsService.getBoardTheme();
    final privacyOptions = await AdsManager.isPrivacyOptionsRequired();
    if (!mounted) return;
    setState(() {
      _sound = sound;
      _haptics = haptics;
      _theme = theme;
      _privacyOptionsRequired = privacyOptions;
    });
  }

  Future<void> _openPrivacyPolicy() async {
    final uri = Uri.parse(_privacyPolicyUri);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  Future<void> _setSound(bool value) async {
    setState(() => _sound = value);
    await FeedbackService.instance.setSoundEnabled(value);
  }

  Future<void> _setHaptics(bool value) async {
    setState(() => _haptics = value);
    await FeedbackService.instance.setHapticsEnabled(value);
  }

  void _open(WidgetBuilder builder) {
    Navigator.of(context).push(fadeRoute(builder));
  }

  Widget _switchRow({
    required IconData icon,
    required String label,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return AppMenuRow(
      icon: icon,
      title: label,
      onTap: () => onChanged(!value),
      trailing: Switch.adaptive(
        value: value,
        activeTrackColor: ThemeController.instance.theme.lastMoveBorder,
        activeThumbColor: const Color(0xFF111111),
        inactiveTrackColor: const Color(0x55FFFFFF),
        inactiveThumbColor: const Color(0xFFFFFFFF),
        onChanged: onChanged,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return ListenableBuilder(
      listenable: ThemeController.instance,
      builder: (context, _) {
        return AppGradientScaffold(
          title: s.Settings,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
            children: [
              AppSectionTitle(s.Settings),
              _switchRow(
                icon: CupertinoIcons.speaker_2_fill,
                label: s.Sound,
                value: _sound,
                onChanged: _setSound,
              ),
              _switchRow(
                icon: CupertinoIcons.hand_raised_fill,
                label: s.Haptics,
                value: _haptics,
                onChanged: _setHaptics,
              ),
              const SizedBox(height: 8),
              AppSectionTitle(s.Theme),
              LayoutBuilder(
                builder: (context, constraints) {
                  return Row(
                    children: BoardThemeId.values.map((id) {
                      final selected = id == _theme;
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Semantics(
                            selected: selected,
                            button: true,
                            child: Material(
                              color: selected
                                  ? const Color(0xFFFFFFFF)
                                  : AppChrome.cardColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: const BorderSide(
                                  color: AppChrome.borderColor,
                                ),
                              ),
                              clipBehavior: Clip.antiAlias,
                              child: InkWell(
                                onTap: () async {
                                  setState(() => _theme = id);
                                  await ThemeController.instance.setTheme(id);
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 14),
                                  child: Text(
                                    id.label(context),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w800,
                                      fontSize:
                                          constraints.maxWidth < 340 ? 12 : 13,
                                      color: selected
                                          ? const Color(0xFF111111)
                                          : AppChrome.primaryText,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
              const SizedBox(height: 28),
              AppSectionTitle(s.More),
              AppMenuRow(
                icon: CupertinoIcons.cart_fill,
                title: s.RemoveAds,
                subtitle: s.PurchaseSettingsSubtitle,
                onTap: () => _open((context) => const PurchaseScreen()),
              ),
              AppMenuRow(
                icon: CupertinoIcons.question_circle_fill,
                title: s.How_to_play,
                subtitle: s.HowToLearnMore,
                onTap: () => _open((context) => const HowToPlayScreen()),
              ),
              AppMenuRow(
                icon: CupertinoIcons.square_grid_2x2_fill,
                title: s.MoreApps,
                onTap: () => _open((context) => const MorePage()),
              ),
              AppMenuRow(
                icon: CupertinoIcons.doc_text_fill,
                title: s.PrivacyPolicy,
                subtitle: s.PrivacyPolicySubtitle,
                onTap: _openPrivacyPolicy,
              ),
              if (_privacyOptionsRequired)
                AppMenuRow(
                  icon: CupertinoIcons.shield_fill,
                  title: s.PrivacyOptions,
                  subtitle: s.PrivacyOptionsSubtitle,
                  onTap: () => AdsManager.showPrivacyOptionsForm(),
                ),
            ],
          ),
        );
      },
    );
  }
}

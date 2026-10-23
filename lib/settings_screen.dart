import 'dart:math';

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
  bool _reduceMotion = false;
  FeedbackIntensity _feedbackIntensity = FeedbackIntensity.balanced;
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
    final reduceMotion = await SettingsService.getReduceMotion();
    final feedbackIntensity = await SettingsService.getFeedbackIntensity();
    final theme = await SettingsService.getBoardTheme();
    final privacyOptions = await AdsManager.isPrivacyOptionsRequired();
    if (!mounted) return;
    setState(() {
      _sound = sound;
      _haptics = haptics;
      _reduceMotion = reduceMotion;
      _feedbackIntensity = feedbackIntensity;
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

  Future<void> _setReduceMotion(bool value) async {
    setState(() => _reduceMotion = value);
    await FeedbackService.instance.setReduceMotion(value);
  }

  Future<void> _setFeedbackIntensity(FeedbackIntensity value) async {
    setState(() => _feedbackIntensity = value);
    await FeedbackService.instance.setIntensity(value);
  }

  void _open(WidgetBuilder builder) {
    Navigator.of(context).push(fadeRoute(builder));
  }

  Widget _switchRow({
    required IconData icon,
    required String label,
    String? subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return MergeSemantics(
      child: AppMenuRow(
        icon: icon,
        title: label,
        subtitle: subtitle,
        onTap: () => onChanged(!value),
        trailing: Switch.adaptive(
          value: value,
          activeTrackColor: ThemeController.instance.theme.lastMoveBorder,
          activeThumbColor: AppChrome.onPrimary,
          inactiveTrackColor: const Color(0x55FFFFFF),
          inactiveThumbColor: AppChrome.primaryText,
          onChanged: onChanged,
        ),
      ),
    );
  }

  String _feedbackIntensityLabel(
    BuildContext context,
    FeedbackIntensity intensity,
  ) {
    final s = S.of(context);
    return switch (intensity) {
      FeedbackIntensity.gentle => s.FeedbackGentle,
      FeedbackIntensity.balanced => s.FeedbackBalanced,
      FeedbackIntensity.lively => s.FeedbackLively,
    };
  }

  Widget _feedbackIntensitySelector(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final scale = MediaQuery.textScalerOf(context).scale(14) / 14;
        final columns = max(
          1,
          min(3, (constraints.maxWidth / (100 * scale)).floor()),
        );
        final width = (constraints.maxWidth - (columns - 1) * 8) / columns;
        return Wrap(
          spacing: 8,
          runSpacing: 8,
          children: FeedbackIntensity.values.map((intensity) {
            final selected = intensity == _feedbackIntensity;
            return SizedBox(
              width: width,
              child: Semantics(
                selected: selected,
                button: true,
                child: Material(
                  color: selected ? AppChrome.primaryText : AppChrome.cardColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: const BorderSide(color: AppChrome.borderColor),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: () => _setFeedbackIntensity(intensity),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(minHeight: 48),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          children: [
                            ExcludeSemantics(
                              child: Icon(
                                selected
                                    ? CupertinoIcons.checkmark_circle_fill
                                    : CupertinoIcons.circle,
                                size: 20,
                                color: selected
                                    ? AppChrome.onPrimary
                                    : AppChrome.secondaryText,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _feedbackIntensityLabel(context, intensity),
                              textAlign: TextAlign.center,
                              style: AppChrome.actionStyle.copyWith(
                                fontSize: 14,
                                color: selected
                                    ? AppChrome.onPrimary
                                    : AppChrome.primaryText,
                              ),
                            ),
                          ],
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
    );
  }

  Widget _themeSelector(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final scale = MediaQuery.textScalerOf(context).scale(14) / 14;
        final columns = max(
          1,
          min(3, (constraints.maxWidth / (96 * scale)).floor()),
        );
        final width = (constraints.maxWidth - (columns - 1) * 8) / columns;
        return Wrap(
          spacing: 8,
          runSpacing: 8,
          children: BoardThemeId.values.map((id) {
            final selected = id == _theme;
            return SizedBox(
              width: width,
              child: Semantics(
                selected: selected,
                button: true,
                child: Material(
                  color: selected ? AppChrome.primaryText : AppChrome.cardColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: const BorderSide(color: AppChrome.borderColor),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: () async {
                      setState(() => _theme = id);
                      await ThemeController.instance.setTheme(id);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          BoardThemePreview(
                            palette: AppTheme.forId(id),
                            size: min(width - 24, 88),
                          ),
                          const SizedBox(height: 12),
                          ExcludeSemantics(
                            child: Icon(
                              selected
                                  ? CupertinoIcons.checkmark_circle_fill
                                  : CupertinoIcons.circle,
                              size: 20,
                              color: selected
                                  ? AppChrome.onPrimary
                                  : AppChrome.secondaryText,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            id.label(context),
                            textAlign: TextAlign.center,
                            style: AppChrome.actionStyle.copyWith(
                              fontSize: 14,
                              color: selected
                                  ? AppChrome.onPrimary
                                  : AppChrome.primaryText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        );
      },
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
              AppSectionTitle(s.Accessibility),
              _switchRow(
                icon: CupertinoIcons.eye_slash_fill,
                label: s.ReduceMotion,
                subtitle: s.ReduceMotionSubtitle,
                value: _reduceMotion,
                onChanged: _setReduceMotion,
              ),
              AppSectionTitle(s.FeedbackIntensity),
              _feedbackIntensitySelector(context),
              const SizedBox(height: 16),
              AppSectionTitle(s.Theme),
              _themeSelector(context),
              const SizedBox(height: 24),
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

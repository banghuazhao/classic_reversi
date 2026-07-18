import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_theme.dart';
import 'theme_controller.dart';

/// Shared high-contrast chrome for all secondary screens.
abstract final class AppChrome {
  static const cardColor = Color(0x66000000);
  static const subtleCardColor = Color(0x3D000000);
  static const borderColor = Color(0x38FFFFFF);
  static const primaryText = Color(0xFFFFFFFF);
  static const secondaryText = Color(0xD9FFFFFF);
}

class AppGradientScaffold extends StatelessWidget {
  const AppGradientScaffold({
    super.key,
    required this.title,
    required this.child,
    this.maxContentWidth = 720,
  });

  final String title;
  final Widget child;
  final double maxContentWidth;

  @override
  Widget build(BuildContext context) {
    final palette = ThemeController.instance.theme;
    return Scaffold(
      backgroundColor: palette.backgroundFinish,
      body: DecoratedBox(
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
              AppPageHeader(title: title),
              Expanded(
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: maxContentWidth),
                    child: child,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppPageHeader extends StatelessWidget {
  const AppPageHeader({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        children: [
          IconButton(
            tooltip: MaterialLocalizations.of(context).backButtonTooltip,
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              CupertinoIcons.back,
              color: AppChrome.primaryText,
            ),
          ),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Roboto',
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: AppChrome.primaryText,
              ),
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }
}

class AppMenuRow extends StatelessWidget {
  const AppMenuRow({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.onTap,
    this.trailing,
    this.margin = const EdgeInsets.only(bottom: 12),
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final Widget? trailing;
  final EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) {
    final palette = ThemeController.instance.theme;
    return Padding(
      padding: margin,
      child: Material(
        color: AppChrome.cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: const BorderSide(color: AppChrome.borderColor),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 64),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Icon(icon, color: palette.lastMoveBorder, size: 23),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: AppChrome.primaryText,
                          ),
                        ),
                        if (subtitle != null) ...[
                          const SizedBox(height: 3),
                          Text(
                            subtitle!,
                            style: const TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 13,
                              height: 1.3,
                              color: AppChrome.secondaryText,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  trailing ??
                      const Icon(
                        CupertinoIcons.chevron_right,
                        size: 18,
                        color: AppChrome.primaryText,
                      ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AppSectionTitle extends StatelessWidget {
  const AppSectionTitle(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 17,
          fontWeight: FontWeight.w900,
          color: AppChrome.primaryText,
        ),
      ),
    );
  }
}

class AppInfoCard extends StatelessWidget {
  const AppInfoCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(18),
  });

  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppChrome.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppChrome.borderColor),
      ),
      child: Padding(padding: padding, child: child),
    );
  }
}

ButtonStyle appPrimaryButtonStyle([AppTheme? palette]) {
  return ElevatedButton.styleFrom(
    foregroundColor: const Color(0xFF111111),
    backgroundColor: AppChrome.primaryText,
    disabledForegroundColor: const Color(0xFF555555),
    disabledBackgroundColor: const Color(0xB3FFFFFF),
    minimumSize: const Size(48, 54),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    textStyle: const TextStyle(
      fontFamily: 'Roboto',
      fontSize: 16,
      fontWeight: FontWeight.w900,
    ),
  );
}

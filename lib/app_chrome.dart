import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_theme.dart';
import 'theme_controller.dart';

/// Shared high-contrast chrome for all secondary screens.
abstract final class AppChrome {
  static const cardColor = Color(0x33000000);
  static const subtleCardColor = Color(0x1F000000);
  static const borderColor = Color(0x2EFFFFFF);
  static const primaryText = Color(0xFFFFFFFF);
  static const secondaryText = Color(0xD9FFFFFF);
  static const onPrimary = Color(0xFF201C19);
  static const titleStyle = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 22,
    height: 1.25,
    fontWeight: FontWeight.w700,
    color: primaryText,
  );
  static const bodyStyle = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 16,
    height: 1.5,
    color: secondaryText,
  );
  static const actionStyle = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 16,
    height: 1.3,
    fontWeight: FontWeight.w600,
  );
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
            icon: const Icon(CupertinoIcons.back, color: AppChrome.primaryText),
          ),
          Expanded(
            child: Semantics(
              header: true,
              label: title,
              child: ExcludeSemantics(
                child: Tooltip(
                  message: title,
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: AppChrome.primaryText,
                    ),
                  ),
                ),
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
          borderRadius: BorderRadius.circular(16),
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
                  const SizedBox(width: 16),
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
                            fontWeight: FontWeight.w600,
                            color: AppChrome.primaryText,
                          ),
                        ),
                        if (subtitle != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            subtitle!,
                            style: const TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 14,
                              height: 1.45,
                              color: AppChrome.secondaryText,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
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
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 17,
          fontWeight: FontWeight.w700,
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
    this.padding = const EdgeInsets.all(16),
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
    foregroundColor: AppChrome.onPrimary,
    backgroundColor: AppChrome.primaryText,
    disabledForegroundColor: const Color(0xFF555555),
    disabledBackgroundColor: const Color(0xB3FFFFFF),
    elevation: 0,
    minimumSize: const Size(48, 56),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    textStyle: const TextStyle(
      fontFamily: 'Roboto',
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
  );
}

/// Small vector board swatch shared by Home and theme selection. Decorative
/// cells stay out of the accessibility tree; their surrounding control carries
/// the theme's name and selected state.
class BoardThemePreview extends StatelessWidget {
  const BoardThemePreview({super.key, required this.palette, this.size = 80});

  final AppTheme palette;
  final double size;

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: CustomPaint(
        size: Size.square(size),
        painter: _BoardThemePreviewPainter(palette),
      ),
    );
  }
}

class _BoardThemePreviewPainter extends CustomPainter {
  const _BoardThemePreviewPainter(this.palette);

  final AppTheme palette;

  @override
  void paint(Canvas canvas, Size size) {
    final bounds = Offset.zero & size;
    final radius = size.width * 0.10;
    final frame = RRect.fromRectAndRadius(bounds, Radius.circular(radius));
    canvas.drawShadow(
      Path()..addRRect(frame),
      const Color(0x88000000),
      8,
      true,
    );
    canvas.drawRRect(
      frame,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            palette.boardFrameLight,
            palette.boardFrameMid,
            palette.boardFrameDark,
          ],
        ).createShader(bounds),
    );
    final inset = size.width * 0.075;
    final surface = bounds.deflate(inset);
    final cell = surface.width / 4;
    canvas.drawRRect(
      RRect.fromRectAndRadius(surface, Radius.circular(radius * 0.45)),
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [palette.boardSurfaceLight, palette.boardSurfaceDark],
        ).createShader(surface),
    );
    final groove = Paint()
      ..color = palette.boardGrooveDark.withValues(alpha: 0.65)
      ..strokeWidth = 0.8;
    for (var i = 1; i < 4; i++) {
      canvas.drawLine(
        Offset(surface.left + cell * i, surface.top),
        Offset(surface.left + cell * i, surface.bottom),
        groove,
      );
      canvas.drawLine(
        Offset(surface.left, surface.top + cell * i),
        Offset(surface.right, surface.top + cell * i),
        groove,
      );
    }
    for (var row = 1; row <= 2; row++) {
      for (var col = 1; col <= 2; col++) {
        final center = Offset(
          surface.left + cell * (col + 0.5),
          surface.top + cell * (row + 0.5),
        );
        final pieceRadius = cell * 0.39;
        final piece = Rect.fromCircle(center: center, radius: pieceRadius);
        final isWhite = row == col;
        canvas.drawCircle(
          center.translate(0, 1.5),
          pieceRadius,
          Paint()..color = const Color(0x88000000),
        );
        canvas.drawCircle(
          center,
          pieceRadius,
          Paint()
            ..shader = RadialGradient(
              center: const Alignment(-0.4, -0.5),
              radius: 1,
              colors: isWhite
                  ? const [Color(0xFFFFFFFF), Color(0xFFCDC9C0)]
                  : const [Color(0xFF424346), Color(0xFF070809)],
            ).createShader(piece),
        );
        canvas.drawCircle(
          center,
          pieceRadius,
          Paint()
            ..color =
                isWhite ? const Color(0x99FFFFFF) : const Color(0x66FFFFFF)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 0.6,
        );
      }
    }
    canvas.drawRRect(
      frame.deflate(0.6),
      Paint()
        ..color = palette.boardFrameHighlight.withValues(alpha: 0.45)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.8,
    );
  }

  @override
  bool shouldRepaint(_BoardThemePreviewPainter oldDelegate) =>
      oldDelegate.palette != palette;
}

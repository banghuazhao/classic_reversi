import 'package:flutter/cupertino.dart';

import 'app_chrome.dart';
import 'generated/l10n.dart';
import 'theme_controller.dart';

class HowToPlayScreen extends StatelessWidget {
  const HowToPlayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return AppGradientScaffold(
      title: s.How_to_play,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
        children: [
          AppInfoCard(
            child: Text(
              s.How_to_play_explain,
              style: const TextStyle(
                fontFamily: 'Roboto',
                fontSize: 15,
                height: 1.5,
                color: AppChrome.primaryText,
              ),
            ),
          ),
          const SizedBox(height: 22),
          _InstructionCard(
            number: 1,
            icon: CupertinoIcons.circle_grid_3x3_fill,
            title: s.HowToMoveTitle,
            body: s.HowToMoveBody,
          ),
          _InstructionCard(
            number: 2,
            icon: CupertinoIcons.arrow_2_circlepath,
            title: s.HowToTurnsTitle,
            body: s.HowToTurnsBody,
          ),
          _InstructionCard(
            number: 3,
            icon: CupertinoIcons.flag_fill,
            title: s.HowToWinTitle,
            body: s.HowToWinBody,
          ),
          const SizedBox(height: 10),
          AppSectionTitle(s.HowToTipsTitle),
          AppInfoCard(
            child: Text(
              s.HowToTipsBody,
              style: const TextStyle(
                fontFamily: 'Roboto',
                fontSize: 15,
                height: 1.55,
                color: AppChrome.primaryText,
              ),
            ),
          ),
          const SizedBox(height: 22),
          AppSectionTitle(s.HowToControlsTitle),
          AppInfoCard(
            child: Text(
              s.HowToControlsBody,
              style: const TextStyle(
                fontFamily: 'Roboto',
                fontSize: 15,
                height: 1.55,
                color: AppChrome.primaryText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InstructionCard extends StatelessWidget {
  const _InstructionCard({
    required this.number,
    required this.icon,
    required this.title,
    required this.body,
  });

  final int number;
  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final palette = ThemeController.instance.theme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: AppInfoCard(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 42,
              height: 42,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: palette.lastMoveBorder,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 21, color: const Color(0xFF111111)),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$number. $title',
                    style: const TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: AppChrome.primaryText,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    body,
                    style: const TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 14,
                      height: 1.45,
                      color: AppChrome.secondaryText,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

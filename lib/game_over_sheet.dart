import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import 'achievements_service.dart';
import 'app_theme.dart';
import 'game_board.dart';
import 'game_model.dart';
import 'game_settings.dart';
import 'generated/l10n.dart';

Future<void> showGameOverSheet({
  required BuildContext context,
  required GameModel model,
  required GameSettings settings,
  required AppTheme theme,
  required List<AchievementId> newAchievements,
  required bool reduceMotion,
  required double feedbackScale,
  required bool celebrateWin,
  required VoidCallback onRematch,
  required VoidCallback onHome,
}) {
  return showGeneralDialog<void>(
    context: context,
    barrierDismissible: false,
    barrierLabel: 'game-over',
    barrierColor: const Color(0x99000000),
    transitionDuration: Duration(milliseconds: reduceMotion ? 80 : 220),
    pageBuilder: (context, animation, secondaryAnimation) {
      return SafeArea(
        child: Center(
          child: Material(
            color: Colors.transparent,
            child: FadeTransition(
              opacity: animation,
              child: Builder(
                builder: (context) {
                  final card = _GameOverCard(
                    model: model,
                    settings: settings,
                    theme: theme,
                    newAchievements: newAchievements,
                    reduceMotion: reduceMotion,
                    feedbackScale: feedbackScale,
                    celebrateWin: celebrateWin,
                    onRematch: onRematch,
                    onHome: onHome,
                  );
                  if (reduceMotion) {
                    return card;
                  }
                  return ScaleTransition(
                    scale: CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOutBack,
                    ),
                    child: card,
                  );
                },
              ),
            ),
          ),
        ),
      );
    },
  );
}

class _GameOverCard extends StatelessWidget {
  final GameModel model;
  final GameSettings settings;
  final AppTheme theme;
  final List<AchievementId> newAchievements;
  final bool reduceMotion;
  final double feedbackScale;
  final bool celebrateWin;
  final VoidCallback onRematch;
  final VoidCallback onHome;

  const _GameOverCard({
    required this.model,
    required this.settings,
    required this.theme,
    required this.newAchievements,
    required this.reduceMotion,
    required this.feedbackScale,
    required this.celebrateWin,
    required this.onRematch,
    required this.onHome,
  });

  bool get _isTie => model.blackScore == model.whiteScore;

  bool? get _humanWon {
    if (settings.twoPlayerMode || _isTie) {
      return null;
    }
    return model.blackScore > model.whiteScore
        ? settings.humanColor == PieceType.black
        : settings.humanColor == PieceType.white;
  }

  String _headline(BuildContext context) {
    final s = S.of(context);
    if (_isTie) {
      return s.Tie;
    }
    if (settings.twoPlayerMode) {
      return model.blackScore > model.whiteScore ? s.BlackWins : s.WhiteWins;
    }
    return _humanWon == true ? s.YouWin : s.YouLose;
  }

  String _shareText(BuildContext context) {
    final s = S.of(context);
    final result = _headline(context);
    final mode = settings.isDailyChallenge
        ? s.DailyChallenge
        : settings.twoPlayerMode
            ? s.TwoPlayersMode
            : settings.difficulty.label(context);
    return s.ShareResult(
      result,
      model.blackScore,
      model.whiteScore,
      mode,
    );
  }

  Future<void> _share(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;
    await SharePlus.instance.share(
      ShareParams(
        text: _shareText(context),
        sharePositionOrigin:
            box != null ? box.localToGlobal(Offset.zero) & box.size : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 28),
      padding: const EdgeInsets.fromLTRB(22, 24, 22, 18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [theme.backgroundStart, theme.backgroundFinish],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0x40ffffff)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            s.GameOver,
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 16,
              color: theme.scoreWhite.withValues(alpha: 0.85),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (celebrateWin) ...[
                Icon(
                  CupertinoIcons.sparkles,
                  size: 20,
                  color: theme.lastMoveBorder,
                ),
                const SizedBox(width: 9),
              ],
              Flexible(
                child: Text(
                  _headline(context),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    fontStyle: FontStyle.italic,
                    color: theme.scoreWhite,
                  ),
                ),
              ),
              if (celebrateWin) ...[
                const SizedBox(width: 9),
                Icon(
                  CupertinoIcons.sparkles,
                  size: 20,
                  color: theme.lastMoveBorder,
                ),
              ],
            ],
          ),
          const SizedBox(height: 14),
          _AnimatedFinalScore(
            blackLabel: s.Black,
            whiteLabel: s.White,
            blackScore: model.blackScore,
            whiteScore: model.whiteScore,
            color: theme.scoreWhite,
            reduceMotion: reduceMotion,
            feedbackScale: feedbackScale,
          ),
          if (newAchievements.isNotEmpty) ...[
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                s.AchievementUnlocked,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 13,
                  color: theme.scoreWhite.withValues(alpha: 0.9),
                ),
              ),
            ),
            const SizedBox(height: 6),
            ...newAchievements.map(
              (a) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  children: [
                    Icon(CupertinoIcons.star_fill,
                        size: 16, color: theme.lastMoveBorder),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        a.title(context),
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 14,
                          color: theme.scoreWhite,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
          const SizedBox(height: 22),
          Row(
            children: [
              Expanded(
                child: _ActionButton(
                  label: s.Rematch,
                  filled: true,
                  onPressed: () {
                    Navigator.of(context).pop();
                    onRematch();
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _ActionButton(
                  label: s.Share,
                  filled: false,
                  onPressed: () => _share(context),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: _ActionButton(
              label: s.Home,
              filled: false,
              onPressed: () {
                Navigator.of(context).pop();
                onHome();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _AnimatedFinalScore extends StatelessWidget {
  final String blackLabel;
  final String whiteLabel;
  final int blackScore;
  final int whiteScore;
  final Color color;
  final bool reduceMotion;
  final double feedbackScale;

  const _AnimatedFinalScore({
    required this.blackLabel,
    required this.whiteLabel,
    required this.blackScore,
    required this.whiteScore,
    required this.color,
    required this.reduceMotion,
    required this.feedbackScale,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontFamily: 'Roboto',
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: color,
    );
    if (reduceMotion ||
        (MediaQuery.maybeOf(context)?.disableAnimations ?? false)) {
      return Text(
        '$blackLabel $blackScore  ·  $whiteLabel $whiteScore',
        style: textStyle,
      );
    }
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 680),
      curve: Curves.easeOutCubic,
      builder: (context, progress, child) {
        final black = (blackScore * progress).round();
        final white = (whiteScore * progress).round();
        final settle =
            1 + (1 - progress) * 0.025 * feedbackScale.clamp(0.65, 1.3);
        return Transform.scale(
          scale: settle,
          child: Text(
            '$blackLabel $black  ·  $whiteLabel $white',
            style: textStyle,
          ),
        );
      },
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final bool filled;
  final VoidCallback onPressed;

  const _ActionButton({
    required this.label,
    required this.filled,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor:
            filled ? const Color(0xffffffff) : const Color(0x40ffffff),
        foregroundColor:
            filled ? const Color(0xff000000) : const Color(0xffffffff),
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 15,
          fontWeight: FontWeight.w800,
          color: filled ? const Color(0xff000000) : const Color(0xffffffff),
        ),
      ),
    );
  }
}

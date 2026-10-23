import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'achievements_service.dart';
import 'achievement_progress.dart';
import 'app_chrome.dart';
import 'generated/l10n.dart';
import 'theme_controller.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  PlayerStats? _stats;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final stats = await AchievementsService.instance.loadStats();
    if (!mounted) return;
    setState(() => _stats = stats);
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return ListenableBuilder(
      listenable: ThemeController.instance,
      builder: (context, _) {
        final stats = _stats;
        return AppGradientScaffold(
          title: s.Stats,
          child: stats == null
              ? const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                )
              : RefreshIndicator(
                  onRefresh: _load,
                  child: ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
                    children: [
                      _SummaryCard(stats: stats),
                      if (AchievementProgress.nextMilestone(stats)
                          case final goal?) ...[
                        const SizedBox(height: 16),
                        _NextMilestoneCard(progress: goal),
                      ],
                      const SizedBox(height: 24),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          final scale =
                              MediaQuery.textScalerOf(context).scale(14) / 14;
                          final columns = max(
                            1,
                            min(
                              3,
                              (constraints.maxWidth / (140 * scale)).floor(),
                            ),
                          );
                          final width =
                              (constraints.maxWidth - (columns - 1) * 16) /
                                  columns;
                          final cards = [
                            _MetricCard(
                              label: s.Wins,
                              value: '${stats.wins}',
                              icon: CupertinoIcons.hand_thumbsup_fill,
                            ),
                            _MetricCard(
                              label: s.Losses,
                              value: '${stats.losses}',
                              icon: CupertinoIcons.hand_thumbsdown_fill,
                            ),
                            _MetricCard(
                              label: s.Ties,
                              value: '${stats.ties}',
                              icon: CupertinoIcons.equal_circle_fill,
                            ),
                            _MetricCard(
                              label: s.CurrentStreak,
                              value: '${stats.currentStreak}',
                              icon: CupertinoIcons.flame_fill,
                            ),
                            _MetricCard(
                              label: s.BestStreak,
                              value: '${stats.bestStreak}',
                              icon: CupertinoIcons.bolt_fill,
                            ),
                            _MetricCard(
                              label: s.PerfectWins,
                              value: '${stats.perfectWins}',
                              icon: CupertinoIcons.sparkles,
                            ),
                          ];
                          return Wrap(
                            spacing: 16,
                            runSpacing: 16,
                            children: cards
                                .map(
                                  (card) => SizedBox(width: width, child: card),
                                )
                                .toList(),
                          );
                        },
                      ),
                      const SizedBox(height: 24),
                      AppSectionTitle(s.WinsByDifficulty),
                      AppInfoCard(
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            final scale =
                                MediaQuery.textScalerOf(context).scale(14) / 14;
                            final columns = max(
                              1,
                              min(
                                4,
                                (constraints.maxWidth / (104 * scale)).floor(),
                              ),
                            );
                            final width =
                                (constraints.maxWidth - (columns - 1) * 16) /
                                    columns;
                            final difficulties = [
                              _DifficultyStat(
                                label: s.DifficultySuperEasy,
                                value: stats.winsSuperEasy,
                              ),
                              _DifficultyStat(
                                label: s.DifficultyEasy,
                                value: stats.winsEasy,
                              ),
                              _DifficultyStat(
                                label: s.DifficultyMedium,
                                value: stats.winsMedium,
                              ),
                              _DifficultyStat(
                                label: s.DifficultyHard,
                                value: stats.winsHard,
                              ),
                            ];
                            return Wrap(
                              spacing: 16,
                              runSpacing: 16,
                              children: difficulties
                                  .map(
                                    (item) =>
                                        SizedBox(width: width, child: item),
                                  )
                                  .toList(),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 24),
                      AppSectionTitle(s.DailyChallenge),
                      _WideMetricCard(
                        value: '${stats.dailyCompletions}',
                        label: s.DailyCompletions,
                        icon: CupertinoIcons.calendar_badge_plus,
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(child: AppSectionTitle(s.Achievements)),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Text(
                              '${AchievementProgress.forStats(stats).where((goal) => goal.completed).length}/${AchievementId.values.length}',
                              style: const TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppChrome.secondaryText,
                              ),
                            ),
                          ),
                        ],
                      ),
                      ...AchievementProgress.forStats(stats).map(
                        (goal) => _AchievementRow(progress: goal),
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({required this.stats});

  final PlayerStats stats;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final palette = ThemeController.instance.theme;
    final percent = (stats.winRate * 100).round();
    final gauge = SizedBox(
      width: 82,
      height: 82,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox.expand(
            child: CircularProgressIndicator(
              value: stats.gamesPlayed == 0 ? 0 : stats.winRate,
              strokeWidth: 8,
              backgroundColor: const Color(0x2EFFFFFF),
              color: palette.lastMoveBorder,
            ),
          ),
          SizedBox(
            width: 62,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                '$percent%',
                style: const TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppChrome.primaryText,
                ),
              ),
            ),
          ),
        ],
      ),
    );
    final details = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          s.WinRate,
          style: const TextStyle(
            fontFamily: 'Roboto',
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppChrome.primaryText,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '${s.GamesPlayed}: ${stats.gamesPlayed}',
          style: const TextStyle(
            fontFamily: 'Roboto',
            fontSize: 14,
            color: AppChrome.secondaryText,
          ),
        ),
      ],
    );
    return AppInfoCard(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final scale = MediaQuery.textScalerOf(context).scale(14) / 14;
          if (constraints.maxWidth < 260 * scale) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [gauge, const SizedBox(height: 20), details],
            );
          }
          return Row(children: [
            gauge,
            const SizedBox(width: 16),
            Expanded(child: details),
          ]);
        },
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final palette = ThemeController.instance.theme;
    return AppInfoCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: palette.lastMoveBorder),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'Roboto',
              fontSize: 26,
              fontWeight: FontWeight.w700,
              color: AppChrome.primaryText,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'Roboto',
              fontSize: 14,
              color: AppChrome.secondaryText,
            ),
          ),
        ],
      ),
    );
  }
}

class _DifficultyStat extends StatelessWidget {
  const _DifficultyStat({required this.label, required this.value});

  final String label;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '$value',
          style: const TextStyle(
            fontFamily: 'Roboto',
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: AppChrome.primaryText,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: 'Roboto',
            fontSize: 14,
            color: AppChrome.secondaryText,
          ),
        ),
      ],
    );
  }
}

class _WideMetricCard extends StatelessWidget {
  const _WideMetricCard({
    required this.value,
    required this.label,
    required this.icon,
  });

  final String value;
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final palette = ThemeController.instance.theme;
    const valueStyle = TextStyle(
      fontFamily: 'Roboto',
      fontSize: 26,
      fontWeight: FontWeight.w700,
      color: AppChrome.primaryText,
    );
    const labelStyle = TextStyle(
      fontFamily: 'Roboto',
      fontSize: 14,
      color: AppChrome.secondaryText,
    );
    return AppInfoCard(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final scale = MediaQuery.textScalerOf(context).scale(14) / 14;
          if (constraints.maxWidth < 300 * scale) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Icon(icon, color: palette.lastMoveBorder, size: 28),
                  const SizedBox(width: 16),
                  Expanded(child: Text(label, style: labelStyle)),
                ]),
                const SizedBox(height: 12),
                Text(value, style: valueStyle),
              ],
            );
          }
          return Row(children: [
            Icon(icon, color: palette.lastMoveBorder, size: 28),
            const SizedBox(width: 16),
            Text(value, style: valueStyle),
            const SizedBox(width: 12),
            Expanded(child: Text(label, style: labelStyle)),
          ]);
        },
      ),
    );
  }
}

String _progressLabel(BuildContext context, AchievementProgress progress) {
  final s = S.of(context);
  return switch (progress.metric) {
    AchievementMetric.games =>
      s.AchievementGamesProgress(progress.current, progress.target),
    AchievementMetric.streak =>
      s.AchievementStreakProgress(progress.current, progress.target),
    AchievementMetric.wins ||
    AchievementMetric.hardWins ||
    AchievementMetric.perfectWins ||
    AchievementMetric.dailyWins =>
      s.AchievementWinsProgress(progress.current, progress.target),
  };
}

class _NextMilestoneCard extends StatelessWidget {
  const _NextMilestoneCard({required this.progress});
  final AchievementProgress progress;

  @override
  Widget build(BuildContext context) {
    return AppInfoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(S.of(context).NextMilestone,
              style: TextStyle(
                  color: ThemeController.instance.theme.lastMoveBorder,
                  fontSize: 14,
                  fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Text(progress.id.title(context),
              style: AppChrome.titleStyle.copyWith(fontSize: 18)),
          const SizedBox(height: 12),
          _MilestoneMeter(progress: progress),
        ],
      ),
    );
  }
}

class _MilestoneMeter extends StatelessWidget {
  const _MilestoneMeter({required this.progress});
  final AchievementProgress progress;

  @override
  Widget build(BuildContext context) {
    final label = _progressLabel(context, progress);
    return Semantics(
      label: progress.id.title(context),
      value: label,
      child: ExcludeSemantics(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(label,
                style: const TextStyle(
                    color: AppChrome.secondaryText, fontSize: 14, height: 1.4)),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                  value: progress.fraction,
                  minHeight: 6,
                  backgroundColor: AppChrome.borderColor,
                  color: ThemeController.instance.theme.lastMoveBorder),
            ),
          ],
        ),
      ),
    );
  }
}

class _AchievementRow extends StatelessWidget {
  const _AchievementRow({required this.progress});
  final AchievementProgress progress;

  @override
  Widget build(BuildContext context) {
    final palette = ThemeController.instance.theme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: AppInfoCard(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
                progress.completed
                    ? CupertinoIcons.star_fill
                    : CupertinoIcons.lock_fill,
                color: progress.completed
                    ? palette.lastMoveBorder
                    : AppChrome.secondaryText,
                size: 22),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(progress.id.title(context),
                      style: const TextStyle(
                          fontSize: 16,
                          height: 1.4,
                          fontWeight: FontWeight.w600,
                          color: AppChrome.primaryText)),
                  const SizedBox(height: 8),
                  if (progress.completed)
                    Text(S.of(context).MilestoneCompleted,
                        style: const TextStyle(
                            fontSize: 14, color: AppChrome.secondaryText))
                  else
                    _MilestoneMeter(progress: progress),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

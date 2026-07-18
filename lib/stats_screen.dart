import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'achievements_service.dart';
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
                      const SizedBox(height: 22),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          final columns = constraints.maxWidth >= 620 ? 3 : 2;
                          final width =
                              (constraints.maxWidth - (columns - 1) * 12) /
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
                            spacing: 12,
                            runSpacing: 12,
                            children: cards
                                .map((card) =>
                                    SizedBox(width: width, child: card))
                                .toList(),
                          );
                        },
                      ),
                      const SizedBox(height: 24),
                      AppSectionTitle(s.WinsByDifficulty),
                      AppInfoCard(
                        child: Row(
                          children: [
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
                          ],
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
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Text(
                              '${stats.unlockedAchievements.length}/${AchievementId.values.length}',
                              style: const TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                                color: AppChrome.secondaryText,
                              ),
                            ),
                          ),
                        ],
                      ),
                      ...AchievementId.values.map(
                        (id) => _AchievementRow(
                          title: id.title(context),
                          unlocked: stats.unlockedAchievements
                              .contains(id.storageKey),
                        ),
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
    return AppInfoCard(
      child: Row(
        children: [
          SizedBox(
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
                Text(
                  '$percent%',
                  style: const TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: AppChrome.primaryText,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  s.WinRate,
                  style: const TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: AppChrome.primaryText,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '${s.GamesPlayed}: ${stats.gamesPlayed}',
                  style: const TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 14,
                    color: AppChrome.secondaryText,
                  ),
                ),
              ],
            ),
          ),
        ],
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
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: palette.lastMoveBorder),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'Roboto',
              fontSize: 26,
              fontWeight: FontWeight.w900,
              color: AppChrome.primaryText,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            label,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontFamily: 'Roboto',
              fontSize: 13,
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
    return Expanded(
      child: Column(
        children: [
          Text(
            '$value',
            style: const TextStyle(
              fontFamily: 'Roboto',
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: AppChrome.primaryText,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'Roboto',
              fontSize: 13,
              color: AppChrome.secondaryText,
            ),
          ),
        ],
      ),
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
    return AppInfoCard(
      child: Row(
        children: [
          Icon(icon, color: palette.lastMoveBorder, size: 28),
          const SizedBox(width: 14),
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'Roboto',
              fontSize: 26,
              fontWeight: FontWeight.w900,
              color: AppChrome.primaryText,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontFamily: 'Roboto',
                fontSize: 14,
                color: AppChrome.secondaryText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AchievementRow extends StatelessWidget {
  const _AchievementRow({required this.title, required this.unlocked});

  final String title;
  final bool unlocked;

  @override
  Widget build(BuildContext context) {
    final palette = ThemeController.instance.theme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: unlocked ? AppChrome.cardColor : AppChrome.subtleCardColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppChrome.borderColor),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Icon(
                unlocked ? CupertinoIcons.star_fill : CupertinoIcons.lock_fill,
                color:
                    unlocked ? palette.lastMoveBorder : AppChrome.secondaryText,
                size: 20,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: unlocked
                        ? AppChrome.primaryText
                        : AppChrome.secondaryText,
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'achievements_service.dart';
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
    final theme = ThemeController.instance.theme;
    final stats = _stats;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [theme.backgroundStart, theme.backgroundFinish],
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
                        s.Stats,
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
                child: stats == null
                    ? const Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      )
                    : ListView(
                        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                        children: [
                          _statCard(s.WinsLosses(stats.wins, stats.losses)),
                          _statCard('${s.Ties}: ${stats.ties}'),
                          _statCard(
                              '${s.GamesPlayed}: ${stats.gamesPlayed}'),
                          _statCard(
                            '${s.WinRate}: ${(stats.winRate * 100).toStringAsFixed(0)}%',
                          ),
                          _statCard(
                              '${s.CurrentStreak}: ${stats.currentStreak}'),
                          _statCard('${s.BestStreak}: ${stats.bestStreak}'),
                          _statCard(
                            '${s.WinsByDifficulty}: '
                            '${s.DifficultyEasy} ${stats.winsEasy} · '
                            '${s.DifficultyMedium} ${stats.winsMedium} · '
                            '${s.DifficultyHard} ${stats.winsHard}',
                          ),
                          _statCard(
                              '${s.PerfectWins}: ${stats.perfectWins}'),
                          _statCard(
                            '${s.DailyChallenge}: ${stats.dailyCompletions}',
                          ),
                          const SizedBox(height: 18),
                          Text(
                            s.Achievements,
                            style: const TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              color: Color(0xffffffff),
                            ),
                          ),
                          const SizedBox(height: 10),
                          ...AchievementId.values.map((id) {
                            final unlocked = stats.unlockedAchievements
                                .contains(id.storageKey);
                            return Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 14),
                              decoration: BoxDecoration(
                                color: unlocked
                                    ? const Color(0x50ffffff)
                                    : const Color(0x28ffffff),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    unlocked
                                        ? CupertinoIcons.star_fill
                                        : CupertinoIcons.star,
                                    color: unlocked
                                        ? theme.lastMoveBorder
                                        : const Color(0x80ffffff),
                                    size: 20,
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      id.title(context),
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: unlocked
                                            ? const Color(0xffffffff)
                                            : const Color(0x90ffffff),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statCard(String text) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0x40ffffff),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: Color(0xffffffff),
        ),
      ),
    );
  }
}

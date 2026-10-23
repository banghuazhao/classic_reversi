import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_chrome.dart';
import 'generated/l10n.dart';
import 'main.dart';
import 'puzzle_progress.dart';
import 'puzzle_screen.dart';
import 'puzzles.dart';
import 'theme_controller.dart';

class PuzzlesScreen extends StatefulWidget {
  const PuzzlesScreen({super.key});

  @override
  State<PuzzlesScreen> createState() => _PuzzlesScreenState();
}

class _PuzzlesScreenState extends State<PuzzlesScreen> {
  final _search = TextEditingController();
  Set<String> _completed = {};
  bool _loading = true;
  bool _failed = false;
  int _loadGeneration = 0;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _loadGeneration++;
    _search.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    final generation = ++_loadGeneration;
    setState(() {
      _loading = true;
      _failed = false;
    });
    try {
      final completed = await PuzzleProgressService.loadCompletedIds();
      if (mounted && generation == _loadGeneration) {
        setState(() => _completed = completed);
      }
    } catch (error) {
      debugPrint('Loading puzzle progress failed: $error');
      if (mounted && generation == _loadGeneration) {
        setState(() => _failed = true);
      }
    } finally {
      if (mounted && generation == _loadGeneration) {
        setState(() => _loading = false);
      }
    }
  }

  String _skillTitle(S s, PuzzleSkill skill) => switch (skill) {
        PuzzleSkill.corner => s.PuzzleCornerSkill,
        PuzzleSkill.forcedPass => s.PuzzlePassSkill,
        PuzzleSkill.endgame => s.PuzzleEndgameSkill,
      };

  String _description(S s, PuzzleSkill skill) => switch (skill) {
        PuzzleSkill.corner => s.PuzzleCornerDescription,
        PuzzleSkill.forcedPass => s.PuzzlePassDescription,
        PuzzleSkill.endgame => s.PuzzleEndgameDescription,
      };

  IconData _icon(PuzzleSkill skill) => switch (skill) {
        PuzzleSkill.corner => CupertinoIcons.arrow_up_left,
        PuzzleSkill.forcedPass => CupertinoIcons.arrow_2_circlepath,
        PuzzleSkill.endgame => CupertinoIcons.flag,
      };

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final query = _search.text.trim().toLowerCase();
    final puzzles = curatedPuzzles.where((puzzle) {
      final searchable = [
        puzzle.id,
        s.PuzzleNumber(puzzle.number),
        _skillTitle(s, puzzle.skill),
        _description(s, puzzle.skill),
      ].join(' ').toLowerCase();
      return searchable.contains(query);
    }).toList();
    return ListenableBuilder(
      listenable: ThemeController.instance,
      builder: (context, _) {
        final palette = ThemeController.instance.theme;
        return AppGradientScaffold(
          title: s.Puzzles,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
            children: [
              AppInfoCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(s.PuzzlesSubtitle, style: AppChrome.bodyStyle),
                    const SizedBox(height: 16),
                    if (_failed) ...[
                      Text(s.PuzzleProgressLoadFailed,
                          style: AppChrome.bodyStyle),
                      const SizedBox(height: 8),
                      TextButton(
                        key: const ValueKey('puzzle-progress-retry'),
                        onPressed: _load,
                        child: Text(s.TryAgain),
                      ),
                    ] else if (!_loading) ...[
                      Text(
                        s.PuzzleProgress(
                            _completed.length, curatedPuzzles.length),
                        style: AppChrome.actionStyle.copyWith(
                          color: AppChrome.primaryText,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ExcludeSemantics(
                        child: LinearProgressIndicator(
                          value: _completed.length / curatedPuzzles.length,
                          backgroundColor: AppChrome.borderColor,
                          color: palette.lastMoveBorder,
                          borderRadius: BorderRadius.circular(8),
                          minHeight: 6,
                        ),
                      ),
                      if (_completed.length == curatedPuzzles.length) ...[
                        const SizedBox(height: 16),
                        Text(s.PuzzleAllComplete, style: AppChrome.bodyStyle),
                      ],
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                key: const ValueKey('puzzle-search'),
                controller: _search,
                onChanged: (_) => setState(() {}),
                style:
                    AppChrome.bodyStyle.copyWith(color: AppChrome.primaryText),
                cursorColor: palette.lastMoveBorder,
                decoration: InputDecoration(
                  labelText: s.PuzzleSearch,
                  labelStyle: const TextStyle(color: AppChrome.secondaryText),
                  prefixIcon: const Icon(CupertinoIcons.search,
                      color: AppChrome.secondaryText),
                  filled: true,
                  fillColor: AppChrome.cardColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: AppChrome.borderColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: AppChrome.borderColor),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              if (_loading) const Center(child: CircularProgressIndicator()),
              if (puzzles.isEmpty)
                Text(s.PuzzleNoResults, style: AppChrome.bodyStyle),
              for (final skill in PuzzleSkill.values)
                if (puzzles.any((puzzle) => puzzle.skill == skill)) ...[
                  Semantics(
                    header: true,
                    child: AppSectionTitle(_skillTitle(s, skill)),
                  ),
                  Text(_description(s, skill), style: AppChrome.bodyStyle),
                  const SizedBox(height: 16),
                  for (final puzzle in puzzles.where((p) => p.skill == skill))
                    Semantics(
                      value: _completed.contains(puzzle.id)
                          ? s.PuzzleCompleted
                          : null,
                      child: AppMenuRow(
                        icon: _icon(skill),
                        title: s.PuzzleNumber(puzzle.number),
                        subtitle: _completed.contains(puzzle.id)
                            ? s.PuzzleCompleted
                            : _description(s, skill),
                        trailing: _completed.contains(puzzle.id)
                            ? Icon(CupertinoIcons.checkmark_circle_fill,
                                color: palette.lastMoveBorder)
                            : null,
                        onTap: () async {
                          FocusManager.instance.primaryFocus?.unfocus();
                          await Navigator.of(context).push(
                            fadeRoute(
                                (context) => PuzzleScreen(puzzle: puzzle)),
                          );
                          if (mounted) await _load();
                        },
                      ),
                    ),
                  const SizedBox(height: 16),
                ],
            ],
          ),
        );
      },
    );
  }
}

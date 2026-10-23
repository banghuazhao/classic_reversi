import 'package:flutter/material.dart';

import 'app_chrome.dart';
import 'app_theme.dart';
import 'game_board.dart';
import 'game_review_screen.dart';
import 'game_settings.dart';
import 'generated/l10n.dart';
import 'match_library.dart';
import 'theme_controller.dart';

/// A quiet, local shelf of finished games. Every card opens the full replay.
class MatchLibraryScreen extends StatefulWidget {
  const MatchLibraryScreen({super.key});

  @override
  State<MatchLibraryScreen> createState() => _MatchLibraryScreenState();
}

class _MatchLibraryScreenState extends State<MatchLibraryScreen> {
  List<SavedMatch> _matches = const [];
  bool _loading = true;
  bool _failed = false;
  final Set<String> _deleting = {};

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _failed = false;
    });
    try {
      final matches = await MatchLibraryService.load();
      if (!mounted) return;
      setState(() => _matches = matches);
    } catch (_) {
      if (mounted) setState(() => _failed = true);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _review(SavedMatch record) {
    Navigator.of(context).push(MaterialPageRoute<void>(
      builder: (_) => GameReviewScreen(
        history: record.history,
        settings: record.settings,
        playedAt: record.startedAt,
      ),
    ));
  }

  Future<void> _delete(SavedMatch record) async {
    if (_deleting.contains(record.id)) return;
    final s = S.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        scrollable: true,
        backgroundColor: ThemeController.instance.theme.backgroundFinish,
        title: Text(s.DeleteSavedMatchTitle, style: AppChrome.titleStyle),
        content: Text(s.DeleteSavedMatchMessage, style: AppChrome.bodyStyle),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(s.Cancel),
          ),
          TextButton(
            key: const ValueKey('confirm-delete-match'),
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(s.Delete),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    setState(() => _deleting.add(record.id));
    try {
      await MatchLibraryService.remove(record.id);
      if (mounted) {
        setState(() {
          _matches = _matches.where((match) => match.id != record.id).toList();
        });
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(S.of(context).MatchLibraryDeleteError),
        ));
      }
    } finally {
      if (mounted) setState(() => _deleting.remove(record.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return AppGradientScaffold(
      title: s.MatchLibrary,
      child: _loading
          ? Center(
              child: CircularProgressIndicator(
              semanticsLabel: s.MatchLibrary,
              color: ThemeController.instance.theme.lastMoveBorder,
            ))
          : _failed
              ? _LibraryMessage(
                  icon: Icons.error_outline_rounded,
                  title: s.MatchLibraryLoadError,
                  action: OutlinedButton(
                    onPressed: _load,
                    child: Text(s.TryAgain),
                  ),
                )
              : _matches.isEmpty
                  ? _LibraryMessage(
                      icon: Icons.auto_stories_outlined,
                      title: s.MatchLibraryEmptyTitle,
                      body: s.MatchLibraryEmptyBody,
                    )
                  : ListView.builder(
                      key: const ValueKey('match-library-list'),
                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
                      itemCount: _matches.length + 1,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 24),
                            child: Text(
                              s.MatchLibrarySubtitle,
                              style: AppChrome.bodyStyle,
                            ),
                          );
                        }
                        final record = _matches[index - 1];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: _SavedMatchCard(
                            record: record,
                            deleting: _deleting.contains(record.id),
                            onReview: () => _review(record),
                            onDelete: () => _delete(record),
                          ),
                        );
                      },
                    ),
    );
  }
}

class _LibraryMessage extends StatelessWidget {
  const _LibraryMessage({
    required this.icon,
    required this.title,
    this.body,
    this.action,
  });

  final IconData icon;
  final String title;
  final String? body;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 32),
      child: AppInfoCard(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ExcludeSemantics(
                child: Icon(
              icon,
              size: 48,
              color: ThemeController.instance.theme.lastMoveBorder,
            )),
            const SizedBox(height: 24),
            Semantics(
              header: true,
              child: Text(title, style: AppChrome.titleStyle),
            ),
            if (body != null) ...[
              const SizedBox(height: 12),
              Text(body!, style: AppChrome.bodyStyle),
            ],
            if (action != null) ...[
              const SizedBox(height: 24),
              action!,
            ],
          ],
        ),
      ),
    );
  }
}

class _SavedMatchCard extends StatelessWidget {
  const _SavedMatchCard({
    required this.record,
    required this.deleting,
    required this.onReview,
    required this.onDelete,
  });

  final SavedMatch record;
  final bool deleting;
  final VoidCallback onReview;
  final VoidCallback onDelete;

  String _result(S s) {
    final model = record.finalModel;
    if (model.blackScore == model.whiteScore) return s.Tie;
    final winner =
        model.blackScore > model.whiteScore ? PieceType.black : PieceType.white;
    if (record.settings.twoPlayerMode) {
      return winner == PieceType.black ? s.BlackWins : s.WhiteWins;
    }
    return winner == record.settings.humanColor ? s.YouWin : s.YouLose;
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final localizations = MaterialLocalizations.of(context);
    final playedAt = record.startedAt.toLocal();
    final date = localizations.formatMediumDate(playedAt);
    final time = localizations.formatTimeOfDay(
      TimeOfDay.fromDateTime(playedAt),
      alwaysUse24HourFormat: MediaQuery.alwaysUse24HourFormatOf(context),
    );
    final dateLabel = '$date · $time';
    final result = _result(s);
    final mode = record.settings.isDailyChallenge
        ? s.DailyChallenge
        : record.settings.twoPlayerMode
            ? s.TwoPlayersMode
            : s.AgainstComputer;
    final difficulty = record.settings.difficulty.label(context);
    final score = s.SavedMatchScore(
        record.finalModel.blackScore, record.finalModel.whiteScore);
    final humanLabel = record.settings.twoPlayerMode
        ? null
        : s.YouColor(
            record.settings.humanColor == PieceType.black ? s.Black : s.White);
    final summary = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(dateLabel,
            style: const TextStyle(
              color: AppChrome.secondaryText,
              fontSize: 14,
              height: 1.5,
            )),
        const SizedBox(height: 8),
        Text(result,
            style: AppChrome.titleStyle.copyWith(
              color: ThemeController.instance.theme.lastMoveBorder,
            )),
        const SizedBox(height: 8),
        Text(score, style: AppChrome.bodyStyle),
        const SizedBox(height: 8),
        Text('$mode · $difficulty',
            style: const TextStyle(
              color: AppChrome.secondaryText,
              fontSize: 14,
              height: 1.5,
            )),
        if (humanLabel != null) ...[
          const SizedBox(height: 4),
          Text(humanLabel,
              style: const TextStyle(
                  color: AppChrome.secondaryText, fontSize: 14, height: 1.5)),
        ],
        const SizedBox(height: 16),
        Text(s.MatchLibraryOpen,
            style: const TextStyle(
              color: AppChrome.primaryText,
              fontSize: 16,
              height: 1.4,
              fontWeight: FontWeight.w600,
            )),
      ],
    );
    final thumbnail = ExcludeSemantics(
        child: CustomPaint(
      size: const Size.square(96),
      painter: _MatchThumbnailPainter(
          record.finalModel.board, ThemeController.instance.theme),
    ));
    return Material(
      color: AppChrome.cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppChrome.borderColor),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Semantics(
            button: true,
            label: [
              dateLabel,
              result,
              score,
              mode,
              difficulty,
              if (humanLabel != null) humanLabel
            ].join('. '),
            hint: s.MatchLibraryOpen,
            excludeSemantics: true,
            onTap: onReview,
            child: InkWell(
              key: ValueKey('review-saved-match-${record.id}'),
              onTap: onReview,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: LayoutBuilder(builder: (context, constraints) {
                  final largeText =
                      MediaQuery.textScalerOf(context).scale(16) > 24;
                  if (constraints.maxWidth < 380 || largeText) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        thumbnail,
                        const SizedBox(height: 20),
                        summary,
                      ],
                    );
                  }
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      thumbnail,
                      const SizedBox(width: 24),
                      Expanded(child: summary),
                    ],
                  );
                }),
              ),
            ),
          ),
          const Divider(height: 1, color: AppChrome.borderColor),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: IconButton(
                key: ValueKey('delete-saved-match-${record.id}'),
                tooltip: '${s.DeleteSavedMatch} · $dateLabel',
                onPressed: deleting ? null : onDelete,
                style: IconButton.styleFrom(
                  foregroundColor: AppChrome.secondaryText,
                  minimumSize: const Size(48, 48),
                ),
                icon: deleting
                    ? const SizedBox.square(
                        dimension: 20,
                        child: CircularProgressIndicator(strokeWidth: 2))
                    : const Icon(Icons.delete_outline_rounded),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MatchThumbnailPainter extends CustomPainter {
  const _MatchThumbnailPainter(this.board, this.palette);

  final GameBoard board;
  final AppTheme palette;

  @override
  void paint(Canvas canvas, Size size) {
    final bounds = Offset.zero & size;
    canvas.drawRRect(
      RRect.fromRectAndRadius(bounds, const Radius.circular(10)),
      Paint()..color = palette.boardFrameMid,
    );
    final surface = bounds.deflate(5);
    canvas.drawRect(
        surface,
        Paint()
          ..shader = LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [palette.boardSurfaceLight, palette.boardSurfaceDark],
          ).createShader(surface));
    final cell = surface.width / board.size;
    final groove = Paint()
      ..color = palette.boardGrooveDark
      ..strokeWidth = 0.6;
    for (var index = 1; index < board.size; index++) {
      canvas.drawLine(Offset(surface.left + cell * index, surface.top),
          Offset(surface.left + cell * index, surface.bottom), groove);
      canvas.drawLine(Offset(surface.left, surface.top + cell * index),
          Offset(surface.right, surface.top + cell * index), groove);
    }
    for (var y = 0; y < board.size; y++) {
      for (var x = 0; x < board.size; x++) {
        final piece = board.getPieceAtLocation(x, y);
        if (piece == PieceType.empty) continue;
        final center = Offset(
            surface.left + cell * (x + 0.5), surface.top + cell * (y + 0.5));
        final disc = Rect.fromCircle(center: center, radius: cell * 0.37);
        canvas.drawCircle(
            center,
            cell * 0.37,
            Paint()
              ..shader = palette.pieceGradients[piece]!.createShader(disc));
      }
    }
  }

  @override
  bool shouldRepaint(_MatchThumbnailPainter oldDelegate) =>
      board != oldDelegate.board || palette != oldDelegate.palette;
}

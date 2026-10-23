import 'package:flutter/material.dart';

import 'accessible_board.dart';
import 'app_chrome.dart';
import 'feedback_service.dart';
import 'game_board.dart';
import 'game_model.dart';
import 'game_settings.dart';
import 'gameplay_activity.dart';
import 'generated/l10n.dart';
import 'result_card.dart';
import 'strategy_coach.dart';
import 'strategy_practice_screen.dart';
import 'theme_controller.dart';

/// An immutable chronology, including the opening and the completed board.
/// Review always opens on the final position so the result is easy to inspect.
class GameReviewScreen extends StatefulWidget {
  GameReviewScreen({
    super.key,
    required List<GameModel> history,
    this.settings,
    this.playedAt,
    this.positionAnalyzer = StrategyCoach.analyze,
  })  : assert(history.isNotEmpty),
        history = List.unmodifiable(history);

  final List<GameModel> history;
  final GameSettings? settings;
  final DateTime? playedAt;
  final Future<StrategyAdvice?> Function(GameModel) positionAnalyzer;

  @override
  State<GameReviewScreen> createState() => _GameReviewScreenState();
}

class _GameReviewScreenState extends State<GameReviewScreen> {
  late int _index;
  int _adviceGeneration = 0;
  int _historyGeneration = 0;
  StrategyAdvice? _advice;
  StrategyTurningPoint? _turningPoint;
  bool _loadingAdvice = false;
  bool _loadingHistory = true;
  bool _adviceFailed = false;
  bool _historyFailed = false;

  @override
  void initState() {
    super.initState();
    _index = widget.history.length - 1;
    GameplayActivity.begin(this);
    _analyzeHistory();
  }

  @override
  void dispose() {
    _adviceGeneration++;
    _historyGeneration++;
    GameplayActivity.end(this);
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant GameReviewScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.history.length != widget.history.length ||
        !identical(oldWidget.history.last.board, widget.history.last.board) ||
        oldWidget.settings != widget.settings) {
      _index = widget.history.length - 1;
      _adviceGeneration++;
      _advice = null;
      _analyzeHistory();
    }
  }

  void _analyzeHistory() {
    final generation = ++_historyGeneration;
    _turningPoint = null;
    _loadingHistory = true;
    _historyFailed = false;
    final settings = widget.settings;
    StrategyCoach.findTurningPoint(
      widget.history,
      player: settings != null && !settings.twoPlayerMode
          ? settings.humanColor
          : null,
    ).then((point) {
      if (!mounted || generation != _historyGeneration) return;
      setState(() {
        _turningPoint = point;
        _loadingHistory = false;
      });
    }).catchError((Object error) {
      if (!mounted || generation != _historyGeneration) return;
      setState(() {
        _historyFailed = true;
        _loadingHistory = false;
      });
    });
  }

  Position? _moveAt(int index) {
    if (index == 0) return null;
    final before = widget.history[index - 1].board;
    final after = widget.history[index].board;
    for (var y = 0; y < after.size; y++) {
      for (var x = 0; x < after.size; x++) {
        if (before.getPieceAtLocation(x, y) == PieceType.empty &&
            after.getPieceAtLocation(x, y) != PieceType.empty) {
          return Position(x, y);
        }
      }
    }
    return null;
  }

  int _cornerCount(GameBoard board, PieceType piece) {
    final end = board.size - 1;
    return [
      board.getPieceAtLocation(0, 0),
      board.getPieceAtLocation(end, 0),
      board.getPieceAtLocation(0, end),
      board.getPieceAtLocation(end, end),
    ].where((corner) => corner == piece).length;
  }

  void _goTo(int index, {bool requestAdvice = true}) {
    final nextIndex = index.clamp(0, widget.history.length - 1);
    final generation = ++_adviceGeneration;
    setState(() {
      _index = nextIndex;
      _advice = null;
      _adviceFailed = false;
      _loadingAdvice = nextIndex < widget.history.length - 1;
    });
    if (!_loadingAdvice || !requestAdvice) return;
    Future<StrategyAdvice?>.sync(
            () => widget.positionAnalyzer(widget.history[nextIndex]))
        .then((advice) {
      if (!mounted || generation != _adviceGeneration) return;
      setState(() {
        _advice = advice;
        _loadingAdvice = false;
      });
    }).catchError((Object error) {
      if (!mounted || generation != _adviceGeneration) return;
      setState(() {
        _adviceFailed = true;
        _loadingAdvice = false;
      });
    });
  }

  Widget _coachCard(S s) {
    final finalPosition = _index == widget.history.length - 1;
    final point = _turningPoint;
    final advice = finalPosition ? point?.advice : _advice;
    final loading = finalPosition ? _loadingHistory : _loadingAdvice;
    final failed = finalPosition ? _historyFailed : _adviceFailed;
    final sourceIndex = finalPosition ? point?.index : _index;
    final transition = FeedbackService.instance.reduceMotion ||
            MediaQuery.disableAnimationsOf(context)
        ? Duration.zero
        : const Duration(milliseconds: 200);
    return Semantics(
      container: true,
      liveRegion: true,
      child: AppInfoCard(
        key: const ValueKey('coach-card'),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(s.CoachTitle, style: AppChrome.titleStyle),
            const SizedBox(height: 12),
            if (loading)
              Text(s.CoachAnalyzing, style: AppChrome.bodyStyle)
            else if (failed)
              Text(s.CoachUnavailable, style: AppChrome.bodyStyle)
            else if (advice == null || sourceIndex == null)
              Text(s.CoachNoPosition, style: AppChrome.bodyStyle)
            else ...[
              Text(finalPosition ? s.CoachTurnTitle : s.CoachPositionTitle,
                  style: AppChrome.bodyStyle
                      .copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Text(
                  s.CoachForPlayer(
                      advice.player == PieceType.black ? s.Black : s.White),
                  style: AppChrome.bodyStyle),
              const SizedBox(height: 12),
              Text(
                finalPosition && point != null
                    ? point.offersAlternative
                        ? s.CoachComparison(
                            StrategyCoach.coordinate(point.actualMove),
                            StrategyCoach.coordinate(advice.move))
                        : s.CoachMatched(StrategyCoach.coordinate(advice.move))
                    : s.CoachSuggested(StrategyCoach.coordinate(advice.move)),
                style:
                    AppChrome.bodyStyle.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              Text(strategyExplanation(s, advice), style: AppChrome.bodyStyle),
              const SizedBox(height: 16),
              if (finalPosition)
                OutlinedButton(
                  key: const ValueKey('coach-jump'),
                  onPressed: () => _goTo(sourceIndex),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Text(s.CoachJump, textAlign: TextAlign.center)),
                ),
              const SizedBox(height: 8),
              ElevatedButton(
                key: const ValueKey('coach-practice'),
                style: appPrimaryButtonStyle(),
                onPressed: () =>
                    Navigator.of(context).push(PageRouteBuilder<void>(
                  transitionDuration: transition,
                  reverseTransitionDuration: transition,
                  pageBuilder: (_, animation, secondaryAnimation) =>
                      StrategyPracticeScreen(
                          position: widget.history[sourceIndex]),
                  transitionsBuilder:
                      (_, animation, secondaryAnimation, child) =>
                          FadeTransition(opacity: animation, child: child),
                )),
                child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text(s.CoachPractice, textAlign: TextAlign.center)),
              ),
              const SizedBox(height: 16),
              Text(s.CoachScope,
                  style: AppChrome.bodyStyle.copyWith(fontSize: 13)),
            ],
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final palette = ThemeController.instance.theme;
    final model = widget.history[_index];
    final total = widget.history.length - 1;
    final moveLabel = s.ReviewMove(_index, total);
    final positionLabel = _index == 0
        ? s.ReviewStart
        : _index == total
            ? s.ReviewFinal
            : moveLabel;
    final controls = AppInfoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Semantics(
            liveRegion: true,
            child: Column(
              children: [
                Text(
                  positionLabel,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppChrome.primaryText,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (positionLabel != moveLabel) ...[
                  const SizedBox(height: 6),
                  Text(
                    moveLabel,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppChrome.secondaryText,
                      fontSize: 14,
                    ),
                  ),
                ],
                const SizedBox(height: 18),
                Wrap(
                  spacing: 32,
                  runSpacing: 12,
                  alignment: WrapAlignment.center,
                  children: [
                    _ReviewScore(
                      label: s.Black,
                      value: model.blackScore,
                      color: Colors.black,
                    ),
                    _ReviewScore(
                      label: s.White,
                      value: model.whiteScore,
                      color: Colors.white,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Slider(
            key: const ValueKey('review-slider'),
            value: _index.toDouble(),
            min: 0,
            max: total > 0 ? total.toDouble() : 1,
            divisions: total > 0 ? total : null,
            label: moveLabel,
            semanticFormatterCallback: (value) =>
                s.ReviewMove(value.round(), total),
            activeColor: palette.lastMoveBorder,
            inactiveColor: AppChrome.borderColor,
            // Repaint while scrubbing; start one analysis on release rather
            // than spawning an isolate for every intermediate slider value.
            onChanged: total == 0
                ? null
                : (value) => _goTo(value.round(), requestAdvice: false),
            onChangeEnd: total == 0 ? null : (value) => _goTo(value.round()),
          ),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: [
              _ReviewControl(
                key: const ValueKey('review-first'),
                label: s.ReviewFirst,
                icon: Icons.first_page_rounded,
                onPressed: _index > 0 ? () => _goTo(0) : null,
              ),
              _ReviewControl(
                key: const ValueKey('review-previous'),
                label: s.ReviewPrevious,
                icon: Icons.chevron_left_rounded,
                onPressed: _index > 0 ? () => _goTo(_index - 1) : null,
              ),
              _ReviewControl(
                key: const ValueKey('review-next'),
                label: s.ReviewNext,
                icon: Icons.chevron_right_rounded,
                onPressed: _index < total ? () => _goTo(_index + 1) : null,
              ),
              _ReviewControl(
                key: const ValueKey('review-last'),
                label: s.ReviewLast,
                icon: Icons.last_page_rounded,
                onPressed: _index < total ? () => _goTo(total) : null,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            s.ReviewCorners(
              _cornerCount(model.board, PieceType.black),
              _cornerCount(model.board, PieceType.white),
            ),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              height: 1.5,
              color: AppChrome.secondaryText,
            ),
          ),
        ],
      ),
    );
    final board = AccessibleBoard(
      board: model.board,
      showCoordinates: true,
      lastMove: _moveAt(_index),
      label: s.ReviewBoardLabel,
    );
    final sidePanel = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        controls,
        if (widget.settings != null) ...[
          const SizedBox(height: 16),
          OutlinedButton.icon(
            key: const ValueKey('review-share-result'),
            onPressed: () => showResultCard(
              context,
              model: widget.history.last,
              settings: widget.settings!,
              playedAt: widget.playedAt,
              theme: ThemeController.instance.theme,
            ),
            icon: const Icon(Icons.ios_share_rounded),
            label: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(s.CoachShareResult, textAlign: TextAlign.center)),
          ),
        ],
        const SizedBox(height: 24),
        _coachCard(s),
      ],
    );
    return AppGradientScaffold(
      title: s.ReviewGame,
      maxContentWidth: 1000,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
            child: constraints.maxWidth >= 700
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 6, child: board),
                      const SizedBox(width: 24),
                      Expanded(flex: 5, child: sidePanel),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(child: board),
                      const SizedBox(height: 24),
                      sidePanel,
                    ],
                  ),
          );
        },
      ),
    );
  }
}

class _ReviewScore extends StatelessWidget {
  const _ReviewScore({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final int value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '$label, $value',
      child: ExcludeSemantics(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 13,
                  height: 13,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppChrome.secondaryText),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: const TextStyle(
                    color: AppChrome.secondaryText,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              '$value',
              style: const TextStyle(
                color: AppChrome.primaryText,
                fontSize: 32,
                fontWeight: FontWeight.w700,
                height: 1.1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReviewControl extends StatelessWidget {
  const _ReviewControl({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton.outlined(
      tooltip: label,
      onPressed: onPressed,
      style: IconButton.styleFrom(
        foregroundColor: AppChrome.primaryText,
        disabledForegroundColor: AppChrome.primaryText.withAlpha(90),
        minimumSize: const Size(48, 48),
        side: const BorderSide(color: AppChrome.borderColor),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      icon: Icon(icon, size: 27),
    );
  }
}

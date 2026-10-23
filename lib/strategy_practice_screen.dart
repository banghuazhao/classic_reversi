import 'package:flutter/material.dart';

import 'accessible_board.dart';
import 'app_chrome.dart';
import 'game_board.dart';
import 'game_model.dart';
import 'gameplay_activity.dart';
import 'generated/l10n.dart';
import 'strategy_coach.dart';

String strategyExplanation(S s, StrategyAdvice advice) => advice.reasons
    .map((reason) => switch (reason) {
          StrategyReason.corner => s.CoachCorner,
          StrategyReason.forcesPass => s.CoachPass,
          StrategyReason.replies => s.CoachReplies(advice.opponentReplies),
          StrategyReason.avoidsCorner => s.CoachAvoidCorner,
          StrategyReason.allowsCorner => s.CoachAllowsCorner,
          StrategyReason.endsGame => s.CoachEndsGame,
        })
    .join('\n\n');

/// A sandbox: it owns only in-memory boards and never writes a match, result,
/// statistic, achievement, or preference.
class StrategyPracticeScreen extends StatefulWidget {
  const StrategyPracticeScreen({super.key, required this.position});

  final GameModel position;

  @override
  State<StrategyPracticeScreen> createState() => _StrategyPracticeScreenState();
}

class _StrategyPracticeScreenState extends State<StrategyPracticeScreen> {
  late GameModel _model;
  Position? _played;
  StrategyAdvice? _advice;
  bool _loading = true;
  bool _failed = false;
  int _generation = 0;

  @override
  void initState() {
    super.initState();
    GameplayActivity.begin(this);
    _model = widget.position;
    _analyze();
  }

  @override
  void dispose() {
    _generation++;
    GameplayActivity.end(this);
    super.dispose();
  }

  void _analyze({Position? played}) {
    final generation = ++_generation;
    _loading = true;
    _failed = false;
    _advice = null;
    StrategyCoach.analyze(widget.position, chosenMove: played).then((advice) {
      if (!mounted || generation != _generation) return;
      setState(() {
        _advice = advice;
        _loading = false;
      });
    }).catchError((Object error) {
      if (!mounted || generation != _generation) return;
      setState(() {
        _loading = false;
        _failed = true;
      });
    });
  }

  void _play(int x, int y) {
    if (_played != null) return;
    final next = _model.updateForMove(x, y);
    if (next == null) return;
    setState(() {
      _played = Position(x, y);
      _model = next;
      _analyze(played: _played);
    });
  }

  void _reset() {
    setState(() {
      _played = null;
      _model = widget.position;
      _analyze();
    });
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final legal = _played == null
        ? _model.board.getMovesForPlayer(_model.player)
        : <Position>[];
    final details = AppInfoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Semantics(
            liveRegion: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    _played == null
                        ? s.CoachTitle
                        : s.PracticePlayed(StrategyCoach.coordinate(_played!)),
                    style: AppChrome.titleStyle),
                const SizedBox(height: 12),
                if (_played != null)
                  Text(
                      s.PracticeFlipped(GameBoard.flippedPositions(
                              widget.position.board, _model.board, _played!)
                          .length),
                      style: AppChrome.bodyStyle),
                if (_played != null) const SizedBox(height: 12),
                if (_loading)
                  Text(s.CoachAnalyzing, style: AppChrome.bodyStyle)
                else if (_failed)
                  Text(s.CoachUnavailable, style: AppChrome.bodyStyle)
                else if (_advice != null) ...[
                  if (_played == null) ...[
                    Text(
                        s.CoachSuggested(
                            StrategyCoach.coordinate(_advice!.move)),
                        style: AppChrome.bodyStyle),
                    const SizedBox(height: 12),
                  ],
                  Text(strategyExplanation(s, _advice!),
                      style: AppChrome.bodyStyle),
                ] else
                  Text(s.PracticeNoMoves, style: AppChrome.bodyStyle),
              ],
            ),
          ),
          if (_played != null) ...[
            const SizedBox(height: 20),
            ElevatedButton(
              key: const ValueKey('practice-reset'),
              style: appPrimaryButtonStyle(),
              onPressed: _reset,
              child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(s.PracticeReset, textAlign: TextAlign.center)),
            ),
          ],
          const SizedBox(height: 20),
          Text(s.PracticeSafe,
              style: AppChrome.bodyStyle.copyWith(fontSize: 13)),
        ],
      ),
    );
    final board = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          _played == null
              ? s.PracticeInstructions
              : s.PracticePlayed(StrategyCoach.coordinate(_played!)),
          style: AppChrome.bodyStyle,
        ),
        const SizedBox(height: 16),
        AccessibleBoard(
          board: _model.board,
          showCoordinates: true,
          label: s.PracticeBoardLabel,
          legalMoves: legal,
          onMove: _played == null && legal.isNotEmpty ? _play : null,
          lastMove: _played,
        ),
        const SizedBox(height: 16),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 24,
          runSpacing: 8,
          children: [
            Text('${s.Black} ${_model.blackScore}', style: AppChrome.bodyStyle),
            Text('${s.White} ${_model.whiteScore}', style: AppChrome.bodyStyle)
          ],
        ),
      ],
    );
    return AppGradientScaffold(
      title: s.PracticeTitle,
      maxContentWidth: 1000,
      child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
                child: constraints.maxWidth >= 700
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            Expanded(flex: 6, child: board),
                            const SizedBox(width: 24),
                            Expanded(flex: 5, child: details)
                          ])
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [board, const SizedBox(height: 24), details]),
              )),
    );
  }
}

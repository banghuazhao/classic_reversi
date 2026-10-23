import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'accessible_board.dart';
import 'app_chrome.dart';
import 'feedback_service.dart';
import 'game_board.dart';
import 'game_model.dart';
import 'gameplay_activity.dart';
import 'generated/l10n.dart';
import 'main.dart';
import 'puzzle_progress.dart';
import 'puzzles.dart';
import 'theme_controller.dart';

/// Isolated practice. No ordinary game session, match statistics, or game
/// history is read or written by an exercise.
class PuzzleScreen extends StatefulWidget {
  const PuzzleScreen({super.key, required this.puzzle});

  final ReversiPuzzle puzzle;

  @override
  State<PuzzleScreen> createState() => _PuzzleScreenState();
}

class _PuzzleScreenState extends State<PuzzleScreen> {
  late GameModel _model;
  final _solver = ExactEndgameSolver();
  Position? _lastMove;
  bool _solved = false;
  bool _failed = false;
  bool _busy = false;
  bool _completionSaved = false;
  bool _saveFailed = false;
  int _hints = 0;
  int _generation = 0;

  @override
  void initState() {
    super.initState();
    _model = widget.puzzle.initialModel;
    GameplayActivity.begin(this);
  }

  @override
  void dispose() {
    _generation++;
    GameplayActivity.end(this);
    super.dispose();
  }

  void _restart() {
    _generation++;
    setState(() {
      _model = widget.puzzle.initialModel;
      _lastMove = null;
      _solved = false;
      _failed = false;
      _busy = false;
      _completionSaved = false;
      _saveFailed = false;
      _hints = 0;
    });
  }

  void _play(int x, int y) {
    if (_busy || _solved || _failed || _model.player != widget.puzzle.player) {
      return;
    }
    final next = _model.updateForMove(x, y);
    if (next == null) return;
    final move = Position(x, y);
    setState(() {
      _model = next;
      _lastMove = move;
      _hints = 0;
    });
    if (widget.puzzle.skill != PuzzleSkill.endgame) {
      if (widget.puzzle.solvesObjective(move)) {
        _complete();
      } else {
        setState(() => _failed = true);
      }
      return;
    }
    if (_solver.score(next, widget.puzzle.player) <= 0) {
      setState(() => _failed = true);
      return;
    }
    if (next.gameIsOver) {
      _complete();
      return;
    }
    if (next.player != widget.puzzle.player) {
      setState(() => _busy = true);
      unawaited(_advanceOpponent(++_generation));
    }
  }

  Future<void> _advanceOpponent(int generation) async {
    bool current() => mounted && generation == _generation;
    final reduced = FeedbackService.instance.reduceMotion ||
        MediaQuery.disableAnimationsOf(context);
    while (current() &&
        !_model.gameIsOver &&
        _model.player != widget.puzzle.player) {
      await Future<void>.delayed(
        reduced ? Duration.zero : const Duration(milliseconds: 220),
      );
      if (!current()) return;
      final reply = _solver.bestMove(_model, widget.puzzle.player);
      if (reply == null) break;
      final next = _model.updateForMove(reply.x, reply.y)!;
      setState(() {
        _model = next;
        _lastMove = reply;
      });
    }
    if (!current()) return;
    setState(() => _busy = false);
    if (_model.gameIsOver) {
      if (_solver.score(_model, widget.puzzle.player) > 0) {
        _complete();
      } else {
        setState(() => _failed = true);
      }
    }
  }

  void _complete() {
    setState(() => _solved = true);
    unawaited(_saveCompletion());
  }

  Future<void> _saveCompletion() async {
    setState(() => _saveFailed = false);
    try {
      await PuzzleProgressService.complete(widget.puzzle.id);
      if (mounted) setState(() => _completionSaved = true);
    } catch (error) {
      debugPrint('Saving puzzle completion failed: $error');
      if (mounted) setState(() => _saveFailed = true);
    }
  }

  String _objective(S s) {
    final color = widget.puzzle.player == PieceType.black ? s.Black : s.White;
    return switch (widget.puzzle.skill) {
      PuzzleSkill.corner =>
        s.PuzzleCornerObjective(color, widget.puzzle.targetCorner!),
      PuzzleSkill.forcedPass => s.PuzzlePassObjective(color),
      PuzzleSkill.endgame => s.PuzzleEndgameObjective(color),
    };
  }

  String _success(S s) => switch (widget.puzzle.skill) {
        PuzzleSkill.corner => s.PuzzleCornerSuccess,
        PuzzleSkill.forcedPass => s.PuzzlePassSuccess,
        PuzzleSkill.endgame => s.PuzzleEndgameSuccess,
      };

  String _hint(S s, int level) {
    if (level == 3) {
      final move = widget.puzzle.skill == PuzzleSkill.endgame
          ? _solver.bestMove(_model, widget.puzzle.player)
          : widget.puzzle.solutions.first;
      return s.PuzzleHintCoordinate(puzzleCoordinate(move!));
    }
    return switch (widget.puzzle.skill) {
      PuzzleSkill.corner =>
        level == 1 ? s.PuzzleCornerHintOne : s.PuzzleCornerHintTwo,
      PuzzleSkill.forcedPass =>
        level == 1 ? s.PuzzlePassHintOne : s.PuzzlePassHintTwo,
      PuzzleSkill.endgame =>
        level == 1 ? s.PuzzleEndgameHintOne : s.PuzzleEndgameHintTwo,
    };
  }

  void _next() {
    final index = curatedPuzzles.indexWhere((p) => p.id == widget.puzzle.id);
    if (index < 0 || index + 1 == curatedPuzzles.length) {
      Navigator.of(context).pop();
      return;
    }
    Navigator.of(context).pushReplacement(
      fadeRoute((context) => PuzzleScreen(puzzle: curatedPuzzles[index + 1])),
    );
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final canPlay =
        !_solved && !_failed && !_busy && _model.player == widget.puzzle.player;
    return ListenableBuilder(
      listenable: ThemeController.instance,
      builder: (context, _) {
        final palette = ThemeController.instance.theme;
        final board = LayoutBuilder(
          builder: (context, constraints) {
            final extent = math.min(constraints.maxWidth, 484.0);
            final boardExtent = extent - 24;
            final cellExtent = (boardExtent - 20) / _model.board.size;
            Widget coordinate(String value) => ExcludeSemantics(
                  child: Text(value,
                      textScaler: TextScaler.noScaling,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppChrome.secondaryText,
                      )),
                );
            return Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: extent,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 34, right: 10),
                      child: Row(
                        children: List.generate(
                            _model.board.size,
                            (x) => Expanded(
                                child: Center(
                                    child: coordinate(
                                        String.fromCharCode(65 + x))))),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 24,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Column(
                              children: List.generate(
                                  _model.board.size,
                                  (y) => SizedBox(
                                      height: cellExtent,
                                      child: Center(
                                          child: coordinate('${y + 1}')))),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: boardExtent,
                          child: AccessibleBoard(
                            key: const ValueKey('puzzle-board'),
                            board: _model.board,
                            label: s.PuzzleBoardLabel,
                            legalMoves: canPlay
                                ? _model.board.getMovesForPlayer(_model.player)
                                : const [],
                            onMove: canPlay ? _play : null,
                            lastMove: _lastMove,
                            maxExtent: boardExtent,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
        final information = Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppInfoCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Semantics(
                    liveRegion: true,
                    child: Text(
                      _solved
                          ? _success(s)
                          : _failed
                              ? widget.puzzle.skill == PuzzleSkill.endgame
                                  ? s.PuzzleEndgameTryAgain
                                  : s.PuzzleTryAgain
                              : _busy
                                  ? s.PuzzleOpponentThinking
                                  : s.PuzzleYourMove,
                      key: const ValueKey('puzzle-status'),
                      style: AppChrome.actionStyle.copyWith(
                        color: _solved || _failed
                            ? palette.lastMoveBorder
                            : AppChrome.primaryText,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (_hints > 0) ...[
              const SizedBox(height: 16),
              AppInfoCard(
                child: Semantics(
                  liveRegion: true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      for (var level = 1; level <= _hints; level++) ...[
                        Text(s.PuzzleHint(level),
                            style: AppChrome.actionStyle
                                .copyWith(color: AppChrome.primaryText)),
                        const SizedBox(height: 8),
                        Text(_hint(s, level), style: AppChrome.bodyStyle),
                        if (level < _hints) const SizedBox(height: 16),
                      ],
                    ],
                  ),
                ),
              ),
            ],
            const SizedBox(height: 16),
            if (!_solved && !_failed)
              OutlinedButton.icon(
                key: const ValueKey('puzzle-hint'),
                onPressed: !_busy && _hints < 3
                    ? () => setState(() => _hints++)
                    : null,
                icon: const Icon(CupertinoIcons.lightbulb),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppChrome.primaryText,
                  disabledForegroundColor: AppChrome.secondaryText,
                  side: const BorderSide(color: AppChrome.borderColor),
                  minimumSize: const Size(48, 48),
                  padding: const EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                label: Text(s.PuzzleRevealHint, textAlign: TextAlign.center),
              ),
            if (_saveFailed) ...[
              Text(s.PuzzleCompletionSaveFailed, style: AppChrome.bodyStyle),
              TextButton(
                onPressed: _saveCompletion,
                child: Text(s.PuzzleSaveProgress),
              ),
            ],
            if (_solved) ...[
              ElevatedButton(
                key: const ValueKey('puzzle-next'),
                onPressed: _completionSaved ? _next : null,
                style: appPrimaryButtonStyle(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    widget.puzzle.id == curatedPuzzles.last.id
                        ? s.PuzzleBackToArchive
                        : s.PuzzleNext,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],
            TextButton.icon(
              key: const ValueKey('puzzle-restart'),
              onPressed: _restart,
              style: TextButton.styleFrom(
                foregroundColor: AppChrome.primaryText,
                minimumSize: const Size(48, 48),
                padding: const EdgeInsets.all(16),
              ),
              icon: const Icon(CupertinoIcons.arrow_counterclockwise),
              label: Text(s.PuzzleRestart, textAlign: TextAlign.center),
            ),
          ],
        );
        return AppGradientScaffold(
          title: s.PuzzleNumber(widget.puzzle.number),
          maxContentWidth: 1000,
          child: LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
              child: constraints.maxWidth >= 760
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 6, child: board),
                        const SizedBox(width: 24),
                        Expanded(
                          flex: 5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(_objective(s),
                                  key: const ValueKey('puzzle-objective'),
                                  style: AppChrome.bodyStyle),
                              const SizedBox(height: 16),
                              information,
                            ],
                          ),
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(_objective(s),
                            key: const ValueKey('puzzle-objective'),
                            style: AppChrome.bodyStyle),
                        const SizedBox(height: 16),
                        board,
                        const SizedBox(height: 24),
                        information,
                      ],
                    ),
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';

import 'accessible_board.dart';
import 'app_chrome.dart';
import 'game_board.dart';
import 'game_model.dart';
import 'gameplay_activity.dart';
import 'generated/l10n.dart';
import 'theme_controller.dart';

/// Three hands-on lessons. Returning true starts the player's first Easy game.
class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key, this.offerEasyGame = true});

  final bool offerEasyGame;

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

enum _LessonStage {
  firstCapture,
  captureExplained,
  replyCapture,
  replyExplained,
  cornerCapture,
  complete,
}

class _TutorialScreenState extends State<TutorialScreen> {
  _LessonStage _stage = _LessonStage.firstCapture;
  GameModel _model = GameModel.initial(boardSize: GameBoard.compactSize);
  Position? _lastMove;

  @override
  void initState() {
    super.initState();
    GameplayActivity.begin(this);
  }

  @override
  void dispose() {
    GameplayActivity.end(this);
    super.dispose();
  }

  bool get _waitingForMove => switch (_stage) {
        _LessonStage.firstCapture ||
        _LessonStage.replyCapture ||
        _LessonStage.cornerCapture =>
          true,
        _ => false,
      };

  int get _lesson => switch (_stage) {
        _LessonStage.firstCapture || _LessonStage.captureExplained => 1,
        _LessonStage.replyCapture || _LessonStage.replyExplained => 2,
        _LessonStage.cornerCapture || _LessonStage.complete => 3,
      };

  void _play(int x, int y) {
    if (!_waitingForMove ||
        (_stage == _LessonStage.cornerCapture && (x != 0 || y != 0))) {
      return;
    }
    final next = _model.updateForMove(x, y);
    if (next == null) return;
    setState(() {
      _model = next;
      _lastMove = Position(x, y);
      _stage = switch (_stage) {
        _LessonStage.firstCapture => _LessonStage.captureExplained,
        _LessonStage.replyCapture => _LessonStage.replyExplained,
        _LessonStage.cornerCapture => _LessonStage.complete,
        _ => _stage,
      };
    });
  }

  void _continue() {
    if (_stage == _LessonStage.captureExplained) {
      // A deterministic legal response shows the turn sequence without a
      // timer or asynchronous opponent work that could outlive this screen.
      final reply = _model.board.getMovesForPlayer(_model.player).first;
      setState(() {
        _model = _model.updateForMove(reply.x, reply.y)!;
        _lastMove = reply;
        _stage = _LessonStage.replyCapture;
      });
    } else if (_stage == _LessonStage.replyExplained) {
      setState(() {
        _model = GameModel(board: _cornerPractice());
        _lastMove = null;
        _stage = _LessonStage.cornerCapture;
      });
    }
  }

  GameBoard _cornerPractice() {
    const e = PieceType.empty;
    const b = PieceType.black;
    const w = PieceType.white;
    return GameBoard.fromRows(const [
      [e, w, b, e, e, e],
      [w, w, b, w, e, e],
      [b, w, w, b, e, e],
      [e, b, w, b, e, e],
      [e, e, e, e, e, e],
      [e, e, e, e, e, e],
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final palette = ThemeController.instance.theme;
    final title = switch (_stage) {
      _LessonStage.firstCapture => s.TutorialCaptureTitle,
      _LessonStage.captureExplained => s.TutorialCaptureDoneTitle,
      _LessonStage.replyCapture => s.HowToTurnsTitle,
      _LessonStage.replyExplained => s.TutorialCaptureDoneTitle,
      _LessonStage.cornerCapture => s.TutorialCornersTitle,
      _LessonStage.complete => s.TutorialCompleteTitle,
    };
    final body = switch (_stage) {
      _LessonStage.firstCapture => s.TutorialCaptureBody,
      _LessonStage.captureExplained => s.TutorialCaptureDoneBody,
      _LessonStage.replyCapture => s.TutorialReplyBody,
      _LessonStage.replyExplained => s.TutorialReplyDoneBody,
      _LessonStage.cornerCapture => s.TutorialCornersBody,
      _LessonStage.complete => s.TutorialCompleteBody,
    };
    final availableMoves = !_waitingForMove
        ? <Position>[]
        : _stage == _LessonStage.cornerCapture
            ? const [Position(0, 0)]
            : _model.board.getMovesForPlayer(_model.player);

    return AppGradientScaffold(
      title: s.TutorialTitle,
      maxContentWidth: 1000,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final wide = constraints.maxWidth >= 640;
          final instructions = Semantics(
            liveRegion: true,
            child: AppInfoCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    s.TutorialProgress(_lesson, 3),
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: palette.lastMoveBorder,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: _stage == _LessonStage.complete
                          ? 1
                          : (_lesson - 1) / 3,
                      backgroundColor: AppChrome.borderColor,
                      color: palette.lastMoveBorder,
                      minHeight: 3,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: AppChrome.primaryText,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    body,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.5,
                      color: AppChrome.secondaryText,
                    ),
                  ),
                ],
              ),
            ),
          );
          final board = Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AccessibleBoard(
                board: _model.board,
                label: s.TutorialBoardLabel,
                legalMoves: availableMoves,
                lastMove: _lastMove,
                onMove: _waitingForMove ? _play : null,
                maxExtent: wide ? 460 : 390,
              ),
              const SizedBox(height: 14),
              Wrap(
                spacing: 28,
                runSpacing: 8,
                alignment: WrapAlignment.center,
                children: [
                  Text(
                    '${s.Black}  ${_model.blackScore}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppChrome.primaryText,
                    ),
                  ),
                  Text(
                    '${s.White}  ${_model.whiteScore}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppChrome.primaryText,
                    ),
                  ),
                ],
              ),
            ],
          );
          final actions = Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (!_waitingForMove)
                ElevatedButton(
                  key: const ValueKey('tutorial-continue'),
                  style: appPrimaryButtonStyle(palette),
                  onPressed: _stage == _LessonStage.complete
                      ? () => Navigator.of(context).pop(true)
                      : _continue,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      _stage == _LessonStage.complete
                          ? widget.offerEasyGame
                              ? s.TutorialPlayEasy
                              : MaterialLocalizations.of(context).okButtonLabel
                          : s.TutorialNext,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              const SizedBox(height: 6),
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                style: TextButton.styleFrom(
                  foregroundColor: AppChrome.secondaryText,
                  minimumSize: const Size(48, 48),
                ),
                child: Text(s.TutorialSkip, textAlign: TextAlign.center),
              ),
            ],
          );
          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
            child: wide
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: board),
                      const SizedBox(width: 24),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            instructions,
                            const SizedBox(height: 20),
                            actions,
                          ],
                        ),
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      instructions,
                      const SizedBox(height: 22),
                      Center(child: board),
                      const SizedBox(height: 20),
                      actions,
                    ],
                  ),
          );
        },
      ),
    );
  }
}

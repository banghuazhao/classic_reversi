import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/services.dart';

import 'feedback_service.dart';
import 'flip_piece.dart';
import 'game_board.dart';
import 'game_materials.dart';
import 'generated/l10n.dart';
import 'theme_controller.dart';

/// A shared board for guided practice and replay. One keyboard stop keeps
/// every cell reachable with arrows without trapping Tab navigation in a grid.
class AccessibleBoard extends StatefulWidget {
  const AccessibleBoard({
    super.key,
    required this.board,
    required this.label,
    this.legalMoves = const [],
    this.onMove,
    this.lastMove,
    this.maxExtent = 460,
  });

  final GameBoard board;
  final String label;
  final List<Position> legalMoves;
  final void Function(int x, int y)? onMove;
  final Position? lastMove;
  final double maxExtent;

  @override
  State<AccessibleBoard> createState() => _AccessibleBoardState();
}

class _AccessibleBoardState extends State<AccessibleBoard> {
  final _focus = FocusNode(debugLabel: 'Practice and review board');
  late Position _selected;
  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();
    _selected = widget.legalMoves.firstOrNull ??
        widget.lastMove ??
        const Position(0, 0);
  }

  @override
  void didUpdateWidget(covariant AccessibleBoard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.board.size != widget.board.size) {
      _selected = const Position(0, 0);
    }
  }

  @override
  void dispose() {
    _focus.dispose();
    super.dispose();
  }

  bool _isLegal(int x, int y) =>
      widget.onMove != null &&
      widget.legalMoves.any((move) => move.x == x && move.y == y);

  void _activate(int x, int y) {
    if (_isLegal(x, y)) {
      widget.onMove!(x, y);
    }
  }

  String _cellLabel(S s, int x, int y) {
    final piece = widget.board.getPieceAtLocation(x, y);
    final description = switch (piece) {
      PieceType.empty => s.BoardEmpty,
      PieceType.black => s.Black,
      PieceType.white => s.White,
    };
    final coordinate = '${String.fromCharCode(65 + x)}${y + 1}';
    return [
      s.BoardCell(coordinate, description),
      if (_isLegal(x, y)) s.BoardLegalMove,
      if (widget.lastMove?.x == x && widget.lastMove?.y == y) s.BoardLastMove,
    ].join(', ');
  }

  KeyEventResult _onKey(FocusNode node, KeyEvent event) {
    if (event is! KeyDownEvent && event is! KeyRepeatEvent) {
      return KeyEventResult.ignored;
    }
    final key = event.logicalKey;
    var x = _selected.x;
    var y = _selected.y;
    if (key == LogicalKeyboardKey.arrowLeft) {
      x--;
    } else if (key == LogicalKeyboardKey.arrowRight) {
      x++;
    } else if (key == LogicalKeyboardKey.arrowUp) {
      y--;
    } else if (key == LogicalKeyboardKey.arrowDown) {
      y++;
    } else if (key == LogicalKeyboardKey.enter ||
        key == LogicalKeyboardKey.space) {
      if (event is KeyDownEvent) _activate(x, y);
      return KeyEventResult.handled;
    } else {
      return KeyEventResult.ignored;
    }
    setState(() {
      _selected = Position(
        x.clamp(0, widget.board.size - 1),
        y.clamp(0, widget.board.size - 1),
      );
    });
    return KeyEventResult.handled;
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final palette = ThemeController.instance.theme;
    final reduceMotion = FeedbackService.instance.reduceMotion ||
        MediaQuery.disableAnimationsOf(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        final extent = math.min(constraints.maxWidth, widget.maxExtent);
        final cellSize = (extent - 20) / widget.board.size;
        return Align(
          alignment: Alignment.topCenter,
          widthFactor: 1,
          heightFactor: 1,
          child: Semantics(
            container: true,
            explicitChildNodes: true,
            label: widget.label,
            focusable: true,
            focused: _hasFocus,
            liveRegion: _hasFocus,
            value: _hasFocus ? _cellLabel(s, _selected.x, _selected.y) : null,
            hint: widget.onMove == null
                ? s.BoardReviewKeyboardHint
                : s.BoardKeyboardHint,
            child: Focus(
              focusNode: _focus,
              includeSemantics: false,
              onKeyEvent: _onKey,
              onFocusChange: (value) => setState(() => _hasFocus = value),
              child: MaterialBoard(
                boardSize: widget.board.size,
                cellSize: cellSize,
                theme: palette,
                child: Column(
                  children: List.generate(widget.board.size, (y) {
                    return Row(
                      children: List.generate(widget.board.size, (x) {
                        final piece = widget.board.getPieceAtLocation(x, y);
                        final legal = _isLegal(x, y);
                        final isLastMove =
                            widget.lastMove?.x == x && widget.lastMove?.y == y;
                        final selected =
                            _hasFocus && _selected.x == x && _selected.y == y;
                        return Semantics(
                          label: _cellLabel(s, x, y),
                          button: legal,
                          selected: selected,
                          sortKey: OrdinalSortKey(
                            (y * widget.board.size + x).toDouble(),
                          ),
                          onTap: legal ? () => _activate(x, y) : null,
                          child: ExcludeSemantics(
                            child: GestureDetector(
                              key: ValueKey('accessible-cell-$x-$y'),
                              behavior: HitTestBehavior.opaque,
                              onTap: legal
                                  ? () {
                                      _selected = Position(x, y);
                                      _activate(x, y);
                                    }
                                  : null,
                              child: SizedBox.square(
                                dimension: cellSize,
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    FlipPiece(
                                      type: piece,
                                      size: cellSize,
                                      isLastMove: isLastMove,
                                      theme: palette,
                                      reduceMotion: reduceMotion,
                                      effectScale:
                                          FeedbackService.instance.effectScale,
                                    ),
                                    if (legal)
                                      Center(
                                        child: Container(
                                          width: cellSize * 0.28,
                                          height: cellSize * 0.28,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: palette.lastMoveBorder,
                                            border: Border.all(
                                              color: Colors.white,
                                              width: 1.5,
                                            ),
                                          ),
                                        ),
                                      ),
                                    if (selected)
                                      Positioned.fill(
                                        child: Container(
                                          margin: const EdgeInsets.all(2),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              4,
                                            ),
                                            border: Border.all(
                                              color: Colors.white,
                                              width: 3,
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    );
                  }),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

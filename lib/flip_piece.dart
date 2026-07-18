import 'dart:math' as math;

import 'package:flutter/widgets.dart';

import 'app_theme.dart';
import 'game_board.dart';

/// Renders a disc that flips when its [type] changes black ↔ white.
class FlipPiece extends StatefulWidget {
  final PieceType type;
  final double size;
  final bool isLastMove;
  final AppTheme theme;
  final Duration duration;

  const FlipPiece({
    super.key,
    required this.type,
    required this.size,
    required this.isLastMove,
    required this.theme,
    this.duration = const Duration(milliseconds: 300),
  });

  @override
  State<FlipPiece> createState() => _FlipPieceState();
}

class _FlipPieceState extends State<FlipPiece>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late PieceType _displayType;
  PieceType? _pendingType;
  bool _playAppear = false;

  @override
  void initState() {
    super.initState();
    _displayType = widget.type;
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..addListener(() {
        if (_controller.value >= 0.5 &&
            _pendingType != null &&
            _displayType != _pendingType) {
          setState(() {
            _displayType = _pendingType!;
          });
        }
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _pendingType = null;
          _controller.reset();
        }
      });
  }

  @override
  void didUpdateWidget(covariant FlipPiece oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.type == oldWidget.type) {
      return;
    }

    final becameEmpty = widget.type == PieceType.empty;
    final wasEmpty = oldWidget.type == PieceType.empty;
    final colorFlip =
        !wasEmpty && !becameEmpty && widget.type != oldWidget.type;

    if (colorFlip) {
      _playAppear = false;
      _pendingType = widget.type;
      _controller.forward(from: 0);
    } else if (wasEmpty && !becameEmpty) {
      // Newly placed piece: one-shot scale-in.
      _pendingType = null;
      _controller.reset();
      _playAppear = true;
      setState(() => _displayType = widget.type);
    } else {
      // Cleared (undo) or other instant change.
      _pendingType = null;
      _playAppear = false;
      _controller.reset();
      setState(() => _displayType = widget.type);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_displayType == PieceType.empty && widget.type == PieceType.empty) {
      return const SizedBox.expand();
    }

    final disc = Container(
      decoration: BoxDecoration(
        gradient: widget.theme.pieceGradients[_displayType],
        border: widget.isLastMove && _displayType != PieceType.empty
            ? Border.all(
                color: widget.theme.lastMoveBorder,
                width: math.max(widget.size * 0.08, 3),
                strokeAlign: BorderSide.strokeAlignInside,
              )
            : null,
        borderRadius: BorderRadius.all(Radius.circular(widget.size)),
      ),
    );

    if (_playAppear) {
      return TweenAnimationBuilder<double>(
        key: ValueKey('appear-${identityHashCode(this)}-$_displayType'),
        tween: Tween(begin: 0.85, end: 1.0),
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOutBack,
        onEnd: () {
          if (mounted) {
            setState(() => _playAppear = false);
          }
        },
        builder: (context, scale, child) {
          return Transform.scale(scale: scale, child: child);
        },
        child: disc,
      );
    }

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final t = _controller.isAnimating ? _controller.value : 0.0;
        final scaleX = _controller.isAnimating
            ? (t < 0.5 ? 1 - t * 2 : (t - 0.5) * 2)
            : 1.0;
        final sx = scaleX.clamp(0.05, 1.0);
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY((1 - scaleX) * math.pi * 0.5)
            ..scaleByDouble(sx, 1.0, 1.0, 1.0),
          child: child,
        );
      },
      child: disc,
    );
  }
}

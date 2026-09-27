import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'app_theme.dart';
import 'game_board.dart';

/// Renders a disc that flips when its [type] changes black ↔ white.
class FlipPiece extends StatefulWidget {
  final PieceType type;
  final double size;
  final bool isLastMove;
  final AppTheme theme;
  final Duration duration;
  final Duration delay;
  final bool reduceMotion;
  final double effectScale;

  const FlipPiece({
    super.key,
    required this.type,
    required this.size,
    required this.isLastMove,
    required this.theme,
    this.duration = const Duration(milliseconds: 300),
    this.delay = Duration.zero,
    this.reduceMotion = false,
    this.effectScale = 1,
  });

  @override
  State<FlipPiece> createState() => _FlipPieceState();
}

class _FlipPieceState extends State<FlipPiece>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late PieceType _displayType;
  PieceType? _pendingType;
  Timer? _delayTimer;
  _PieceMotion _motion = _PieceMotion.idle;

  @override
  void initState() {
    super.initState();
    _displayType = widget.type;
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..addListener(() {
        if (_motion == _PieceMotion.flip &&
            _controller.value >= 0.5 &&
            _pendingType != null &&
            _displayType != _pendingType) {
          setState(() {
            _displayType = _pendingType!;
          });
        }
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            _displayType = widget.type;
            _pendingType = null;
            _motion = _PieceMotion.idle;
          });
        }
      });
  }

  @override
  void didUpdateWidget(covariant FlipPiece oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.type == oldWidget.type) {
      return;
    }

    _delayTimer?.cancel();
    _controller.stop();

    final becameEmpty = widget.type == PieceType.empty;
    final wasEmpty = oldWidget.type == PieceType.empty;
    final colorFlip =
        !wasEmpty && !becameEmpty && widget.type != oldWidget.type;

    if (widget.reduceMotion ||
        (MediaQuery.maybeOf(context)?.disableAnimations ?? false)) {
      _pendingType = null;
      _motion = _PieceMotion.idle;
      _controller.reset();
      setState(() => _displayType = widget.type);
    } else if (colorFlip) {
      _pendingType = widget.type;
      _motion = _PieceMotion.flip;
      _startAfterDelay(widget.duration);
    } else if (wasEmpty && !becameEmpty) {
      _pendingType = null;
      _motion = _PieceMotion.appear;
      setState(() => _displayType = widget.type);
      _startAfterDelay(const Duration(milliseconds: 270));
    } else {
      // Cleared (undo) or other instant change.
      _pendingType = null;
      _motion = _PieceMotion.idle;
      _controller.reset();
      setState(() => _displayType = widget.type);
    }
  }

  void _startAfterDelay(Duration duration) {
    void start() {
      if (!mounted) {
        return;
      }
      _controller
        ..duration = duration
        ..forward(from: 0);
    }

    if (widget.delay == Duration.zero) {
      start();
    } else {
      _delayTimer = Timer(widget.delay, start);
    }
  }

  @override
  void dispose() {
    _delayTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_displayType == PieceType.empty && widget.type == PieceType.empty) {
      return const SizedBox.expand();
    }

    final disc = CustomPaint(
      painter: _PiecePainter(
        type: _displayType,
        theme: widget.theme,
        isLastMove: widget.isLastMove,
      ),
      size: Size.square(widget.size),
    );

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        switch (_motion) {
          case _PieceMotion.idle:
            return child!;
          case _PieceMotion.appear:
            return _buildAppearance(child!);
          case _PieceMotion.flip:
            return _buildFlip(child!);
        }
      },
      child: disc,
    );
  }

  Widget _buildAppearance(Widget child) {
    final t = _controller.value;
    final fall = Curves.easeOutCubic.transform(t);
    final settle = Curves.easeOutBack.transform(t);
    final effect = widget.effectScale.clamp(0.55, 1.35);
    final landing = math.exp(-math.pow((t - 0.72) / 0.13, 2));
    final startScale = 1 - 0.28 * effect;
    final scaleX = (startScale + settle * (1 - startScale)) *
        (1 + landing * 0.09 * effect);
    final scaleY = (startScale + settle * (1 - startScale)) *
        (1 - landing * 0.08 * effect);
    final drop = -widget.size * 0.34 * effect * (1 - fall);
    final opacity = (t / 0.22).clamp(0.0, 1.0);

    return Opacity(
      opacity: opacity,
      child: Transform.translate(
        offset: Offset(0, drop),
        child: Transform.scale(scaleX: scaleX, scaleY: scaleY, child: child),
      ),
    );
  }

  Widget _buildFlip(Widget child) {
    final t = _controller.value;
    final turn = Curves.easeInOutCubic.transform(t);
    final effect = widget.effectScale.clamp(0.55, 1.35);
    final lift = -math.sin(t * math.pi) * widget.size * 0.14 * effect;
    final swell = 1 + math.sin(t * math.pi) * 0.045 * effect;

    return Transform.translate(
      offset: Offset(0, lift),
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.0025)
          ..rotateY(math.pi * turn)
          ..scaleByDouble(swell, swell, 1, 1),
        child: child,
      ),
    );
  }
}

enum _PieceMotion { idle, appear, flip }

class _PiecePainter extends CustomPainter {
  final PieceType type;
  final AppTheme theme;
  final bool isLastMove;

  const _PiecePainter({
    required this.type,
    required this.theme,
    required this.isLastMove,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (type == PieceType.empty || size.isEmpty) {
      return;
    }

    final shortest = size.shortestSide;
    final center = size.center(Offset.zero) - Offset(0, shortest * 0.015);
    final radius = shortest * 0.39;
    final faceRect = Rect.fromCircle(center: center, radius: radius);
    final isBlack = type == PieceType.black;

    // Soft contact shadow, then a darker lower rim to give the disc thickness.
    final shadowRect = Rect.fromCenter(
      center: center + Offset(0, shortest * 0.105),
      width: radius * 1.92,
      height: radius * 0.66,
    );
    canvas.drawOval(
      shadowRect,
      Paint()
        ..shader = const RadialGradient(
          colors: [Color(0x76000000), Color(0x00000000)],
          stops: [0.32, 1],
        ).createShader(shadowRect),
    );

    final sideRect = faceRect.shift(Offset(0, shortest * 0.042));
    canvas.drawOval(
      sideRect,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: isBlack
              ? const [Color(0xff181a1c), Color(0xff010202)]
              : const [Color(0xffd6d1c5), Color(0xff8f8b82)],
        ).createShader(sideRect),
    );

    final gradient = theme.pieceGradients[type]!;
    canvas.drawCircle(
      center,
      radius,
      Paint()..shader = gradient.createShader(faceRect),
    );

    final rim = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = (shortest * 0.025).clamp(1.0, 1.8)
      ..color = (isBlack ? const Color(0xff4c4e50) : Colors.white).withAlpha(
        isBlack ? 105 : 150,
      );
    canvas.drawCircle(center, radius * 0.91, rim);

    final lowerRim = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = (shortest * 0.018).clamp(0.7, 1.25)
      ..color = (isBlack ? Colors.black : const Color(0xff77736b)).withAlpha(
        isBlack ? 150 : 82,
      );
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius * 0.93),
      0.15,
      math.pi * 0.86,
      false,
      lowerRim,
    );

    final shine = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = (shortest * 0.035).clamp(1.1, 2.1)
      ..color = (isBlack ? const Color(0xffdadde0) : Colors.white).withAlpha(
        isBlack ? 66 : 170,
      );
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius * 0.72),
      math.pi * 1.06,
      math.pi * 0.43,
      false,
      shine,
    );

    _paintTexture(canvas, center, radius, isBlack);

    if (isLastMove) {
      final marker = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = (shortest * 0.055).clamp(2.0, 3.4)
        ..color = theme.lastMoveBorder.withAlpha(225);
      canvas.drawCircle(center, radius * 0.81, marker);
      marker
        ..strokeWidth = (shortest * 0.018).clamp(0.8, 1.3)
        ..color = Colors.white.withAlpha(125);
      canvas.drawCircle(center, radius * 0.76, marker);
    }
  }

  void _paintTexture(
    Canvas canvas,
    Offset center,
    double radius,
    bool isBlack,
  ) {
    final random = math.Random(isBlack ? 1181 : 2213);
    final fleck = Paint()..strokeCap = StrokeCap.round;
    for (var i = 0; i < 28; i++) {
      final angle = random.nextDouble() * math.pi * 2;
      final distance = math.sqrt(random.nextDouble()) * radius * 0.73;
      final start =
          center + Offset(math.cos(angle), math.sin(angle)) * distance;
      final tangent = angle + math.pi * 0.5;
      final length = radius * (0.025 + random.nextDouble() * 0.07);
      fleck
        ..color = (isBlack ? Colors.white : const Color(0xff776f64)).withAlpha(
          isBlack ? 12 + random.nextInt(16) : 10 + random.nextInt(13),
        )
        ..strokeWidth = 0.35 + random.nextDouble() * 0.4;
      canvas.drawLine(
        start,
        start + Offset(math.cos(tangent), math.sin(tangent)) * length,
        fleck,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _PiecePainter oldDelegate) {
    return oldDelegate.type != type ||
        oldDelegate.theme != theme ||
        oldDelegate.isLastMove != isLastMove;
  }
}

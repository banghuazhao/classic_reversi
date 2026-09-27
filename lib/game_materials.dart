import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'app_theme.dart';

/// A static, low-contrast grain layer that makes the game background read as a
/// tabletop instead of a flat digital gradient.
class TabletopTexture extends StatelessWidget {
  final AppTheme theme;
  final Widget child;

  const TabletopTexture({super.key, required this.theme, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned.fill(
          child: RepaintBoundary(
            child: IgnorePointer(
              child: CustomPaint(
                painter: _TabletopTexturePainter(theme),
                isComplex: true,
                willChange: false,
              ),
            ),
          ),
        ),
        child,
      ],
    );
  }
}

class _TabletopTexturePainter extends CustomPainter {
  final AppTheme theme;

  const _TabletopTexturePainter(this.theme);

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty) {
      return;
    }

    final random = math.Random(7127);
    final grain = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Long, gently wandering fibers create wood/leather-like structure while
    // staying quiet enough that text and controls remain easy to read.
    for (var i = 0; i < 34; i++) {
      final y = random.nextDouble() * size.height;
      final drift = (random.nextDouble() - 0.5) * 24;
      final path = Path()
        ..moveTo(-20, y)
        ..cubicTo(
          size.width * 0.28,
          y + drift,
          size.width * 0.64,
          y - drift * 0.7,
          size.width + 20,
          y + drift * 0.35,
        );
      grain
        ..color = (i.isEven ? theme.tableGrainLight : theme.tableGrainDark)
            .withAlpha(18 + random.nextInt(17))
        ..strokeWidth = 0.45 + random.nextDouble() * 1.15;
      canvas.drawPath(path, grain);
    }

    final fleck = Paint();
    final fleckCount = (size.width * size.height / 5200).round().clamp(50, 210);
    for (var i = 0; i < fleckCount; i++) {
      fleck.color = (i.isEven ? theme.tableGrainLight : theme.tableGrainDark)
          .withAlpha(12 + random.nextInt(18));
      final radius = 0.25 + random.nextDouble() * 0.7;
      canvas.drawCircle(
        Offset(
          random.nextDouble() * size.width,
          random.nextDouble() * size.height,
        ),
        radius,
        fleck,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _TabletopTexturePainter oldDelegate) {
    return oldDelegate.theme != theme;
  }
}

/// A framed, tactile playing surface. The child is expected to be exactly
/// [boardSize] × [boardSize] cells, each [cellSize] square.
class MaterialBoard extends StatelessWidget {
  final int boardSize;
  final double cellSize;
  final AppTheme theme;
  final Widget child;

  const MaterialBoard({
    super.key,
    required this.boardSize,
    required this.cellSize,
    required this.theme,
    required this.child,
  });

  double get frameWidth => (cellSize * 0.16).clamp(6.0, 10.0);

  @override
  Widget build(BuildContext context) {
    final playExtent = boardSize * cellSize;
    final frame = frameWidth;
    final outerRadius = (cellSize * 0.24).clamp(10.0, 16.0);

    return RepaintBoundary(
      child: Container(
        width: playExtent + frame * 2,
        height: playExtent + frame * 2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(outerRadius),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              theme.boardFrameLight,
              theme.boardFrameMid,
              theme.boardFrameDark,
            ],
            stops: const [0, 0.48, 1],
          ),
          border: Border.all(
            color: theme.boardFrameHighlight.withAlpha(120),
            width: 1,
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x66000000),
              blurRadius: 18,
              spreadRadius: 1,
              offset: Offset(0, 10),
            ),
            BoxShadow(
              color: Color(0x30000000),
              blurRadius: 3,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: CustomPaint(
          painter: _FrameGrainPainter(theme),
          child: Padding(
            padding: EdgeInsets.all(frame),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(outerRadius - frame * 0.55),
              child: CustomPaint(
                painter: _BoardSurfacePainter(
                  boardSize: boardSize,
                  cellSize: cellSize,
                  theme: theme,
                ),
                child: SizedBox(
                  width: playExtent,
                  height: playExtent,
                  child: child,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FrameGrainPainter extends CustomPainter {
  final AppTheme theme;

  const _FrameGrainPainter(this.theme);

  @override
  void paint(Canvas canvas, Size size) {
    final random = math.Random(3803);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    for (var i = 0; i < 22; i++) {
      final y = random.nextDouble() * size.height;
      final bend = (random.nextDouble() - 0.5) * 8;
      final path = Path()
        ..moveTo(0, y)
        ..quadraticBezierTo(size.width * 0.5, y + bend, size.width, y - bend);
      paint
        ..color = (i.isEven ? theme.boardFrameHighlight : theme.boardFrameDark)
            .withAlpha(22 + random.nextInt(20))
        ..strokeWidth = 0.5 + random.nextDouble();
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _FrameGrainPainter oldDelegate) {
    return oldDelegate.theme != theme;
  }
}

class _BoardSurfacePainter extends CustomPainter {
  final int boardSize;
  final double cellSize;
  final AppTheme theme;

  const _BoardSurfacePainter({
    required this.boardSize,
    required this.cellSize,
    required this.theme,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final surfaceRect = Offset.zero & size;
    final surface = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [theme.boardSurfaceLight, theme.boardSurfaceDark],
      ).createShader(surfaceRect);
    canvas.drawRect(surfaceRect, surface);

    final overlay = Paint();
    final groove = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = (cellSize * 0.035).clamp(1.0, 1.7);
    final innerLine = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = (cellSize * 0.018).clamp(0.6, 1.0);

    for (var y = 0; y < boardSize; y++) {
      for (var x = 0; x < boardSize; x++) {
        final rect = Rect.fromLTWH(
          x * cellSize,
          y * cellSize,
          cellSize,
          cellSize,
        );

        overlay.color =
            ((x + y).isEven ? theme.boardCellLight : theme.boardCellDark)
                .withAlpha((x + y).isEven ? 18 : 14);
        canvas.drawRect(rect, overlay);

        groove.color = theme.boardGrooveDark.withAlpha(155);
        canvas.drawLine(rect.topRight, rect.bottomRight, groove);
        canvas.drawLine(rect.bottomLeft, rect.bottomRight, groove);
        groove.color = theme.boardGrooveLight.withAlpha(78);
        canvas.drawLine(rect.topLeft, rect.topRight, groove);
        canvas.drawLine(rect.topLeft, rect.bottomLeft, groove);

        innerLine.color = theme.boardGrooveDark.withAlpha(38);
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            rect.deflate((cellSize * 0.075).clamp(2.2, 4.0)),
            Radius.circular((cellSize * 0.08).clamp(2.5, 4.5)),
          ),
          innerLine,
        );
      }
    }

    _paintFibers(canvas, size);
    if (boardSize == 8) {
      _paintRegistrationDots(canvas);
    }
  }

  void _paintFibers(Canvas canvas, Size size) {
    final random = math.Random(boardSize * 1009 + 41);
    final paint = Paint()..strokeCap = StrokeCap.round;
    final count = boardSize * boardSize * 3;
    for (var i = 0; i < count; i++) {
      final start = Offset(
        random.nextDouble() * size.width,
        random.nextDouble() * size.height,
      );
      final length = 0.8 + random.nextDouble() * 2.4;
      paint
        ..color = (i.isEven ? theme.boardCellLight : theme.boardCellDark)
            .withAlpha(16 + random.nextInt(22))
        ..strokeWidth = 0.35 + random.nextDouble() * 0.45;
      canvas.drawLine(
        start,
        start + Offset(length, (random.nextDouble() - 0.5) * 0.7),
        paint,
      );
    }
  }

  void _paintRegistrationDots(Canvas canvas) {
    final shadow = Paint()..color = theme.boardGrooveDark.withAlpha(125);

    for (final x in const [2, 5]) {
      for (final y in const [2, 5]) {
        final center = Offset((x + 0.5) * cellSize, (y + 0.5) * cellSize);
        final radius = (cellSize * 0.055).clamp(1.6, 2.7);
        final dotRect = Rect.fromCircle(center: center, radius: radius);
        final inlay = Paint()
          ..shader = RadialGradient(
            center: const Alignment(-0.35, -0.35),
            colors: [theme.boardFrameHighlight, theme.boardFrameMid],
          ).createShader(dotRect);
        canvas.drawCircle(center + Offset(0, radius * 0.45), radius, shadow);
        canvas.drawCircle(center, radius, inlay);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _BoardSurfacePainter oldDelegate) {
    return oldDelegate.boardSize != boardSize ||
        oldDelegate.cellSize != cellSize ||
        oldDelegate.theme != theme;
  }
}

/// A short, decaying physical nudge used when a move lands. It moves only the
/// visual board; game state and hit testing remain in their original space.
class BoardImpactAnimator extends StatefulWidget {
  final int impactId;
  final int flippedCount;
  final Widget child;

  const BoardImpactAnimator({
    super.key,
    required this.impactId,
    required this.flippedCount,
    required this.child,
  });

  @override
  State<BoardImpactAnimator> createState() => _BoardImpactAnimatorState();
}

class _BoardImpactAnimatorState extends State<BoardImpactAnimator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 320),
  );

  @override
  void didUpdateWidget(covariant BoardImpactAnimator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.impactId != widget.impactId && widget.impactId > 0) {
      if (!(MediaQuery.maybeOf(context)?.disableAnimations ?? false)) {
        _controller.forward(from: 0);
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.maybeOf(context)?.disableAnimations ?? false) {
      return widget.child;
    }

    return AnimatedBuilder(
      animation: _controller,
      child: widget.child,
      builder: (context, child) {
        final t = _controller.value;
        final envelope = math.pow(1 - t, 2).toDouble();
        final intensity = (0.55 + widget.flippedCount * 0.07).clamp(0.55, 1.25);
        final nudge = math.sin(t * math.pi * 5) * envelope * intensity;
        final press = math.sin(math.min(t / 0.58, 1) * math.pi) * 0.0045;
        return Transform.translate(
          offset: Offset(nudge, nudge.abs() * 0.28),
          transformHitTests: false,
          child: Transform.scale(
            scale: 1 - press,
            alignment: Alignment.center,
            transformHitTests: false,
            child: child,
          ),
        );
      },
    );
  }
}

/// A one-shot ring and small radial flecks around the latest move.
class MoveImpactHalo extends StatelessWidget {
  final double size;
  final Color color;

  const MoveImpactHalo({super.key, required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    final reduceMotion =
        MediaQuery.maybeOf(context)?.disableAnimations ?? false;
    if (reduceMotion) {
      return const SizedBox.expand();
    }
    return IgnorePointer(
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: 1),
        duration: const Duration(milliseconds: 430),
        curve: Curves.easeOutCubic,
        builder: (context, progress, child) {
          return CustomPaint(
            painter: _MoveImpactPainter(progress: progress, color: color),
            size: Size.square(size),
          );
        },
      ),
    );
  }
}

class _MoveImpactPainter extends CustomPainter {
  final double progress;
  final Color color;

  const _MoveImpactPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final fade = math.pow(1 - progress, 2).toDouble();
    final radius = size.shortestSide * (0.26 + progress * 0.28);
    final ring = Paint()
      ..color = color.withAlpha((fade * 190).round())
      ..style = PaintingStyle.stroke
      ..strokeWidth = (size.shortestSide * 0.045 * fade).clamp(0.6, 2.2);
    canvas.drawCircle(center, radius, ring);

    final fleck = Paint()..color = color.withAlpha((fade * 155).round());
    for (var i = 0; i < 8; i++) {
      final angle = i * math.pi / 4;
      final distance = size.shortestSide * (0.31 + progress * 0.25);
      canvas.drawCircle(
        center + Offset(math.cos(angle), math.sin(angle)) * distance,
        (size.shortestSide * 0.026 * fade).clamp(0.4, 1.4),
        fleck,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _MoveImpactPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.color != color;
  }
}

/// A legal-move marker styled as an inset peg in the board rather than a flat
/// translucent dot.
class MaterialMoveHint extends StatelessWidget {
  final double size;
  final Color color;

  const MaterialMoveHint({super.key, required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    final reduceMotion =
        MediaQuery.maybeOf(context)?.disableAnimations ?? false;
    final hint = CustomPaint(
      size: Size.square(size),
      painter: _MoveHintPainter(color),
    );
    if (reduceMotion) {
      return hint;
    }
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.68, end: 1),
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOutBack,
      builder: (context, scale, child) {
        return Transform.scale(scale: scale, child: child);
      },
      child: hint,
    );
  }
}

class _MoveHintPainter extends CustomPainter {
  final Color color;

  const _MoveHintPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.shortestSide * 0.38;
    canvas.drawCircle(
      center + Offset(0, radius * 0.2),
      radius,
      Paint()..color = const Color(0x65000000),
    );
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..shader = RadialGradient(
          center: const Alignment(-0.4, -0.45),
          colors: [color.withAlpha(210), color.withAlpha(92)],
        ).createShader(Rect.fromCircle(center: center, radius: radius)),
    );
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = color.withAlpha(185)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.8,
    );
  }

  @override
  bool shouldRepaint(covariant _MoveHintPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}

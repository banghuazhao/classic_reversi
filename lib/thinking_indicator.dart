// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:classic_reversi/styling.dart';
import 'package:flutter/widgets.dart';

/// This is a self-animated progress spinner, only instead of spinning it
/// moves five little circles in a horizontal arrangement.
class ThinkingIndicator extends ImplicitlyAnimatedWidget {
  final Color color;
  final double height;
  final bool visible;
  final bool emphasized;
  final bool reduceMotion;
  final double effectScale;

  const ThinkingIndicator({
    super.key,
    this.color = const Color(0xffffffff),
    this.height = 10.0,
    this.visible = true,
    this.emphasized = false,
    this.reduceMotion = false,
    this.effectScale = 1,
  }) : super(
          duration: reduceMotion ? Duration.zero : Styling.thinkingFadeDuration,
        );

  @override
  ImplicitlyAnimatedWidgetState createState() => _ThinkingIndicatorState();
}

class _ThinkingIndicatorState
    extends AnimatedWidgetBaseState<ThinkingIndicator> {
  Tween<double>? _opacityTween;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reduceMotion = widget.reduceMotion ||
        (MediaQuery.maybeOf(context)?.disableAnimations ?? false);
    return Center(
      child: SizedBox(
        height: widget.height,
        child: Opacity(
          opacity: _opacityTween!.evaluate(animation),
          child: _opacityTween!.evaluate(animation) != 0
              ? AnimatedScale(
                  scale: widget.emphasized && !reduceMotion
                      ? 1 + 0.18 * widget.effectScale.clamp(0.8, 1.25)
                      : 1,
                  duration: reduceMotion
                      ? Duration.zero
                      : const Duration(milliseconds: 160),
                  curve: Curves.easeOutBack,
                  child: reduceMotion
                      ? _StaticCircles(
                          color: widget.color,
                          height: widget.height,
                        )
                      : _AnimatedCircles(
                          color: widget.color,
                          height: widget.height,
                          emphasized: widget.emphasized,
                          effectScale: widget.effectScale,
                        ),
                )
              : null,
        ),
      ),
    );
  }

  @override
  void forEachTween(visitor) {
    _opacityTween = visitor(
      _opacityTween,
      widget.visible ? 1.0 : 0.0,
      (dynamic value) => Tween<double>(begin: value as double),
    ) as Tween<double>?;
  }
}

class _AnimatedCircles extends StatefulWidget {
  final Color color;
  final double height;
  final bool emphasized;
  final double effectScale;

  const _AnimatedCircles({
    super.key,
    required this.color,
    required this.height,
    required this.emphasized,
    required this.effectScale,
  });

  @override
  _AnimatedCirclesState createState() => _AnimatedCirclesState();
}

class _AnimatedCirclesState extends State<_AnimatedCircles>
    with SingleTickerProviderStateMixin {
  late Animation<double> _thinkingAnimation;
  late AnimationController _thinkingController;

  @override
  void initState() {
    super.initState();
    _thinkingController = AnimationController(duration: _duration, vsync: this)
      ..addStatusListener((status) {
        // This bit ensures that the animation reverses course rather than
        // stopping.
        if (status == AnimationStatus.completed) _thinkingController.reverse();
        if (status == AnimationStatus.dismissed) _thinkingController.forward();
      });
    _setThinkingAnimation();
    _thinkingController.forward();
  }

  Duration get _duration => Duration(
        milliseconds: widget.emphasized ? 260 : 500,
      );

  void _setThinkingAnimation() {
    _thinkingAnimation = Tween(
      begin: 0.0,
      end: widget.height * widget.effectScale.clamp(0.75, 1.2),
    ).animate(
      CurvedAnimation(parent: _thinkingController, curve: Curves.easeOut),
    );
  }

  @override
  void didUpdateWidget(covariant _AnimatedCircles oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.emphasized != widget.emphasized ||
        oldWidget.effectScale != widget.effectScale) {
      _thinkingController.duration = _duration;
      _setThinkingAnimation();
    }
  }

  @override
  void dispose() {
    _thinkingController.dispose();
    super.dispose();
  }

  Widget _buildCircle() {
    return Container(
      width: widget.height,
      height: widget.height,
      decoration: BoxDecoration(
        border: Border.all(
          color: widget.color,
          width: 2.0,
        ),
        borderRadius: BorderRadius.all(const Radius.circular(5.0)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _thinkingAnimation,
      builder: (context, child) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildCircle(),
            SizedBox(width: _thinkingAnimation.value),
            _buildCircle(),
            SizedBox(width: _thinkingAnimation.value),
            _buildCircle(),
            SizedBox(width: _thinkingAnimation.value),
            _buildCircle(),
            SizedBox(width: _thinkingAnimation.value),
            _buildCircle(),
          ],
        );
      },
    );
  }
}

class _StaticCircles extends StatelessWidget {
  final Color color;
  final double height;

  const _StaticCircles({required this.color, required this.height});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Padding(
          padding: EdgeInsets.only(left: index == 0 ? 0 : height * 0.6),
          child: Container(
            width: height,
            height: height,
            decoration: BoxDecoration(
              border: Border.all(color: color, width: 2),
              shape: BoxShape.circle,
            ),
          ),
        );
      }),
    );
  }
}

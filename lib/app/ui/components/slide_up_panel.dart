import 'package:flutter/material.dart';
import 'dart:math' as math;

class SlideUpPanel extends StatelessWidget {
  final Animation animation;
  final AnimationController controller;
  final Widget child;

  SlideUpPanel({this.animation, this.controller, this.child});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      child: child,
      builder: (context, widget) {
        return Positioned(
          top: animation.value,
          left: 0,
          right: 0,
          bottom: 0,
          child: GestureDetector(
            onTap: () {
              final bool isOpen =
                  controller.status == AnimationStatus.completed;
              controller.fling(velocity: isOpen ? -2 : 2);
            },
            onVerticalDragUpdate: (DragUpdateDetails detail) {
              _onVerticalDragUpdate(context, detail);
            },
            onVerticalDragEnd: (DragEndDetails detail) {
              _handleDragEnd(context, detail);
            },
            child: widget,
          ),
        );
      },
    );
  }

  void _handleDragEnd(BuildContext context, DragEndDetails details) {
    if (controller.isAnimating ||
        controller.status == AnimationStatus.completed) return;

    final double flingVelocity = details.velocity.pixelsPerSecond.dy /
        (MediaQuery.of(context).size.height *
            0.4); //<-- calculate the velocity of the gesture
    if (flingVelocity < 0.0)
      controller.fling(
          velocity:
              math.max(2.0, -flingVelocity)); //<-- either continue it upwards
    else if (flingVelocity > 0.0)
      controller.fling(
          velocity:
              math.min(-2.0, -flingVelocity)); //<-- or continue it downwards
    else
      controller.fling(
          velocity: controller.value < 0.5
              ? -2.0
              : 2.0); //<-- or just continue to whichever edge is closer
  }

  void _onVerticalDragUpdate(BuildContext context, DragUpdateDetails details) {
    controller.value -=
        details.primaryDelta / (MediaQuery.of(context).size.height * 0.4);
  }
}

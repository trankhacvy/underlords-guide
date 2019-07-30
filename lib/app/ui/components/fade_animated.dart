import 'package:flutter/material.dart';

class FadeAnimated extends StatelessWidget {
  final Animation<double> animation;
  final Widget child;

  FadeAnimated({this.animation, this.child});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      child: this.child,
      builder: (context, widget) {
        return Opacity(
          opacity: animation.value,
          child: widget,
        );
      },
    );
  }
}

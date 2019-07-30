import 'package:flutter/material.dart';

class NullableView extends StatelessWidget {
  final Widget child;
  final bool condition;

  NullableView({this.child, this.condition});

  @override
  Widget build(BuildContext context) {
    return condition ? child : Container();
  }
}

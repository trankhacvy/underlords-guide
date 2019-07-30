import 'package:flutter/material.dart';

class AllianceEffect extends StatefulWidget {
  AllianceEffect() {
    print("AllianceEffect const");
  }

  @override
  _AllianceEffectState createState() => _AllianceEffectState();
}

class _AllianceEffectState extends State<AllianceEffect> {
  _AllianceEffectState() {
    print("_AllianceEffectState const");
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("hehehe"),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:UnderlordsGuru/utility/colors.dart';
import 'package:UnderlordsGuru/utility/images.dart';

class AllianceIcon extends StatelessWidget {
  final double size;
  final String name;
  final bool active;

  AllianceIcon({this.size = 20.0, this.name, this.active = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(2.0),
      padding: EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: active ? getColorByAlliance(name) : HexColor(ALLIANCE_BG_COLOR),
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
      child: Image(
        image: AssetImage(this.active
            ? ImageHelper.getAllianceIconByName(name).replaceAll(".", "_white.")
            : ImageHelper.getAllianceIconByName(name)),
        width: this.size,
        height: this.size,
        fit: BoxFit.contain,
      ),
    );
  }
}

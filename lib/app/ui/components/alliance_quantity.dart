import 'package:flutter/material.dart';
import 'package:UnderlordsGuru/utility/colors.dart';

class AllianceQuantity extends StatelessWidget {
  final int maxHeroes;
  final int currentHeroes;
  final int requiredHeroes;
  final Color color;

  final double wrapperHeight = 52;
  final double itemWidth = 8.0; // height 16, 25
  final double space = 2.0;

  AllianceQuantity(
      {this.maxHeroes, this.currentHeroes, this.requiredHeroes, this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Row(
          children: renderRowItems(),
        )
      ],
    );
  }

  renderColsItem(int colIndex) {
    List<Widget> itemsOfCol = [];

    double itemHeight = requiredHeroes == 1
        ? wrapperHeight
        : (requiredHeroes % 2 == 0
            ? (wrapperHeight - space) / 2
            : (wrapperHeight - 2 * space) / 3);

    List.generate(requiredHeroes, (i) => i).forEach((index) {
      int itemOrder = ((index + 1) + (requiredHeroes * colIndex));
      itemsOfCol.add(Container(
        margin: EdgeInsets.only(right: space),
        width: itemWidth,
        height: itemHeight,
        decoration: BoxDecoration(
          color:
              itemOrder <= currentHeroes ? color : HexColor(ALLIANCE_BG_COLOR),
          borderRadius: getBorderRadius(index),
        ),
      ));
    });

    return itemsOfCol;
  }

  renderRowItems() {
    int colNums = maxHeroes ~/ requiredHeroes;
    var itemsOfRow = <Widget>[];

    List.generate(colNums, (i) => i).forEach((index) {
      itemsOfRow.add(Container(
        height: wrapperHeight,
        child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: renderColsItem(index)),
      ));
    });

    return itemsOfRow;
  }

  getBorderRadius(int index) {
    if (requiredHeroes == 1) {
      return BorderRadius.all(Radius.circular(itemWidth / 2));
    } else {
      if (index % requiredHeroes == 0) {
        return BorderRadius.vertical(top: Radius.circular(itemWidth / 2));
      } else if (index % requiredHeroes == (requiredHeroes - 1)) {
        return BorderRadius.vertical(bottom: Radius.circular(itemWidth / 2));
      }
    }
  }
}

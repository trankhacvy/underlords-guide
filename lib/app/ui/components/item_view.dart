import 'package:flutter/material.dart';
import 'package:UnderlordsGuru/app/model/pojo/item.dart';

class ItemView extends StatelessWidget {
  final Item item;
  final Function(Item) onItemClick;

  ItemView({this.item, this.onItemClick});

  @override
  Widget build(BuildContext context) {
    final Widget image = Container(
        margin: EdgeInsets.only(top: 8.0),
        child: new CircleAvatar(
            backgroundImage: NetworkImage(item.icon),
            foregroundColor: Colors.white,
            backgroundColor: Colors.grey),
        width: 80.0,
        height: 80.0,
        padding: const EdgeInsets.all(2.0), // borde width
        decoration: new BoxDecoration(
          color: const Color(0xFFFFFFFF), // border color
          shape: BoxShape.circle,
        ));

    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: Color.fromRGBO(29, 29, 29, 1),
          borderRadius: BorderRadius.all(Radius.circular(4.0))),
      child: InkWell(
        onTap: () {
          onItemClick(item);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            image,
            Padding(
              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Text(item.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.2,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

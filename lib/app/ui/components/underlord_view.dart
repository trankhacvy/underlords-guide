import 'package:flutter/material.dart';
import 'package:UnderlordsGuru/app/model/core/AppProvider.dart';
import 'package:fluro/fluro.dart';
import 'package:UnderlordsGuru/app/model/pojo/underlord.dart';
import 'package:UnderlordsGuru/app/ui/page/underlord_detail/underlord_detail_page.dart';
import 'package:UnderlordsGuru/utility/colors.dart';

class UnderlordView extends StatelessWidget {
  final double imageSize = 140;

  final Underlord underlord;

  UnderlordView({this.underlord});

  void handleItemClick(context) {
    AppProvider.getRouter(context).navigateTo(
        context,
        UnderlordDetailPage.generatePath(underlord.id.toString(),
            underlord.name, underlord.avatar, underlord.intro),
        transition: TransitionType.fadeIn);
  }

  @override
  Widget build(BuildContext context) {
    var img = new Container(
      width: imageSize,
      height: imageSize,
      decoration: BoxDecoration(
        color: Color(0xff7c94b6),
        image: DecorationImage(
          image: AssetImage(underlord.avatar),
          fit: BoxFit.cover,
        ),
        borderRadius: new BorderRadius.all(new Radius.circular(imageSize / 2)),
        border: new Border.all(
          color: Colors.white,
          width: 2.0,
        ),
      ),
    );

    return Card(
      margin: EdgeInsets.all(0.0),
      child: InkWell(
        onTap: () {
          handleItemClick(context);
        },
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              img,
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Hero(
                  tag: "underlord_name_${underlord.id}",
                  child: Material(
                    type: MaterialType.transparency,
                    child: Text(underlord.name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          height: 1.2,
                          fontWeight: FontWeight.bold,
                          color: getUnderlordColor(underlord.name),
                        )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

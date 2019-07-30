import 'package:flutter/material.dart';
import 'package:UnderlordsGuru/app/model/core/AppProvider.dart';
import 'package:fluro/fluro.dart';
import 'package:UnderlordsGuru/app/model/pojo/hero_model.dart';
import 'package:UnderlordsGuru/app/ui/page/hero_detail/hero_detail_page.dart';
import 'package:UnderlordsGuru/app/ui/components/alliance_icon.dart';

class HeroView extends StatelessWidget {
  final double imageSize = 80;

  final HeroModel hero;
  final bool useTag;
  final double width;

  HeroView({Key key, this.hero, this.width = 0, this.useTag = true})
      : super(key: key);

  Widget _renderAlliances(List<String> alliances, context) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: alliances
          .map<Widget>((alliance) => AllianceIcon(
                name: alliance,
                active: true,
              ))
          .toList(),
    );
  }

  void handleItemClick(context) {
    AppProvider.getRouter(context).navigateTo(
        context,
        HeroDetailPage.generatePath(hero.id.toString(), hero.name, hero.icon,
            hero.tier, hero.alliances),
        transition: TransitionType.fadeIn);
  }

  @override
  Widget build(BuildContext context) {
    final size = width > 0 ? width - 2 * 8 : imageSize;

    var image = Container(
      width: size,
      height: size,
      decoration: new BoxDecoration(
        color: const Color(0xff7c94b6),
        image: new DecorationImage(
          image: AssetImage(hero.icon),
          fit: BoxFit.cover,
        ),
        borderRadius: new BorderRadius.all(new Radius.circular(50.0)),
        border: new Border.all(
          color: Colors.white,
          width: 2.0,
        ),
      ),
    );

    var name = Text(hero.name,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: TextStyle(
          fontSize: 14,
          height: 1.2,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ));

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
              this.useTag
                  ? Hero(
                      tag: "hero_avatar_${hero.id}",
                      child: image,
                    )
                  : image,
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: this.useTag
                    ? Hero(
                        tag: "hero_name_${hero.id}",
                        child: Material(
                          type: MaterialType.transparency,
                          child: name,
                        ),
                      )
                    : name,
              ),
              _renderAlliances(hero.alliances, context)
            ],
          ),
        ),
      ),
    );
  }
}

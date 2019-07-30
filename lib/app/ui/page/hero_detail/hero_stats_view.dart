import 'package:flutter/material.dart';
import 'package:UnderlordsGuru/app/model/pojo/hero_model.dart';
import 'package:UnderlordsGuru/app/model/pojo/hero_stats.dart';
import 'package:UnderlordsGuru/utility/colors.dart';

class HeroStatsView extends StatelessWidget {
  final HeroModel hero;

  List<HeroStats> heroStats = [];

  HeroStatsView({this.hero}) {
    
    heroStats = [
      HeroStats(name: 'Health', values: hero.health.split(';')),
      HeroStats(name: 'Mana', values: hero.mana.split(';')),
      HeroStats(name: 'DPS', values: hero.dps.split(';')),
      HeroStats(name: 'Damage', values: hero.damage.split(';')),
      HeroStats(name: 'Attack Speed', values: hero.attackSpeed.split(';')),
      HeroStats(name: 'Move Speed', values: hero.moveSpeed.split(';')),
      HeroStats(name: 'Attack Range', values: hero.attackRange.split(';')),
      HeroStats(name: 'Magic Resist', values: hero.magicResist.split(';')),
      HeroStats(name: 'Armor', values: hero.armor.split(';')),
      HeroStats(name: 'Health Regen', values: hero.healthRegen.split(';'))
    ];
  }

  @override
  Widget build(BuildContext context) {
    var children = <Widget>[];
    // add header
    children.add(
      Row(
        children: <Widget>[
          Expanded(
            child: Container(
              color: Colors.greenAccent,
            ),
          ),
          Expanded(
            child: Image.asset(
              'images/ic_hero_lv1.png',
              width: 24.0,
              height: 24.0,
            ),
          ),
          Expanded(
            child: Image.asset(
              'images/ic_hero_lv2.png',
              width: 24.0,
              height: 24.0,
            ),
          ),
          Expanded(
            child: Image.asset(
              'images/ic_hero_lv3.png',
              width: 24.0,
              height: 24.0,
            ),
          ),
        ],
      ),
    );

    for (var i = 0; i < heroStats.length; i++) {
      children.add(SizedBox(height: 8.0));
      children.add(Row(
        children: <Widget>[
          Expanded(
            child: Text(heroStats[i].name,
                style: Theme.of(context).textTheme.caption),
          ),
          Expanded(
            child: Text(
              heroStats[i].values[0],
              style: TextStyle(
                  color: HexColor(HERO_ONE_STAR_COLOR),
                  fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text(
              heroStats[i].values[1],
              style: TextStyle(
                  color: HexColor(HERO_TWO_STAR_COLOR),
                  fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text(
              heroStats[i].values[2],
              style: TextStyle(
                  color: HexColor(HERO_THREE_STAR_COLOR),
                  fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ));
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            children: children,
          ),
        ],
      ),
    );
  }
}

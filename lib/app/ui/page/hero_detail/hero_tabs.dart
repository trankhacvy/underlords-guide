import 'package:flutter/material.dart';
import 'package:UnderlordsGuru/app/ui/page/hero_detail/hero_stats_view.dart';
import 'package:UnderlordsGuru/app/ui/page/hero_detail/hero_skills.dart';
import 'package:UnderlordsGuru/app/model/pojo/hero_model.dart';

class HeroTabs extends StatelessWidget {
  final HeroModel _heroModel;
  List<TabData> _tabs;

  HeroTabs({heroModel}) : this._heroModel = heroModel {
    _tabs = [
      TabData("Skills", HeroSkills(hero: _heroModel)),
      TabData("Skills", Center(child: Text('heroes'))),
      TabData("Stats", HeroStatsView(hero: _heroModel)),
      TabData(
          "Change log",
          Container(
            color: Colors.redAccent,
          )),
    ];
  }

  Widget _buildTabBar() {
    return TabBar(
      labelPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 16),
      indicatorSize: TabBarIndicatorSize.label,
      indicatorWeight: 2,
      indicatorColor: Color.fromRGBO(3, 218, 198, 1),
      tabs: _tabs.map((tab) => Text(tab.label)).toList(),
    );
  }

  Widget _buildTabContent() {
    return Expanded(
      child: TabBarView(
        children: _tabs.map((tab) => tab.child).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return DefaultTabController(
      length: 4,
      initialIndex: 2,
      child: Container(
        width: screenWidth,
        decoration: BoxDecoration(
          color: Color.fromRGBO(29, 29, 29, 1),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildTabBar(),
            _buildTabContent(),
          ],
        ),
      ),
    );
  }
}

class TabData {
  final String label;
  final Widget child;

  TabData(this.label, this.child);
}

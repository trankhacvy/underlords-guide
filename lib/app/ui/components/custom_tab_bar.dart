import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  final List<TabData> tabDatas;

  CustomTabBar({this.tabDatas});

  Widget _buildTabBar() {
    return TabBar(
      labelPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 16),
      indicatorSize: TabBarIndicatorSize.label,
      indicatorWeight: 2,
      indicatorColor: Color.fromRGBO(3, 218, 198, 1),
      tabs: tabDatas.map((tab) => Text(tab.label)).toList(),
    );
  }

  Widget _buildTabContent() {
    return Expanded(
      child: TabBarView(
        children: tabDatas.map((tab) => tab.child).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return DefaultTabController(
      length: tabDatas.length,
      initialIndex: 0,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        child: Container(
          width: screenWidth,
          decoration: BoxDecoration(
            color: Color.fromRGBO(29, 29, 29, 1),
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
      ),
    );
  }
}

class TabData {
  final String label;
  final Widget child;

  TabData(this.label, this.child);
}

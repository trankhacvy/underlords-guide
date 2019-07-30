import 'package:flutter/material.dart';
import 'package:UnderlordsGuru/app/ui/components/navigationIcon_view.dart';
import 'package:UnderlordsGuru/app/ui/page/heroes/heroes_page.dart';
import 'package:UnderlordsGuru/app/ui/page/alliances/alliances_page.dart';
import 'package:UnderlordsGuru/app/ui/page/items/items_page.dart';
import 'package:UnderlordsGuru/app/ui/page/underlords/underlords_page.dart';
import 'package:UnderlordsGuru/app/ui/page/update/update_notes_pages.dart';
import 'package:UnderlordsGuru/app/ui/components/drawer_menu.dart';

class HomePage extends StatefulWidget {
  static const String PATH = '/';

  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  List<NavigationIconView> _navigationViews;
  BottomNavigationBarType _type = BottomNavigationBarType.shifting;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    _navigationViews = <NavigationIconView>[
      NavigationIconView(
        icon: _buildIcon("images/ic_tab_heroes.png", 16.0),
        activeIcon: _buildIcon("images/ic_tab_heroes.png", 28.0),
        title: 'Heroes',
        vsync: this,
        content: HeroesPage(),
      ),
      NavigationIconView(
        icon: _buildIcon("images/ic_tab_alliances.png", 16.0),
        activeIcon: _buildIcon("images/ic_tab_alliances.png", 28.0),
        title: 'Aliances',
        vsync: this,
        content: AlliancesPage(),
      ),
      NavigationIconView(
        icon: _buildIcon("images/ic_tab_items.png", 16.0),
        activeIcon: _buildIcon("images/ic_tab_items.png", 28.0),
        title: 'Items',
        // color: Colors.teal,
        vsync: this,
        content: ItemsPage(),
      ),
      NavigationIconView(
        icon: _buildIcon("images/ic_tab_underlords.png", 16.0),
        activeIcon: _buildIcon("images/ic_tab_underlords.png", 28.0),
        title: 'Underlords',
        vsync: this,
        content: UnderlordsPage(),
      ),
      NavigationIconView(
        icon: const Icon(Icons.event_available),
        title: 'Update Note',
        vsync: this,
        content: UpdateNotesPage(),
      ),
    ];
    _navigationViews[_currentIndex].controller.value = 1.0;
  }

  Widget _buildIcon(asset, size) {
    return Image.asset(asset, width: size, height: size, fit: BoxFit.cover);
  }

  @override
  void dispose() {
    super.dispose();
    for (NavigationIconView view in _navigationViews) {
      view.controller.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    final BottomNavigationBar botNavBar = BottomNavigationBar(
      items: _navigationViews
          .map<BottomNavigationBarItem>(
              (NavigationIconView navigationView) => navigationView.item)
          .toList(),
      currentIndex: _currentIndex,
      type: _type,
      onTap: (int index) {
        setState(() {
          _navigationViews[_currentIndex].controller.reverse();
          _currentIndex = index;
          _navigationViews[_currentIndex].controller.forward();
        });
      },
    );

    return Scaffold(
      body: _buildTransitionsStack(),
      drawer: DrawerMenu(),
      bottomNavigationBar: botNavBar,
    );
  }

  Widget _buildTransitionsStack() {
    final List<FadeTransition> transitions = <FadeTransition>[];

    for (NavigationIconView view in _navigationViews) {
      transitions.add(view.transition(_type, context));
    }

    return IndexedStack(
      index: _currentIndex,
      children: transitions,
    );
  }
}

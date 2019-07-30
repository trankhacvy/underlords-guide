import 'package:UnderlordsGuru/app/ui/components/drawer_menu.dart';
import 'package:flutter/material.dart';
import 'package:UnderlordsGuru/app/model/core/AppProvider.dart';
import 'package:UnderlordsGuru/app/model/core/AppStoreApplication.dart';
import 'package:UnderlordsGuru/app/model/pojo/alliance.dart';
import 'package:UnderlordsGuru/app/ui/components/alliance_view.dart';

class AlliancesPage extends StatefulWidget {
  @override
  _AlliancesPageState createState() => _AlliancesPageState();
}

class _AlliancesPageState extends State<AlliancesPage> {
  List<Alliance> _alliances = [];
  Orientation _orientation;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    AppStoreApplication application = AppProvider.of(context).application;

    application.dbAppStoreRepository
        .loadAlliances()
        .then((alliances) => setState(() {
              _alliances = alliances;
            }));

    _orientation = MediaQuery.of(context).orientation;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Alliances')),
      drawer: DrawerMenu(),
      body: GridView.count(
        crossAxisCount: (_orientation == Orientation.portrait) ? 3 : 6,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
        padding: const EdgeInsets.all(8.0),
        childAspectRatio: (_orientation == Orientation.portrait) ? 1 : 1,
        children: _alliances.map<Widget>((Alliance alliance) {
          return AllianceView(alliance: alliance);
        }).toList(),
      ),
    );
  }
}

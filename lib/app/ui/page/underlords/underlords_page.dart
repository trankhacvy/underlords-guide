import 'package:UnderlordsGuru/app/ui/components/drawer_menu.dart';
import 'package:flutter/material.dart';
import 'package:UnderlordsGuru/app/model/core/AppProvider.dart';
import 'package:UnderlordsGuru/app/model/core/AppStoreApplication.dart';
import 'package:UnderlordsGuru/app/ui/components/underlord_view.dart';
import 'package:UnderlordsGuru/app/model/pojo/underlord.dart';

class UnderlordsPage extends StatefulWidget {
  @override
  _UnderlordsPageState createState() => _UnderlordsPageState();
}

class _UnderlordsPageState extends State<UnderlordsPage> {
  List<Underlord> _underlords = [];
  bool loading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    AppStoreApplication application = AppProvider.of(context).application;
    setState(() {
      loading = true;
    });
    application.dbAppStoreRepository.loadUnderlords().then((underlords) {
      setState(() {
        setState(() {
          loading = false;
          _underlords = underlords;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Underlords")),
      drawer: DrawerMenu(),
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              padding: const EdgeInsets.all(8.0),
              childAspectRatio: 0.8,
              children: _underlords.map<Widget>((Underlord underlord) {
                return UnderlordView(underlord: underlord);
              }).toList(),
            ),
    );
  }
}

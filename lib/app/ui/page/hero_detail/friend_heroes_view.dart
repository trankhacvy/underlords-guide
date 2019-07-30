import 'package:flutter/material.dart';
import 'package:UnderlordsGuru/app/model/pojo/hero_model.dart';
import 'package:UnderlordsGuru/app/model/core/AppStoreApplication.dart';
import 'package:UnderlordsGuru/app/model/core/AppProvider.dart';
import 'package:UnderlordsGuru/app/ui/components/hero_view.dart';
import 'package:UnderlordsGuru/utility/colors.dart';

class FriendHeroesView extends StatefulWidget {
  final HeroModel hero;

  FriendHeroesView({this.hero});

  @override
  _FriendHeroesViewState createState() => _FriendHeroesViewState();
}

class _FriendHeroesViewState extends State<FriendHeroesView> {
  Map<String, List<HeroModel>> heroesSameAlliance = {};
  bool loading = false;

  double width = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    width = MediaQuery.of(context).size.width;

    setState(() {
      loading = true;
    });
    AppStoreApplication application = AppProvider.of(context).application;
    application.dbAppStoreRepository
        .find(widget.hero.id, widget.hero.alliances)
        .then((result) {
      print('results $result');
      setState(() {
        heroesSameAlliance = result;
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    List<Widget> widgets = [];
    heroesSameAlliance.forEach((String alliance, List<HeroModel> heroes) {
      widgets.add(Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Other $alliance heroes",
              style: Theme.of(context).textTheme.body2),
          Container(
              height: 1,
              color: HexColor('#505050'),
              margin: EdgeInsets.symmetric(vertical: 8.0)),
          SizedBox(height: 8.0),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: heroes
                .map((hero) => Container(
                      width: (this.width - 4 * 8) / 3,
                      child: HeroView(
                        hero: hero,
                        useTag: false,
                      ),
                    ))
                .toList(),
          ),
          SizedBox(height: 16.0),
        ],
      ));
    });

    return Container(
      padding: EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: widgets,
        ),
      ),
    );
  }
}

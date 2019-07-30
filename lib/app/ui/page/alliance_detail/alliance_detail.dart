import 'package:UnderlordsGuru/utility/colors.dart';
import 'package:flutter/material.dart';
import 'package:UnderlordsGuru/app/model/core/AppProvider.dart';
import 'package:UnderlordsGuru/app/model/core/AppStoreApplication.dart';
import 'package:UnderlordsGuru/app/model/pojo/alliance.dart';
import 'package:UnderlordsGuru/app/model/pojo/hero_model.dart';
import 'package:UnderlordsGuru/app/model/pojo/alliance_detail.dart';
import 'package:UnderlordsGuru/app/ui/components/alliance_icon.dart';
import 'package:UnderlordsGuru/app/ui/components/hero_view.dart';
import 'package:UnderlordsGuru/app/ui/components/alliance_quantity.dart';

class AllianceDetailPage extends StatefulWidget {
  static const String PATH = '/alliance';

  static String generatePath(String id, String name, String icon) {
    Map<String, dynamic> params = {
      'id': id,
      'name': name,
      'icon': icon,
    };
    Uri uri = Uri(path: PATH, queryParameters: params);
    return uri.toString();
  }

  final int id;
  final String name;
  final String icon;

  AllianceDetailPage({this.id, this.name, this.icon});

  @override
  _AllianceDetailPageState createState() => _AllianceDetailPageState();
}

class _AllianceDetailPageState extends State<AllianceDetailPage> {
  _AllianceDetailPageState();

  AllianceDetail _allianceDetail;
  bool loading = false;

  Orientation _orientation;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _orientation = MediaQuery.of(context).orientation;

    AppStoreApplication application = AppProvider.of(context).application;
    setState(() {
      loading = true;
    });
    application.dbAppStoreRepository
        .findAllianceById(widget.id)
        .then((alliance) => setState(() {
              _allianceDetail = alliance;
              loading = false;
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Hero(
        tag: "alliance_${widget.id}",
        child: Material(
          type: MaterialType.transparency,
          child: Text(
            widget.name,
            style: Theme.of(context).textTheme.headline,
          ),
        ),
      )),
      body: loading
          ? (Center(
              child: CircularProgressIndicator(),
            ))
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  renderListEffects(),
                  SizedBox(height: 16),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text('Heroes',
                        style: Theme.of(context).textTheme.title),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                    child: Container(
                      color: Color.fromRGBO(80, 80, 80, 1),
                      height: 1,
                    ),
                  ),
                  renderListHeroes(),
                ],
              ),
            ),
    );
  }

  Widget renderListEffects() {
    Alliance alliance = _allianceDetail.alliance;
    List<AllianceBonus> allianceBonuses =
        _allianceDetail.alliance.allianceBonuses;
    AllianceBonus bonus;
    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: allianceBonuses.length,
      itemBuilder: (_, index) {
        bonus = allianceBonuses[index];

        return Card(
          margin: EdgeInsets.all(0.0),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                AllianceIcon(
                  size: 44.0,
                  name: alliance.name,
                  active: true,
                ),
                SizedBox(width: 4.0),
                AllianceQuantity(
                  maxHeroes: alliance.requiredHeroes,
                  requiredHeroes: alliance.minimumHeroes,
                  currentHeroes: allianceBonuses[index].requiredHeroes,
                  color: getColorByAlliance(alliance.name),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: Text(bonus.description),
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (_, __) => SizedBox(height: 8.0),
    );
  }

  Widget renderListHeroes() {
    if (_allianceDetail == null) return null;
    List<HeroModel> heroes = _allianceDetail.heroes;
    return GridView.count(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: (_orientation == Orientation.portrait) ? 3 : 4,
      mainAxisSpacing: 8.0,
      crossAxisSpacing: 8.0,
      padding: const EdgeInsets.all(8.0),
      childAspectRatio: (_orientation == Orientation.portrait) ? 0.7 : 0.9,
      children: heroes.map<Widget>((HeroModel hero) {
        return HeroView(
          hero: hero,
          useTag: false,
        );
      }).toList(),
    );
  }
}

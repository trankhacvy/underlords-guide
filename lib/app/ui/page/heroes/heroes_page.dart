import 'package:UnderlordsGuru/utility/colors.dart';
import 'package:flutter/material.dart';
import 'package:UnderlordsGuru/app/ui/components/hero_view.dart';
import 'package:UnderlordsGuru/app/ui/components/drawer_menu.dart';
import 'package:UnderlordsGuru/app/model/core/AppProvider.dart';
import 'package:UnderlordsGuru/app/model/core/AppStoreApplication.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// models
import 'package:UnderlordsGuru/app/model/pojo/hero_model.dart';
import 'package:UnderlordsGuru/app/model/pojo/hero_by_tier.dart';
// utils
import 'package:UnderlordsGuru/utility/heroes.dart';

enum DISPLAY_TYPES { BY_NAME, BY_TIER }

class HeroesPage extends StatefulWidget {
  @override
  _HeroesPageState createState() => _HeroesPageState();
}

class _HeroesPageState extends State<HeroesPage> {
  final int crossAxisCount = 3;

  List<HeroModel> _heroes = List();
  List<HeroByTier> _heroesByTier = List();
  bool _loading;
  var _displayType = DISPLAY_TYPES.BY_NAME;
  Orientation _orientation;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _orientation = MediaQuery.of(context).orientation;

    AppStoreApplication application = AppProvider.of(context).application;
    setState(() {
      _loading = true;
    });
    application.dbAppStoreRepository.loadHeroes().then((heroes) {
      setState(() {
        _heroes = heroes;
        _loading = false;
        _heroesByTier = groupHeroesByTier(heroes);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Heroes'), actions: <Widget>[
        IconButton(
          icon: _displayType == DISPLAY_TYPES.BY_NAME
              ? Icon(Icons.sort_by_alpha)
              : Image.asset('images/ic_sort_tier.png', width: 36),
          onPressed: () {
            setState(() {
              _displayType = _displayType == DISPLAY_TYPES.BY_NAME
                  ? DISPLAY_TYPES.BY_TIER
                  : DISPLAY_TYPES.BY_NAME;
            });
          },
        )
      ]),
      drawer: DrawerMenu(),
      body: SafeArea(
        child: _loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: <Widget>[
                  Expanded(
                    child: _displayType == DISPLAY_TYPES.BY_NAME
                        ? _buildHeroesListByName(_heroes)
                        : _buildHeroesListByTier(_heroesByTier),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildHeroesListByName(List<HeroModel> heroes) {
    return GridView.count(
      crossAxisCount: (_orientation == Orientation.portrait) ? 3 : 4,
      mainAxisSpacing: 8.0,
      crossAxisSpacing: 8.0,
      padding: const EdgeInsets.all(8.0),
      childAspectRatio: (_orientation == Orientation.portrait) ? 0.6 : 0.9,
      children: heroes.map<Widget>((HeroModel hero) {
        return HeroView(hero: hero);
      }).toList(),
    );
  }

  Widget _buildHeroesListByTier(List<HeroByTier> heroes) {
    int length = heroes.length;
    HeroByTier heroByTier;
    return StaggeredGridView.countBuilder(
      padding: EdgeInsets.all(8.0),
      crossAxisCount: (_orientation == Orientation.portrait) ? 3 : 4,
      itemCount: length,
      itemBuilder: (BuildContext context, int index) {
        heroByTier = heroes[index];
        if (heroByTier.isHeader) {
          return _buildHeader(heroByTier.header);
        } else {
          return AspectRatio(
            aspectRatio: (_orientation == Orientation.portrait) ? 0.6 : 0.9,
            child: HeroView(hero: heroByTier.hero),
          );
        }
      },
      staggeredTileBuilder: (int index) {
        heroByTier = heroes[index];
        if (heroByTier.isHeader) {
          return StaggeredTile.fit(crossAxisCount);
        } else {
          return StaggeredTile.fit(1);
        }
      },
      mainAxisSpacing: 8.0,
      crossAxisSpacing: 8.0,
    );
  }

  Widget _buildHeader(String tier) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          tier,
          style: TextStyle(
              color: getColorByTier(tier),
              fontWeight: FontWeight.bold,
              fontSize: 18.0),
        ),
        SizedBox(height: 6.0),
        Divider(height: 2.0)
      ],
    );
  }
}

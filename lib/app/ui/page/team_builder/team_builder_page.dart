import 'dart:math' as Math;
import 'package:UnderlordsGuru/app/model/pojo/alliance.dart';
import 'package:UnderlordsGuru/app/model/pojo/hero_model.dart';
import 'package:UnderlordsGuru/app/ui/components/alliance_icon.dart';
import 'package:UnderlordsGuru/utility/colors.dart';
import 'package:UnderlordsGuru/utility/images.dart';
import 'package:flutter/material.dart';
import 'package:UnderlordsGuru/app/model/core/AppProvider.dart';
import 'package:UnderlordsGuru/app/model/core/AppStoreApplication.dart';
import 'package:UnderlordsGuru/app/ui/components/alliance_quantity.dart';
import 'package:UnderlordsGuru/utility/list.dart';

class TeamBuilderPage extends StatefulWidget {
  static const String PATH = '/team-builder';

  @override
  _TeamBuilderPageState createState() => _TeamBuilderPageState();
}

class _TeamBuilderPageState extends State<TeamBuilderPage> {
  TextEditingController _controller;

  List<HeroModel> _heroes = [];
  List<HeroModel> _selectedHeroes = [];
  List<Alliance> _alliances = [];
  List<String> _selectedAlliances = [];

  Map<String, HeroAlliance> _heroesAlliances = Map();

  bool _showAlliances = true;
  bool _showHeroes = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _controller = TextEditingController();

    _loadData();
  }

  _loadData() async {
    AppStoreApplication application = AppProvider.of(context).application;

    var futures = [
      application.dbAppStoreRepository.loadHeroes(),
      application.dbAppStoreRepository.loadAlliances(),
    ];
    var responses = await Future.wait(futures);
    if (responses.length == 2) {
      setState(() {
        _heroes = responses[0];
        _alliances = responses[1];
      });
    }
  }

  _getHeroes() {
    String text = _controller.text;
    return _heroes
        .where((hero) => _selectedAlliances.length == 0
            ? true
            : _check(hero.alliances, _selectedAlliances))
        .where((hero) => hero.name.toLowerCase().contains(text.toLowerCase()))
        .toList();
  }

  _check(List<String> alliances, List<String> selectedAlliances) {
    var items = selectedAlliances.where((val) => alliances.contains(val));
    return items.length > 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Team Builder")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildSearchBar(),
            SizedBox(height: 16.0),
            _buildListAlliances(),
            SizedBox(height: 8.0),
            _buildListHeroes(),
            SizedBox(height: 16.0),
            Text("Board", style: Theme.of(context).textTheme.body2),
            SizedBox(height: 8.0),
            _buildChessBoard(),
            SizedBox(height: 16.0),
            AllianceEffect(
              heroesAlliances: _heroesAlliances,
            ),
            SizedBox(height: 16.0)
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: TextField(
              onEditingComplete: () {
                setState(() {});
              },
              controller: _controller,
              textInputAction: TextInputAction.search,
              cursorColor: Colors.white,
              autocorrect: false,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, color: Colors.white),
                  contentPadding: EdgeInsets.all(8.0),
                  border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10.0),
                      ),
                      borderSide: BorderSide.none),
                  filled: true,
                  hintStyle: TextStyle(color: Colors.white),
                  hintText: "Search...",
                  fillColor: HexColor("#323959"))),
        ),
        SizedBox(width: 8.0),
        ButtonTheme(
          height: 44,
          buttonColor: HexColor("#425e8e"),
          child: RaisedButton(
            padding: EdgeInsets.all(0.0),
            child: Text('Reset'),
            onPressed: _handleReset,
          ),
        )
      ],
    );
  }

  void _handleReset() {
    _controller.clear();
    _selectedHeroes = [];
    _selectedAlliances = [];
    _heroesAlliances = Map();
    setState(() {});
  }

  Widget _buildListAlliances() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _showAlliances = !_showAlliances;
        });
      },
      children: [
        ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              contentPadding: EdgeInsets.all(8.0),
              title:
                  Text('Alliances', style: Theme.of(context).textTheme.body2),
            );
          },
          body: GridView.count(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 8,
            mainAxisSpacing: 6.0,
            crossAxisSpacing: 6.0,
            padding: EdgeInsets.only(left: 8, right: 8, bottom: 16, top: 0),
            childAspectRatio: 1,
            children: _alliances.map<Widget>((item) {
              return AllianceItem(
                  alliance: item,
                  selected: _selectedAlliances.contains(item.name),
                  onItemClick: _handleAllianceClick);
            }).toList(),
          ),
          isExpanded: _showAlliances,
        ),
      ],
    );
  }

  _handleAllianceClick(String alliance) {
    setState(() {
      if (_selectedAlliances.contains(alliance)) {
        _selectedAlliances.remove(alliance);
      } else {
        _selectedAlliances.add(alliance);
      }
    });
  }

  _handleHeroClick(HeroModel hero) {
    if (!_selectedHeroes.contains(hero)) {
      AceEffect aceEffect;
      if (hero.tier == "Ace") {
        aceEffect = hero.aceEffect;
      }
      List<String> alliances = hero.alliances;
      Alliance alliance;
      alliances.forEach((allianceName) {
        alliance = _alliances.firstWhere((all) => all.name == allianceName);

        if (_heroesAlliances.containsKey(allianceName)) {
          _heroesAlliances[allianceName].num =
              _heroesAlliances[allianceName].num + 1;
          if (_heroesAlliances[allianceName].aceEffect == null &&
              aceEffect != null &&
              aceEffect.type
                  .toLowerCase()
                  .contains(allianceName.toLowerCase())) {
            _heroesAlliances[allianceName].aceEffect = aceEffect;
          }
        } else {
          _heroesAlliances[allianceName] = HeroAlliance(
              alliance: alliance,
              num: 1,
              aceEffect: aceEffect != null &&
                      aceEffect.type
                          .toLowerCase()
                          .contains(allianceName.toLowerCase())
                  ? aceEffect
                  : null);
        }
      });
    }
    _selectedHeroes.add(hero);
    setState(() {});
  }

  Widget _buildListHeroes() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _showHeroes = !_showHeroes;
        });
      },
      children: [
        ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              contentPadding: EdgeInsets.all(8.0),
              title: Text('Heroes', style: Theme.of(context).textTheme.body2),
            );
          },
          body: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: 240,
            ),
            child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: 6,
              mainAxisSpacing: 6.0,
              crossAxisSpacing: 6.0,
              padding: const EdgeInsets.only(left: 8, right: 8, bottom: 16),
              childAspectRatio: 1,
              children: _getHeroes().map<Widget>((item) {
                return HeroItem(
                    hero: item,
                    selected: _selectedHeroes.contains(item),
                    onItemClick: _handleHeroClick);
              }).toList(),
            ),
          ),
          isExpanded: _showHeroes,
        ),
      ],
    );
  }

  Widget _buildChessBoard() {
    return GridView.builder(
      padding: EdgeInsets.all(0.0),
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 6.0, crossAxisSpacing: 6.0, crossAxisCount: 5),
      itemCount: 15,
      itemBuilder: (_, index) {
        HeroModel hero =
            index <= _selectedHeroes.length - 1 ? _selectedHeroes[index] : null;
        return BoardItem(
            hero: hero, index: index, onItemClick: _handleBoardItemClick);
      },
    );
  }

  _handleBoardItemClick(HeroModel hero, int index) {
    int count = occuranceInList(_selectedHeroes, hero);
    AceEffect aceEffect = hero.aceEffect;
    if (count == 1) {
      List<String> allianceNames = hero.alliances;
      allianceNames.forEach((allianceName) {
        if (_heroesAlliances.containsKey(allianceName)) {
          _heroesAlliances[allianceName].num =
              Math.max(_heroesAlliances[allianceName].num - 1, 0);

          if (_heroesAlliances[allianceName].aceEffect != null &&
              aceEffect != null &&
              aceEffect.type
                  .toLowerCase()
                  .contains(allianceName.toLowerCase())) {
            _heroesAlliances[allianceName].aceEffect = null;
          }
        }
      });
    }

    _selectedHeroes.removeAt(index);
    setState(() {});
  }
}

class AllianceItem extends StatelessWidget {
  final Alliance alliance;
  final bool selected;
  final Function onItemClick;

  AllianceItem({this.alliance, this.selected = true, this.onItemClick});

  @override
  Widget build(BuildContext context) {
    String icon = ImageHelper.getAllianceIconByName(alliance.name);

    return InkWell(
      onTap: () {
        onItemClick(this.alliance.name);
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(6.0)),
            color: selected
                ? getColorByAlliance(alliance.name)
                : HexColor("#1b1e35")),
        child: Image.asset(selected ? icon.replaceAll(".", "_white.") : icon),
      ),
    );
  }
}

class HeroItem extends StatelessWidget {
  final HeroModel hero;
  final bool selected;
  final Function onItemClick;

  HeroItem({this.hero, this.selected, this.onItemClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onItemClick(this.hero);
      },
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              border: selected
                  ? Border.all(width: 2, color: Colors.white)
                  : Border.all(width: 0, color: Colors.transparent),
              borderRadius: BorderRadius.all(Radius.circular(6.0)),
              image: DecorationImage(
                image: AssetImage(hero.icon),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BoardItem extends StatelessWidget {
  final HeroModel hero;
  final bool selected;
  final bool disabled;
  final int index;
  final Function onItemClick;

  BoardItem(
      {this.hero,
      this.selected = false,
      this.disabled,
      this.index,
      this.onItemClick});

  @override
  Widget build(BuildContext context) {
    if (hero == null) {
      return Container(color: HexColor("#323959"));
    }

    return Container(
      child: InkWell(
        onTap: () {
          onItemClick(this.hero, this.index);
        },
        child: Container(
          decoration: BoxDecoration(
              color: HexColor("#323959"),
              image: DecorationImage(
                image: AssetImage(hero.icon),
              ),
              borderRadius: BorderRadius.all(Radius.circular(6.0))),
        ),
      ),
    );
  }
}

class AllianceEffect extends StatelessWidget {
  final Map<String, HeroAlliance> heroesAlliances;

  List<HeroAlliance> _completeAlliances = [];
  List<HeroAlliance> _incompleteAlliances = [];

  AllianceEffect({this.heroesAlliances}) {
    filterAlliances();
  }

  void filterAlliances() {
    heroesAlliances.forEach((String name, HeroAlliance heroAlliance) {
      Alliance alliance = heroAlliance.alliance;
      if (heroAlliance.num >= alliance.minimumHeroes) {
        _completeAlliances.add(heroAlliance);
      } else {
        _incompleteAlliances.add(heroAlliance);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ListView.separated(
          padding: EdgeInsets.all(0.0),
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: _completeAlliances.length,
          itemBuilder: (_, index) {
            HeroAlliance heroAlliance = _completeAlliances[index];
            Alliance alliance = heroAlliance.alliance;
            AllianceBonus bonus = alliance.allianceBonuses
                .lastWhere((item) => item.requiredHeroes <= heroAlliance.num);
            return Row(
              children: <Widget>[
                AllianceIcon(
                    size: 44.0, name: heroAlliance.alliance.name, active: true),
                SizedBox(width: 4.0),
                AllianceQuantity(
                  maxHeroes: alliance.requiredHeroes,
                  requiredHeroes: alliance.minimumHeroes,
                  currentHeroes: heroAlliance.num,
                  color: getColorByAlliance(alliance.name),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: Text(bonus.description),
                ),
              ],
            );
          },
          separatorBuilder: (_, __) => SizedBox(height: 8.0),
        ),
        SizedBox(height: 8.0),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.start,
          runAlignment: WrapAlignment.start,
          alignment: WrapAlignment.start,
          spacing: 8.0,
          runSpacing: 8.0,
          children: _incompleteAlliances
              .map((heroAlliance) => (Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      AllianceIcon(
                        size: 44.0,
                        name: heroAlliance.alliance.name,
                      ),
                      SizedBox(
                        width: 4.0,
                      ),
                      AllianceQuantity(
                        maxHeroes: heroAlliance.alliance.requiredHeroes,
                        requiredHeroes: heroAlliance.alliance.minimumHeroes,
                        currentHeroes: heroAlliance.num,
                        color: getColorByAlliance(heroAlliance.alliance.name),
                      ),
                    ],
                  )))
              .toList(),
        ),
      ],
    );
  }
}

class HeroAlliance {
  Alliance alliance;
  int num;
  AceEffect aceEffect;

  HeroAlliance({this.alliance, this.num, this.aceEffect});

  increaseNum() {
    this.num = this.num + 1;
  }
}

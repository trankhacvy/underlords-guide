import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:core';
import 'package:UnderlordsGuru/app/model/core/AppStoreApplication.dart';
import 'package:UnderlordsGuru/app/model/core/AppProvider.dart';
import 'package:UnderlordsGuru/app/model/pojo/hero_model.dart';
import 'package:UnderlordsGuru/app/ui/components/custom_tab_bar.dart';
import 'package:UnderlordsGuru/app/ui/components/fade_animated.dart';
import 'package:UnderlordsGuru/app/ui/components/slide_up_panel.dart';
import 'package:UnderlordsGuru/app/ui/page/hero_detail/hero_stats_view.dart';
import 'package:UnderlordsGuru/app/ui/page/hero_detail/hero_skills.dart';
import 'package:UnderlordsGuru/app/ui/page/hero_detail/friend_heroes_view.dart';
import 'package:UnderlordsGuru/app/ui/components/alliance_icon.dart';
import 'package:UnderlordsGuru/utility/colors.dart';

class HeroDetailPage extends StatefulWidget {
  static const String PATH = '/hero';

  static String generatePath(String id, String name, String icon, String tier,
      List<String> alliances) {
    Map<String, dynamic> params = {
      'id': id,
      'name': name,
      'icon': icon,
      'tier': tier,
      'alliances': alliances.join(','),
    };
    Uri uri = Uri(path: PATH, queryParameters: params);
    return uri.toString();
  }

  final int id;
  final String name;
  final String icon;
  final String tier;
  final List<String> alliances;

  HeroDetailPage({this.id, this.name, this.icon, this.tier, this.alliances});

  @override
  _HeroDetailPageState createState() => _HeroDetailPageState();
}

class _HeroDetailPageState extends State<HeroDetailPage>
    with TickerProviderStateMixin {
  GlobalKey _titlePlaceholderKey = GlobalKey();
  GlobalKey _heroNameKey = GlobalKey();

  int id;
  String name;
  String icon;
  String tier;
  List<String> alliances;

  HeroModel _hero;
  bool _loading = true;

  AnimationController _controller;

  AnimationController _startController;

  Animation<double> slideUp;
  Animation<double> _heroNameFontSizeAnimation;
  Animation<double> _fadeAnimation;

  Animation<Offset> _tierMoveAnimation;

  double textDiffLeft = 0.0;
  double textDiffTop = 0.0;

  _HeroDetailPageState({this.id});

  @override
  void initState() {
    this.id = widget.id;
    this.name = widget.name;
    this.icon = widget.icon;
    this.tier = widget.tier;
    this.alliances = widget.alliances;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox _titlePlaceholderRenderBox =
          _titlePlaceholderKey.currentContext.findRenderObject();
      final _titlePlaceholderOffset =
          _titlePlaceholderRenderBox.localToGlobal(Offset.zero);

      final RenderBox heroNameRenderBox =
          _heroNameKey.currentContext.findRenderObject();
      final heroNameOffset = heroNameRenderBox.localToGlobal(Offset.zero);

      textDiffLeft = _titlePlaceholderOffset.dx - heroNameOffset.dx;
      textDiffTop = _titlePlaceholderOffset.dy - heroNameOffset.dy;
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    double height = MediaQuery.of(context).size.height;

    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));

    _startController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));

    _tierMoveAnimation = Tween<Offset>(begin: Offset(50, 0), end: Offset(0, 0))
        .animate(_startController);

    _startController.forward();

    slideUp = Tween<double>(begin: height * 0.4, end: 0).animate(_controller);

    _heroNameFontSizeAnimation = Tween(
      begin: 32.0,
      end: Theme.of(context).textTheme.title.fontSize,
    ).animate(_controller);

    _fadeAnimation = Tween(
      begin: 1.0,
      end: 0.0,
    ).animate(_controller);

    AppStoreApplication application = AppProvider.of(context).application;
    setState(() {
      _loading = true;
    });
    application.dbAppStoreRepository.findHeroById(id).then((hero) {
      setState(() {
        _loading = false;
        _hero = hero;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Opacity(
          opacity: 0,
          child: Text(this.name,
              key: _titlePlaceholderKey,
              style: Theme.of(context).textTheme.title),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          _buildBasicInfo(),
          Positioned(
            left: 0,
            right: 0,
            bottom: MediaQuery.of(context).size.height * 0.5,
            child: _buildHeroImage(),
          ),
          _buildDetailInfo(),
        ],
      ),
    );
  }

  Widget _buildBasicInfo() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      width: double.infinity,
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: _buildHeroName(),
              ),
              SizedBox(width: 8.0),
              _buildHeroTier()
            ],
          ),
          _buildHeroAlliances(),
          SizedBox(height: 16.0),
          // _buildHeroImage(),
        ],
      ),
    );
  }

  Widget _buildDetailInfo() {
    return SlideUpPanel(
        animation: slideUp,
        controller: _controller,
        child: Container(
          child: _loading
              ? Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : CustomTabBar(
                  tabDatas: <TabData>[
                    TabData("Skills", HeroSkills(hero: _hero)),
                    TabData("Stats", HeroStatsView(hero: _hero)),
                    TabData("Allies", FriendHeroesView(hero: _hero)),
                  ],
                ),
        ));
  }

  Widget _buildHeroAlliances() {
    List alliances = this.alliances;

    List<Widget> allianceWidgets = alliances
        .map<Widget>(
          (alliance) => Container(
            margin: EdgeInsets.only(bottom: 4.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                AllianceIcon(name: alliance, active: true),
                SizedBox(width: 4.0),
                Text(alliance)
              ],
            ),
          ),
        )
        .toList();

    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: FadeAnimated(
        animation: _fadeAnimation,
        child: Column(
          children: allianceWidgets,
        ),
      ),
    );
  }

  Widget _buildHeroName() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, chil) {
        return Transform.translate(
          offset: Offset(textDiffLeft * _controller.value,
              textDiffTop * _controller.value),
          child: AnimatedBuilder(
            animation: _heroNameFontSizeAnimation,
            builder: (context, child) {
              return Hero(
                tag: "hero_name_$id",
                child: Material(
                  type: MaterialType.transparency,
                  child: Text(this.name,
                      key: _heroNameKey,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: _heroNameFontSizeAnimation.value,
                      )),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildHeroImage() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: FadeAnimated(
        animation: _fadeAnimation,
        child: Hero(
          tag: "hero_avatar_$id",
          child: Container(
            width: MediaQuery.of(context).size.height * 0.25,
            height: MediaQuery.of(context).size.height * 0.25,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(this.icon),
                  fit: BoxFit.cover,
                ),
                borderRadius: new BorderRadius.all(
                    new Radius.circular(MediaQuery.of(context).size.width / 4)),
                border: new Border.all(
                  color: getColorByTier(this.tier),
                  width: 2.0,
                )),
          ),
        ),
      ),
    );
  }

  Widget _buildHeroTier() {
    var text = Text(
      this.tier,
      style: Theme.of(context)
          .textTheme
          .subtitle
          .copyWith(color: getColorByTier(tier), fontWeight: FontWeight.bold),
    );

    return FadeAnimated(
      animation: _fadeAnimation,
      child: AnimatedBuilder(
        animation: _tierMoveAnimation,
        builder: (context, child) {
          return Transform.translate(
            offset: _tierMoveAnimation.value,
            child: this.tier == 'Ace'
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        'images/ic_ace_hero.png',
                        width: 24.0,
                      ),
                      SizedBox(width: 4.0),
                      text,
                    ],
                  )
                : text,
          );
        },
      ),
    );
  }
}

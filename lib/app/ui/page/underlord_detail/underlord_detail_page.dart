import 'package:flutter/material.dart';
import 'package:UnderlordsGuru/app/ui/components/fade_animated.dart';
import 'package:UnderlordsGuru/utility/colors.dart';
import 'package:UnderlordsGuru/app/model/core/AppProvider.dart';
import 'package:UnderlordsGuru/app/model/core/AppStoreApplication.dart';
import 'package:UnderlordsGuru/app/ui/components/slide_up_panel.dart';
import 'package:UnderlordsGuru/app/ui/components/custom_tab_bar.dart';
import 'package:UnderlordsGuru/app/ui/page/underlord_detail/abilities_view.dart';
import 'package:UnderlordsGuru/app/ui/page/underlord_detail/talents_view.dart';
import 'package:UnderlordsGuru/app/ui/page/underlord_detail/underlord_detail.dart';

class UnderlordDetailPage extends StatefulWidget {
  static const String PATH = '/underlord';

  static String generatePath(
      String id, String name, String avatar, String intro) {
    Map<String, dynamic> params = {
      'id': id,
      'name': name,
      'avatar': avatar,
      'intro': intro,
    };
    Uri uri = Uri(path: PATH, queryParameters: params);
    return uri.toString();
  }

  final int id;
  final String name;
  final String avatar;
  final String intro;

  UnderlordDetailPage({this.id, this.name, this.avatar, this.intro});

  @override
  _UnderlordDetailPageState createState() => _UnderlordDetailPageState();
}

class _UnderlordDetailPageState extends State<UnderlordDetailPage>
    with TickerProviderStateMixin {
  double screenHeight = 0.0;
  final double heightFactor = 0.35;

  AnimationController _controller;
  Animation<double> _slideUpAnimation;
  Animation<double> _fadeAnimation;

  UnderlordDetail _underlord;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    screenHeight = MediaQuery.of(context).size.height;

    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _slideUpAnimation =
        Tween<double>(begin: screenHeight * heightFactor, end: 0)
            .animate(_controller);
    _fadeAnimation = Tween(
      begin: 1.0,
      end: 0.0,
    ).animate(_controller);

    AppStoreApplication application = AppProvider.of(context).application;
    application.dbAppStoreRepository
        .findUnderlordByid(widget.id)
        .then((underlord) {
      setState(() {
        setState(() {
          _underlord = underlord;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.name,
          style: TextStyle(color: getUnderlordColor(widget.name)),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          _buildBasicInfo(),
          _buildDetailInfo(),
        ],
      ),
    );
  }

  _buildBasicInfo() {
    return Container(
      height: MediaQuery.of(context).size.height * heightFactor,
      width: double.infinity,
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          renderAvatar(),
          SizedBox(height: 16.0),
          _renderIntro(context),
        ],
      ),
    );
  }

  _buildDetailInfo() {
    return SlideUpPanel(
        animation: _slideUpAnimation,
        controller: _controller,
        child: CustomTabBar(tabDatas: <TabData>[
          TabData(
              "Abilities",
              AbilitiesView(
                underlord: _underlord,
              )),
          TabData("Talents", TalentsView(underlord: _underlord)),
          TabData(
              "Guides",
              Container(
                child: Center(child: Text("Coming Soon")),
              )),
        ]));
  }

  Widget renderAvatar() {
    return FadeAnimated(
      animation: _fadeAnimation,
      child: Hero(
        tag: "underlord_name_${widget.id}",
        child: Container(
          width: 160,
          height: 160,
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage(widget.avatar),
              fit: BoxFit.cover,
            ),
            borderRadius: new BorderRadius.all(new Radius.circular(80.0)),
            border: new Border.all(
              color: getUnderlordColor(widget.name),
              width: 2.0,
            ),
          ),
        ),
      ),
    );
  }

  _renderIntro(context) {
    return FadeAnimated(
      animation: _fadeAnimation,
      child: Text(widget.intro,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .body2
              .copyWith(color: getUnderlordColor(widget.name))),
    );
  }

  Widget renderTabbar() {
    return Expanded(
      child: CustomTabBar(tabDatas: <TabData>[
        TabData(
            "Abilities",
            Container(
              child: AbilitiesView(),
            )),
        TabData(
            "Stats",
            Container(
              child: Text('tab 2'),
            )),
        TabData(
            "Talents",
            Container(
              child: TalentsView(),
            ))
      ]),
    );
  }
}

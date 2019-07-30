import 'package:UnderlordsGuru/app/ui/page/guides/guide_detail_page.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:UnderlordsGuru/app/ui/page/home/home_page.dart';
import 'package:UnderlordsGuru/app/ui/page/hero_detail/hero_detail_page.dart';
import 'package:UnderlordsGuru/app/ui/page/alliance_detail/alliance_detail.dart';
import 'package:UnderlordsGuru/app/ui/page/underlord_detail/underlord_detail_page.dart';
import 'package:UnderlordsGuru/app/ui/page/team_builder/team_builder_page.dart';
import 'package:UnderlordsGuru/app/ui/page/guides/guide_page.dart';

var rootHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return HomePage();
});

var heroDetailRouteHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  int id = int.parse(params['id']?.first);
  String name = params['name']?.first;
  String icon = params['icon']?.first;
  String tier = params['tier']?.first;
  List<String> alliances = params['alliances']?.first.toString().split(',');

  return HeroDetailPage(
      id: id, name: name, icon: icon, tier: tier, alliances: alliances);
});

var allianceDetailRouteHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  int id = int.parse(params['id']?.first);
  String name = params['name']?.first;
  String icon = params['avatar']?.first;

  return AllianceDetailPage(id: id, name: name, icon: icon);
});

var underlordDetailRouteHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  int id = int.parse(params['id']?.first);
  String name = params['name']?.first;
  String avatar = params['avatar']?.first;
  String intro = params['intro']?.first;

  return UnderlordDetailPage(id: id, name: name, avatar: avatar, intro: intro);
});

var teamBuilderRouteHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return TeamBuilderPage();
});

var guidesRouteHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return GuidePage();
});

var guideDetailRouteHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  int id = int.parse(params['id']?.first);
  String title = params['title']?.first;

  return GuideDetailPage(
    id: id,
    title: title,
  );
});

class AppRoutes {
  static void configureRoutes(Router router) {
    router.notFoundHandler = new Handler(
        handlerFunc: (_, __) {
      print('ROUTE WAS NOT FOUND !!!');
      return null;
    });

    router.define(HomePage.PATH, handler: rootHandler);
    router.define(HeroDetailPage.PATH, handler: heroDetailRouteHandler);
    router.define(AllianceDetailPage.PATH, handler: allianceDetailRouteHandler);
    router.define(UnderlordDetailPage.PATH,
        handler: underlordDetailRouteHandler);
    router.define(TeamBuilderPage.PATH, handler: teamBuilderRouteHandler);
    router.define(GuidePage.PATH, handler: guidesRouteHandler);
    router.define(GuideDetailPage.PATH, handler: guideDetailRouteHandler);
  }
}

import 'package:UnderlordsGuru/app/ui/components/about_me.dart';
import 'package:UnderlordsGuru/app/ui/components/feed_back.dart';
import 'package:UnderlordsGuru/app/ui/page/guides/guide_page.dart';
import 'package:UnderlordsGuru/app/ui/page/team_builder/team_builder_page.dart';
import 'package:flutter/material.dart';
import 'package:UnderlordsGuru/app/model/core/AppProvider.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerMenu extends StatefulWidget {
  @override
  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.all(0.0),
        children: <Widget>[
          _buildHeader(),
          ListTile(
            title: Text('Team Builder'),
            onTap: () {
              Navigator.of(context).pop();
              AppProvider.getRouter(context).navigateTo(
                  context, TeamBuilderPage.PATH,
                  transition: TransitionType.fadeIn);
            },
          ),
          ListTile(
            title: Text('Guides'),
            onTap: () {
              Navigator.of(context).pop();
              AppProvider.getRouter(context).navigateTo(context, GuidePage.PATH,
                  transition: TransitionType.fadeIn);
            },
          ),
          Divider(height: 2),
          ListTile(
            title: Text('About App'),
            onTap: () {
              Navigator.of(context).pop();
              showGalleryAboutDialog(context);
            },
          ),
          ListTile(
            title: Text('Rate App'),
            onTap: () {
              Navigator.of(context).pop();
              launch(
                  "https://play.google.com/store/apps/details?id=${DotEnv().env['APP_ID']}",
                  forceSafariVC: true);
            },
          ),
          ListTile(
            title: Text('Send Feedback'),
            onTap: () {
              Navigator.of(context).pop();
              showSendFeedbackDialog(context);
            },
          ),
          ListTile(
            title: Text('By Me A Coffee'),
            onTap: () {
              Navigator.of(context).pop();
              launch(DotEnv().env['BUY_ME_COFFEE'], forceSafariVC: true);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fitWidth,
                image: AssetImage('images/underlord_banner.png'))),
        child: Stack(children: <Widget>[
          Positioned(
            bottom: 8.0,
            left: 16,
            right: 16,
            child: Image.asset("images/underlord_text.png"),
          ),
        ]));
  }
}

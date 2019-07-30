import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

class _LinkTextSpan extends TextSpan {
  _LinkTextSpan({TextStyle style, String url, String text})
      : super(
            style: style,
            text: text ?? url,
            recognizer: TapGestureRecognizer()
              ..onTap = () async {
                if (await canLaunch(url)) {
                  await launch(url, forceSafariVC: true);
                } else {
                  throw 'Could not launch $url';
                }
              });
}

void showGalleryAboutDialog(BuildContext context) async {
  final ThemeData themeData = Theme.of(context);
  final TextStyle titleTextStyle = themeData.textTheme.headline;
  final TextStyle aboutTextStyle = themeData.textTheme.body1;
  final TextStyle linkStyle =
      themeData.textTheme.body1.copyWith(color: themeData.accentColor);

  LicenseRegistry.addLicense(() {
    return Stream<LicenseEntry>.fromIterable(<LicenseEntry>[
      const LicenseEntryWithLineBreaks(
          <String>['Pirate package '], 'Pirate license'),
    ]);
  });

  showAboutDialog(
    context: context,
    applicationVersion: 'Version 1.0.0',
    applicationIcon: Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("images/app_icon.png")),
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
    ),
    applicationLegalese: null,
    children: <Widget>[
      RichText(
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
                style: aboutTextStyle,
                text:
                    'This is unofficial guide app for Dota Underlords. Help you look up everything about Hero damages, Alliance effects, Items, Underlords etc. Also known as Companion / Assistant / Wiki for Dota Underlords. With this app, you will be unbeatable.'),
            TextSpan(
                text:
                    "\n\nTo see the source code for this app, please visit the ",
                style: aboutTextStyle),
            _LinkTextSpan(
              text: 'github repo',
              style: linkStyle,
              url: 'https://github.com/Levi-ackerman/underlords-guide',
            ),
            TextSpan(
              style: aboutTextStyle,
              text: '.',
            ),
          ],
        ),
      ),
      Padding(
        padding: EdgeInsets.only(top: 16.0, bottom: 8.0),
        child: Text('Developer info', style: titleTextStyle),
      ),
      RichText(
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(style: aboutTextStyle, text: 'Tran Khac Vy \t'),
            _LinkTextSpan(
              text: '@trankhacvy',
              style: linkStyle,
              url:
                  'https://www.linkedin.com/in/kh%E1%BA%AFc-v%E1%BB%B9-0b3473154/',
            ),
            TextSpan(
              style: aboutTextStyle,
              text: '/',
            ),
            _LinkTextSpan(
              text: 'Github',
              style: linkStyle,
              url: 'https://github.com/Levi-ackerman',
            ),
            TextSpan(
              style: aboutTextStyle,
              text: '.',
            ),
          ],
        ),
      ),
    ],
  );
}

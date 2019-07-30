import 'package:UnderlordsGuru/app/model/core/AppProvider.dart';
import 'package:UnderlordsGuru/app/model/core/AppStoreApplication.dart';
import 'package:UnderlordsGuru/app/model/pojo/guide.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;
import 'package:UnderlordsGuru/utility/colors.dart';
import 'package:youtube_player/youtube_player.dart';

class GuideDetailPage extends StatefulWidget {
  static const String PATH = '/guides-detail';

  static String generatePath(int id, String title) {
    Map<String, dynamic> params = {
      'id': id.toString(),
      'title': title,
    };
    Uri uri = Uri(path: PATH, queryParameters: params);
    return uri.toString();
  }

  final int id;
  final String title;

  GuideDetailPage({this.id, this.title});

  @override
  _GuideDetailPageState createState() => _GuideDetailPageState();
}

class _GuideDetailPageState extends State<GuideDetailPage> {
  GuideDetail _guide;
  bool _loading;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    AppStoreApplication application = AppProvider.of(context).application;
    setState(() {
      _loading = true;
    });
    application.dbAppStoreRepository
        .findGuideDetailById(widget.id)
        .then((guide) {
      setState(() {
        _guide = guide;
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: buildGuide(),
      ),
    );
  }

  Widget buildGuide() {
    if (_loading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Card(
      margin: EdgeInsets.all(0.0),
      child: _guide.isVideo == 1
          ? Center(
              child: YoutubePlayer(
              context: context,
              source: _guide.content,
              quality: YoutubeQuality.HD,
              callbackController: (controller) {},
            ))
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Html(
                  data: _guide.content,
                  useRichText: false,
                  padding: EdgeInsets.all(16.0),
                  customRender: (node, children) {
                    if (node is dom.Element) {
                      switch (node.localName) {
                        case "noscript":
                          return Container();
                        case "a":
                          return InkWell(
                            onTap: () {
                              String href = node.attributes['href'];
                              if (href.indexOf("http://") < 0 &&
                                  href.indexOf("https://") < 0) {
                                href = "${_guide.baseUrl}$href";
                              }
                              _launchURL(href);
                            },
                            child: Text(
                              node.text,
                              style: TextStyle(color: HexColor(LINK_COLOR)),
                            ),
                          );
                      }
                    }
                    return null;
                  },
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  child: RichText(
                    text: TextSpan(
                        text: 'Source:',
                        style: Theme.of(context).textTheme.body2,
                        children: <TextSpan>[
                          TextSpan(
                              text: ' ${_guide.sourceUrl}',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(
                                      decoration: TextDecoration.underline,
                                      color: Colors.white),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  _launchURL(_guide.sourceUrl);
                                })
                        ]),
                  ),
                ),
              ],
            ),
    );
  }

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

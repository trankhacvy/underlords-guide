import 'package:UnderlordsGuru/app/model/core/AppStoreApplication.dart';
import 'package:UnderlordsGuru/app/model/pojo/guide.dart';
import 'package:UnderlordsGuru/app/ui/page/guides/guide_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:UnderlordsGuru/app/model/core/AppProvider.dart';
import 'package:fluro/fluro.dart';

class GuidePage extends StatefulWidget {
  static const String PATH = '/guides';

  @override
  _GuidePageState createState() => _GuidePageState();
}

class _GuidePageState extends State<GuidePage> {
  List<Guide> _listGuides = [];
  List<bool> _listExpanded = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    AppStoreApplication application = AppProvider.of(context).application;
    application.dbAppStoreRepository.getGuides().then((guides) {
      setState(() {
        _listGuides = guides;
        _listExpanded = List.generate(guides.length, (index) => false);
      });
    });
  } /*  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Guides"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12.0),
        child: buildListGuides(),
      ),
    );
  }

  Widget buildListGuides() {
    List<ExpansionPanel> children = [];

    for (var i = 0; i < _listGuides.length; i++) {
      List<GuideDetail> guides = _listGuides[i].guides;

      children.add(ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              contentPadding: EdgeInsets.all(8.0),
              title: Text(_listGuides[i].title,
                  style: Theme.of(context).textTheme.body2),
            );
          },
          body: ListView.separated(
            padding: EdgeInsets.all(8.0),
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: guides.length,
            itemBuilder: (_, index) {
              GuideDetail detail = guides[index];
              return GuideItem(
                guide: detail,
                onItemClick: _handleItemClick,
              );
            },
            separatorBuilder: (_, __) => SizedBox(
              height: 8.0,
            ),
          ),
          isExpanded: _listExpanded[i]));
    }

    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _listExpanded[index] = !isExpanded;
        });
      },
      children: children,
    );
  }

  void _handleItemClick(GuideDetail item) {
    AppProvider.getRouter(context).navigateTo(
        context, GuideDetailPage.generatePath(item.id, item.title),
        transition: TransitionType.fadeIn);
  }
}

class GuideItem extends StatelessWidget {
  final GuideDetail guide;
  final Function onItemClick;

  GuideItem({this.guide, this.onItemClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onItemClick(guide);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.network(
            guide.thumbnail,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    guide.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.body2,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    guide.shortDescription,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

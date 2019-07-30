import 'package:UnderlordsGuru/app/ui/components/drawer_menu.dart';
import 'package:flutter/material.dart';
import 'package:UnderlordsGuru/app/ui/components/item_view.dart';
import 'package:UnderlordsGuru/app/model/core/AppProvider.dart';
import 'package:UnderlordsGuru/app/model/core/AppStoreApplication.dart';
import 'package:UnderlordsGuru/app/model/pojo/item.dart';
import 'package:UnderlordsGuru/app/model/pojo/item_by_tier.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:UnderlordsGuru/utility/heroes.dart';
import 'package:UnderlordsGuru/utility/colors.dart';
import 'package:UnderlordsGuru/utility/images.dart';

enum DISPLAY_TYPES { BY_NAME, BY_TIER }

class ItemsPage extends StatefulWidget {
  ItemsPage();

  @override
  _ItemsPageState createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {
  Orientation _orientation;

  final int crossAxisCount = 3;

  List<Item> _items = [];
  var _displayType = DISPLAY_TYPES.BY_NAME;

  _ItemsPageState();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _orientation = MediaQuery.of(context).orientation;

    AppStoreApplication application = AppProvider.of(context).application;
    application.dbAppStoreRepository.loadItems().then((items) {
      setState(() {
        _items = items;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Items'), actions: <Widget>[
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
      body: _displayType == DISPLAY_TYPES.BY_NAME
          ? GridView.count(
              crossAxisCount: (_orientation == Orientation.portrait) ? 3 : 5,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              padding: const EdgeInsets.all(8.0),
              childAspectRatio:
                  (_orientation == Orientation.portrait) ? 0.65 : 0.9,
              children: _items.map<Widget>((Item item) {
                return ItemView(item: item, onItemClick: _onItemClick);
              }).toList(),
            )
          : this.buildItemsListByTier(groupItemsByTier(_items, true)),
    );
  }

  Widget buildItemsListByTier(List<ItemByTier> items) {
    int length = items.length;
    ItemByTier itemByTier;
    return StaggeredGridView.countBuilder(
      padding: EdgeInsets.all(8.0),
      crossAxisCount: crossAxisCount,
      itemCount: length,
      itemBuilder: (BuildContext context, int index) {
        itemByTier = items[index];
        if (itemByTier.isHeader) {
          return buildHeader(itemByTier.header);
        } else {
          return AspectRatio(
            aspectRatio: (_orientation == Orientation.portrait) ? 0.6 : 0.9,
            child: ItemView(item: itemByTier.item, onItemClick: _onItemClick),
          );
        }
      },
      staggeredTileBuilder: (int index) {
        itemByTier = items[index];
        if (itemByTier.isHeader) {
          return StaggeredTile.fit(crossAxisCount);
        } else {
          return StaggeredTile.fit(1);
        }
      },
      mainAxisSpacing: 8.0,
      crossAxisSpacing: 8.0,
    );
  }

  Widget buildHeader(String tier) {
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

  _onItemClick(Item item) {
    showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: CustomDialog(item: item),
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 200),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {
          return Container();
        });
  }
}

class CustomDialog extends StatelessWidget {
  static const double padding = 16.0;
  static const double avatarRadius = 66.0;

  final Item item;

  CustomDialog({this.item});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: <Widget>[
          renderCard(context),
          Positioned(
            left: padding,
            right: padding,
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: avatarRadius,
              child: Image.network(item.icon),
            ),
          ),
        ],
      ),
    );
  }

  renderCard(context) {
    return Container(
      padding: EdgeInsets.only(
        top: avatarRadius + padding,
        bottom: padding,
        left: padding,
        right: padding,
      ),
      margin: EdgeInsets.only(top: avatarRadius / 2 + padding),
      decoration: new BoxDecoration(
        color: Theme.of(context).backgroundColor,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(padding),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: const Offset(0.0, 10.0),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            item.name,
            style: Theme.of(context)
                .textTheme
                .headline
                .copyWith(color: getColorByTier(item.tier)),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Image.asset(ImageHelper.getItemTypeIcon(item.type)),
                    SizedBox(width: 8.0),
                    Text(item.type)
                  ],
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Text(item.tier,
                    style: Theme.of(context).textTheme.body2.copyWith(
                          color: getColorByTier(item.tier),
                        )),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          Text(item.effect, textAlign: TextAlign.start),
        ],
      ),
    );
  }
}

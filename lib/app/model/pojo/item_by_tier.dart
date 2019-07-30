import 'package:UnderlordsGuru/app/model/pojo/item.dart';

class ItemByTier {
  bool isHeader;
  String header;
  Item item;

  ItemByTier.isHeader({this.header, this.isHeader = true});

  ItemByTier.isItem({this.item, this.isHeader = false});

}

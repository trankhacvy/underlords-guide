import 'package:json_annotation/json_annotation.dart';
part 'item.g.dart';

@JsonSerializable(nullable: false)
class Item {
  int id;
  String name;
  String icon;
  String tier;
  String type;
  String effect;

  Item({this.id, this.name, this.icon, this.tier, this.type, this.effect});

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);

  @override
  String toString() {
    return "id: $id, name: $name";
  }
}

import 'package:json_annotation/json_annotation.dart';
import 'package:UnderlordsGuru/app/model/pojo/underlord_ability.dart';
part 'underlord.g.dart';

@JsonSerializable(nullable: false)
class Underlord {
  int id;
  String name;
  String avatar;
  String icon;
  String intro;
  String playerLevel;
  String damage;
  String attackRate;
  String dps;
  String health;
  String armor;
  @JsonKey(nullable: true)
  List<UnderlordAbility> abilities;

  Underlord(
      {this.id,
      this.name,
      this.avatar,
      this.icon,
      this.intro,
      this.playerLevel,
      this.damage,
      this.attackRate,
      this.dps,
      this.health,
      this.armor});

  factory Underlord.fromJson(Map<String, dynamic> json) =>
      _$UnderlordFromJson(json);

  Map<String, dynamic> toJson() => _$UnderlordToJson(this);
}

import 'package:json_annotation/json_annotation.dart';
part 'alliance.g.dart';

@JsonSerializable(nullable: false)
class Alliance {
  int id;
  String name;
  String icon;
  int requiredHeroes;
  int minimumHeroes;

  @JsonKey(nullable: true)
  List<AllianceBonus> allianceBonuses;

  Alliance(
      {this.id,
      this.name,
      this.icon,
      this.requiredHeroes,
      this.minimumHeroes,
      this.allianceBonuses});

  factory Alliance.fromJson(Map<String, dynamic> json) =>
      _$AllianceFromJson(json);

  Map<String, dynamic> toJson() => _$AllianceToJson(this);

  @override
  String toString() {
    return "id: $id, name: $name, Bonuses:$allianceBonuses";
  }
}

@JsonSerializable(nullable: false)
class AllianceBonus {
  int id;
  String description;
  String icon;
  int requiredHeroes;

  AllianceBonus({this.id, this.description, this.icon, this.requiredHeroes});

  factory AllianceBonus.fromJson(Map<String, dynamic> json) =>
      _$AllianceBonusFromJson(json);

  Map<String, dynamic> toJson() => _$AllianceBonusToJson(this);
}

import 'package:json_annotation/json_annotation.dart';
part 'underlord_talent.g.dart';

@JsonSerializable(nullable: true)
class UnderlordTalent {
  int id;
  int underlordId;
  String name;
  String icon;
  String damageType;
  String effect;
  String notes;
  String forAbility;
  int round;

  UnderlordTalent(
      {this.id,
      this.underlordId,
      this.name,
      this.icon,
      this.damageType,
      this.effect,
      this.notes,
      this.forAbility,
      this.round});

  factory UnderlordTalent.fromJson(Map<String, dynamic> json) =>
      _$UnderlordTalentFromJson(json);

  Map<String, dynamic> toJson() => _$UnderlordTalentToJson(this);
}

import 'package:json_annotation/json_annotation.dart';
part 'underlord_ability.g.dart';

@JsonSerializable(nullable: true)
class UnderlordAbility {
  int id;
  int underlordId;
  int ultimate;
  String name;
  String icon;
  String cooldown;
  String hypeRequirement;
  String damageType;
  String effect;
  String notes;

  UnderlordAbility(
      {this.id,
      this.underlordId,
      this.ultimate,
      this.name,
      this.icon,
      this.cooldown,
      this.hypeRequirement,
      this.damageType,
      this.effect,
      this.notes});

  factory UnderlordAbility.fromJson(Map<String, dynamic> json) =>
      _$UnderlordAbilityFromJson(json);

  Map<String, dynamic> toJson() => _$UnderlordAbilityToJson(this);
}

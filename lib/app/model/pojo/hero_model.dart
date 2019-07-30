import 'dart:convert' as convert;
import 'package:json_annotation/json_annotation.dart';
import 'package:UnderlordsGuru/utility/images.dart';
part 'hero_model.g.dart';

@JsonSerializable(nullable: true)
class HeroModel {
  int id;
  final String name;
  final String tier;
  final String armor;
  final String mana;
  final String attackRange;
  final String attackSpeed;
  final String avatar; // network image
  final String icon; // local image
  final String dps;
  final String damage;
  final String health;
  final String healthRegen;
  final String magicResist;
  final String moveSpeed;
  @JsonKey(nullable: true)
  List<Ability> abilities;
  final AceEffect aceEffect;
  final String _alliances;

  List<String> get alliances => _alliances.split(';');

  Map<String, String> get alliancesIcon =>
      Map<String, String>.fromIterable(_alliances.split(';'),
          key: (item) => item,
          value: (item) => ImageHelper.getAllianceIconByName(item));

  HeroModel(
      {this.id,
      this.name,
      this.tier,
      this.armor,
      this.mana,
      this.attackRange,
      this.attackSpeed,
      this.avatar,
      this.icon,
      this.dps,
      this.damage,
      this.health,
      this.healthRegen,
      this.magicResist,
      this.moveSpeed,
      this.abilities,
      this.aceEffect,
      alliances})
      : _alliances = alliances;

  factory HeroModel.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> mofidiableMap = Map.from(json);

    if (mofidiableMap.containsKey('aceEffect')) {
      String aceEffectStr = mofidiableMap['aceEffect'];
      if (aceEffectStr != '') {
        mofidiableMap['aceEffect'] =
            convert.jsonDecode(mofidiableMap['aceEffect']);
      } else {
        mofidiableMap['aceEffect'] = Map<String, dynamic>();
      }
    }

    return _$HeroModelFromJson(mofidiableMap);
  }

  Map<String, dynamic> toJson() => _$HeroModelToJson(this);

  @override
  String toString() {
    return "name : ${this.name} icon ${this.icon}";
  }
}

@JsonSerializable(nullable: false)
class Ability {
  int id;
  String name;
  String icon;
  String manaCost;
  String cooldown;
  String effect;

  Ability(
      {this.id,
      this.name,
      this.icon,
      this.manaCost = '',
      this.cooldown = '',
      this.effect = ''});

  String getIcon() {
    String file = this.name.toLowerCase().replaceAll(" ", "");
    return "images/skill_$file.png";
  }

  factory Ability.fromJson(Map<String, dynamic> json) =>
      _$AbilityFromJson(json);

  Map<String, dynamic> toJson() => _$AbilityToJson(this);

  @override
  String toString() {
    return "id: $id, name: $name, manaCost: $manaCost, cooldown: $cooldown, effect: $effect";
  }
}

@JsonSerializable(nullable: false)
class AceEffect {
  String type;
  String effect;

  AceEffect({this.type, this.effect});

  factory AceEffect.fromJson(Map<String, dynamic> json) =>
      _$AceEffectFromJson(json);

  Map<String, dynamic> toJson() => _$AceEffectToJson(this);
}

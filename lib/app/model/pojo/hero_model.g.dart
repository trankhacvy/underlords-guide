// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hero_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HeroModel _$HeroModelFromJson(Map<String, dynamic> json) {
  return HeroModel(
      id: json['id'] as int,
      name: json['name'] as String,
      tier: json['tier'] as String,
      armor: json['armor'] as String,
      mana: json['mana'] as String,
      attackRange: json['attackRange'] as String,
      attackSpeed: json['attackSpeed'] as String,
      avatar: json['avatar'] as String,
      icon: json['icon'] as String,
      dps: json['dps'] as String,
      damage: json['damage'] as String,
      health: json['health'] as String,
      healthRegen: json['healthRegen'] as String,
      magicResist: json['magicResist'] as String,
      moveSpeed: json['moveSpeed'] as String,
      abilities: (json['abilities'] as List)
          ?.map((e) =>
              e == null ? null : Ability.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      aceEffect: json['aceEffect'] == null
          ? null
          : AceEffect.fromJson(json['aceEffect'] as Map<String, dynamic>),
      alliances: json['alliances']);
}

Map<String, dynamic> _$HeroModelToJson(HeroModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'tier': instance.tier,
      'armor': instance.armor,
      'mana': instance.mana,
      'attackRange': instance.attackRange,
      'attackSpeed': instance.attackSpeed,
      'avatar': instance.avatar,
      'icon': instance.icon,
      'dps': instance.dps,
      'damage': instance.damage,
      'health': instance.health,
      'healthRegen': instance.healthRegen,
      'magicResist': instance.magicResist,
      'moveSpeed': instance.moveSpeed,
      'abilities': instance.abilities,
      'aceEffect': instance.aceEffect,
      'alliances': instance.alliances
    };

Ability _$AbilityFromJson(Map<String, dynamic> json) {
  return Ability(
      id: json['id'] as int,
      name: json['name'] as String,
      icon: json['icon'] as String,
      manaCost: json['manaCost'] as String,
      cooldown: json['cooldown'] as String,
      effect: json['effect'] as String);
}

Map<String, dynamic> _$AbilityToJson(Ability instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'icon': instance.icon,
      'manaCost': instance.manaCost,
      'cooldown': instance.cooldown,
      'effect': instance.effect
    };

AceEffect _$AceEffectFromJson(Map<String, dynamic> json) {
  return AceEffect(
      type: json['type'] as String, effect: json['effect'] as String);
}

Map<String, dynamic> _$AceEffectToJson(AceEffect instance) =>
    <String, dynamic>{'type': instance.type, 'effect': instance.effect};

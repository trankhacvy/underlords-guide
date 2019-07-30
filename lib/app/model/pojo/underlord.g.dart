// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'underlord.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Underlord _$UnderlordFromJson(Map<String, dynamic> json) {
  return Underlord(
      id: json['id'] as int,
      name: json['name'] as String,
      avatar: json['avatar'] as String,
      icon: json['icon'] as String,
      intro: json['intro'] as String,
      playerLevel: json['playerLevel'] as String,
      damage: json['damage'] as String,
      attackRate: json['attackRate'] as String,
      dps: json['dps'] as String,
      health: json['health'] as String,
      armor: json['armor'] as String)
    ..abilities = (json['abilities'] as List)
        ?.map((e) => e == null
            ? null
            : UnderlordAbility.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$UnderlordToJson(Underlord instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatar': instance.avatar,
      'icon': instance.icon,
      'intro': instance.intro,
      'playerLevel': instance.playerLevel,
      'damage': instance.damage,
      'attackRate': instance.attackRate,
      'dps': instance.dps,
      'health': instance.health,
      'armor': instance.armor,
      'abilities': instance.abilities
    };

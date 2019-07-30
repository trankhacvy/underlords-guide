// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'underlord_ability.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnderlordAbility _$UnderlordAbilityFromJson(Map<String, dynamic> json) {
  return UnderlordAbility(
      id: json['id'] as int,
      underlordId: json['underlordId'] as int,
      ultimate: json['ultimate'] as int,
      name: json['name'] as String,
      icon: json['icon'] as String,
      cooldown: json['cooldown'] as String,
      hypeRequirement: json['hypeRequirement'] as String,
      damageType: json['damageType'] as String,
      effect: json['effect'] as String,
      notes: json['notes'] as String);
}

Map<String, dynamic> _$UnderlordAbilityToJson(UnderlordAbility instance) =>
    <String, dynamic>{
      'id': instance.id,
      'underlordId': instance.underlordId,
      'ultimate': instance.ultimate,
      'name': instance.name,
      'icon': instance.icon,
      'cooldown': instance.cooldown,
      'hypeRequirement': instance.hypeRequirement,
      'damageType': instance.damageType,
      'effect': instance.effect,
      'notes': instance.notes
    };

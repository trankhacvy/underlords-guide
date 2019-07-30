// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'underlord_talent.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnderlordTalent _$UnderlordTalentFromJson(Map<String, dynamic> json) {
  return UnderlordTalent(
      id: json['id'] as int,
      underlordId: json['underlordId'] as int,
      name: json['name'] as String,
      icon: json['icon'] as String,
      damageType: json['damageType'] as String,
      effect: json['effect'] as String,
      notes: json['notes'] as String,
      forAbility: json['forAbility'] as String,
      round: json['round'] as int);
}

Map<String, dynamic> _$UnderlordTalentToJson(UnderlordTalent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'underlordId': instance.underlordId,
      'name': instance.name,
      'icon': instance.icon,
      'damageType': instance.damageType,
      'effect': instance.effect,
      'notes': instance.notes,
      'forAbility': instance.forAbility,
      'round': instance.round
    };

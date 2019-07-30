// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alliance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Alliance _$AllianceFromJson(Map<String, dynamic> json) {
  return Alliance(
      id: json['id'] as int,
      name: json['name'] as String,
      icon: json['icon'] as String,
      requiredHeroes: json['requiredHeroes'] as int,
      minimumHeroes: json['minimumHeroes'] as int,
      allianceBonuses: (json['allianceBonuses'] as List)
          ?.map((e) => e == null
              ? null
              : AllianceBonus.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$AllianceToJson(Alliance instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'icon': instance.icon,
      'requiredHeroes': instance.requiredHeroes,
      'minimumHeroes': instance.minimumHeroes,
      'allianceBonuses': instance.allianceBonuses
    };

AllianceBonus _$AllianceBonusFromJson(Map<String, dynamic> json) {
  return AllianceBonus(
      id: json['id'] as int,
      description: json['description'] as String,
      icon: json['icon'] as String,
      requiredHeroes: json['requiredHeroes'] as int);
}

Map<String, dynamic> _$AllianceBonusToJson(AllianceBonus instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'icon': instance.icon,
      'requiredHeroes': instance.requiredHeroes
    };

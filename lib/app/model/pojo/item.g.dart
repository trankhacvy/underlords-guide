// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Item _$ItemFromJson(Map<String, dynamic> json) {
  return Item(
      id: json['id'] as int,
      name: json['name'] as String,
      icon: json['icon'] as String,
      tier: json['tier'] as String,
      type: json['type'] as String,
      effect: json['effect'] as String);
}

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'icon': instance.icon,
      'tier': instance.tier,
      'type': instance.type,
      'effect': instance.effect
    };

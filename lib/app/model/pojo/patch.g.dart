// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patch.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Patch _$PatchFromJson(Map<String, dynamic> json) {
  return Patch(
      id: json['id'] as int,
      title: json['title'] as String,
      publishDate: json['publishDate'] as String,
      content: json['content'] as String);
}

Map<String, dynamic> _$PatchToJson(Patch instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'publishDate': instance.publishDate,
      'content': instance.content
    };

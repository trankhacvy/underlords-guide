// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guide.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Guide _$GuideFromJson(Map<String, dynamic> json) {
  return Guide(
      id: json['id'] as int,
      title: json['title'] as String,
      guides: (json['guides'] as List)
          ?.map((e) => e == null
              ? null
              : GuideDetail.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$GuideToJson(Guide instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'guides': instance.guides
    };

GuideDetail _$GuideDetailFromJson(Map<String, dynamic> json) {
  return GuideDetail(
      json['id'] as int,
      json['title'] as String,
      json['shortDescription'] as String,
      json['thumbnail'] as String,
      json['content'] as String,
      json['baseUrl'] as String,
      json['sourceUrl'] as String,
      json['isVideo'] as int);
}

Map<String, dynamic> _$GuideDetailToJson(GuideDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'shortDescription': instance.shortDescription,
      'thumbnail': instance.thumbnail,
      'content': instance.content,
      'baseUrl': instance.baseUrl,
      'sourceUrl': instance.sourceUrl,
      'isVideo': instance.isVideo
    };

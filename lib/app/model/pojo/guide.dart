import 'package:json_annotation/json_annotation.dart';
part 'guide.g.dart';

@JsonSerializable(nullable: true)
class Guide {
  int id;
  String title;
  @JsonKey(nullable: true)
  List<GuideDetail> guides;

  Guide({this.id, this.title, this.guides});

  factory Guide.fromJson(Map<String, dynamic> json) => _$GuideFromJson(json);

  Map<String, dynamic> toJson() => _$GuideToJson(this);

  @override
  String toString() {
    return "id: $id, title: $title";
  }
}

@JsonSerializable(nullable: true)
class GuideDetail {
  int id;
  String title;
  String shortDescription;
  String thumbnail;
  String content;
  String baseUrl;
  String sourceUrl;
  int isVideo; // 1 true, 0 false

  GuideDetail(this.id, this.title, this.shortDescription, this.thumbnail,
      this.content, this.baseUrl, this.sourceUrl, this.isVideo);

  factory GuideDetail.fromJson(Map<String, dynamic> json) =>
      _$GuideDetailFromJson(json);

  Map<String, dynamic> toJson() => _$GuideDetailToJson(this);
}

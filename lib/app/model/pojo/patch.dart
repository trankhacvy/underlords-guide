import 'package:json_annotation/json_annotation.dart';
part 'patch.g.dart';

@JsonSerializable(nullable: false)
class Patch {
  int id;
  String title;
  String publishDate;
  String content;

  Patch({this.id, this.title, this.publishDate, this.content});

  DateTime get date  => DateTime.parse(this.publishDate);

  factory Patch.fromJson(Map<String, dynamic> json) => _$PatchFromJson(json);

  Map<String, dynamic> toJson() => _$PatchToJson(this);

  @override
  String toString() {
    return "id: $id, name: $title";
  }
}

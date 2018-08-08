import 'package:json_annotation/json_annotation.dart';
part 'coverage.g.dart';

@JsonSerializable()
class Coverage extends Object with _$CoverageSerializerMixin{
  @JsonKey(name: 'Id')
  int id;
  @JsonKey(name: 'Name')
  String name;
  @JsonKey(name: 'Description')
  String description;

  Coverage({this.id, this.name, this.description});

  factory Coverage.fromJson(Map<String, dynamic> json) => _$CoverageFromJson(json);
}
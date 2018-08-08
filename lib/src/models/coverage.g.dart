// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coverage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Coverage _$CoverageFromJson(Map<String, dynamic> json) {
  return new Coverage(
      id: json['Id'] as int,
      name: json['Name'] as String,
      description: json['Description'] as String);
}

abstract class _$CoverageSerializerMixin {
  int get id;
  String get name;
  String get description;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'Id': id, 'Name': name, 'Description': description};
}

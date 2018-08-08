// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insurance_company.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InsuranceCompany _$InsuranceCompanyFromJson(Map<String, dynamic> json) {
  return new InsuranceCompany(
      id: json['Id'] as int, name: json['Name'] as String);
}

abstract class _$InsuranceCompanySerializerMixin {
  int get id;
  String get name;
  Map<String, dynamic> toJson() => <String, dynamic>{'Id': id, 'Name': name};
}

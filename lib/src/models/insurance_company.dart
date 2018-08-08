import 'package:json_annotation/json_annotation.dart';

part 'insurance_company.g.dart';

@JsonSerializable()
class InsuranceCompany extends Object with _$InsuranceCompanySerializerMixin{
  @JsonKey(name: 'Id')
  int id;
  @JsonKey(name: 'Name')
  String name;

  InsuranceCompany({this.id, this.name});

  factory InsuranceCompany.fromJson(Map<String, dynamic> json) => _$InsuranceCompanyFromJson(json);
}
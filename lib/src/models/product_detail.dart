import 'package:json_annotation/json_annotation.dart';
import 'insurance_company.dart';
import 'coverage.dart';

part 'product_detail.g.dart';

@JsonSerializable()
class ProductDetail extends Object with _$ProductDetailSerializerMixin{
  @JsonKey(name: 'Id')
  int id;
  @JsonKey(name: 'Name')
  String name;
  @JsonKey(name: 'RiskCode')
  String riskCode;
  @JsonKey(name: 'RiskName')
  String riskName;
  @JsonKey(name: 'ValidityCode')
  String validityCode;
  @JsonKey(name: 'InsuranceCompany')
  InsuranceCompany insuranceCompany;
  @JsonKey(name: 'Coverages')
  List<Coverage> coverages;

  ProductDetail({this.name, this.id, this.validityCode, this.riskCode, this.coverages, this.insuranceCompany, this.riskName});

  factory ProductDetail.fromJson(Map<String, dynamic> json) => _$ProductDetailFromJson(json);
}
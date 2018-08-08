// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductDetail _$ProductDetailFromJson(Map<String, dynamic> json) {
  return new ProductDetail(
      name: json['Name'] as String,
      id: json['Id'] as int,
      validityCode: json['ValidityCode'] as String,
      riskCode: json['RiskCode'] as String,
      coverages: (json['Coverages'] as List)
          ?.map((e) => e == null
              ? null
              : new Coverage.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      insuranceCompany: json['InsuranceCompany'] == null
          ? null
          : new InsuranceCompany.fromJson(
              json['InsuranceCompany'] as Map<String, dynamic>),
      riskName: json['RiskName'] as String);
}

abstract class _$ProductDetailSerializerMixin {
  int get id;
  String get name;
  String get riskCode;
  String get riskName;
  String get validityCode;
  InsuranceCompany get insuranceCompany;
  List<Coverage> get coverages;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'Id': id,
        'Name': name,
        'RiskCode': riskCode,
        'RiskName': riskName,
        'ValidityCode': validityCode,
        'InsuranceCompany': insuranceCompany,
        'Coverages': coverages
      };
}

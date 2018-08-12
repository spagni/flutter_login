// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phone.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Phone _$PhoneFromJson(Map<String, dynamic> json) {
  return new Phone(
      areaCode: json['AreaCode'] as int,
      countryCode: json['CountryCode'] as int,
      id: json['Id'] as int,
      number: json['Number'] as int);
}

abstract class _$PhoneSerializerMixin {
  int get id;
  int get areaCode;
  int get countryCode;
  int get number;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'Id': id,
        'AreaCode': areaCode,
        'CountryCode': countryCode,
        'Number': number
      };
}

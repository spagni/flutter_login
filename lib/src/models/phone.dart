import 'package:json_annotation/json_annotation.dart';

part 'phone.g.dart';

@JsonSerializable()
class Phone extends Object with _$PhoneSerializerMixin{
  @JsonKey(name: 'Id')
  int id;
  @JsonKey(name: 'AreaCode')
  int areaCode;
  @JsonKey(name: 'CountryCode')
  int countryCode;
  @JsonKey(name: 'Number')
  int number;

  Phone({this.areaCode, this.countryCode, this.id, this.number});

  factory Phone.fromJson(Map<String, dynamic> json) => _$PhoneFromJson(json);
}
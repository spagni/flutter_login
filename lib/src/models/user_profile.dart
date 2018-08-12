import 'package:json_annotation/json_annotation.dart';
import 'dart:typed_data';
import 'phone.dart';

part 'user_profile.g.dart';

@JsonSerializable()
class UserProfile extends Object with _$UserProfileSerializerMixin{
  @JsonKey(name: 'Id')
  int id;
  @JsonKey(name: 'Email')
  String email;
  @JsonKey(name: 'firstName')
  String fistName;
  @JsonKey(name: 'LastName')
  String lastName;
  @JsonKey(name: 'languageCode')
  String languageCode;
  @JsonKey(name: 'BirthDate', ignore: true)
  DateTime birthDate;
  @JsonKey(name: 'Gender')
  String gender;
  @JsonKey(name: 'GenderCode')
  String genderCode;
  @JsonKey(name: 'Phone')
  Phone phone;
  @JsonKey(name: 'ProfilePhoto')
  Uint8List profilePhoto;

  UserProfile({this.id, this.birthDate, this.email, this.fistName, this.gender, this.genderCode,
              this.languageCode, this.lastName, this.phone, this.profilePhoto});

  factory UserProfile.fromJson(Map<String, dynamic> json) => _$UserProfileFromJson(json);
}
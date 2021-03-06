// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) {
  return new UserProfile(
      id: json['Id'] as int,
      email: json['Email'] as String,
      firstName: json['FirstName'] as String,
      gender: json['Gender'] as String,
      genderCode: json['GenderCode'] as String,
      languageCode: json['languageCode'] as String,
      lastName: json['LastName'] as String,
      phone: json['Phone'] == null
          ? null
          : new Phone.fromJson(json['Phone'] as Map<String, dynamic>),
      profilePhoto: Uint8List.fromList(
          (json['ProfilePhoto'].cast<int>())));
}

abstract class _$UserProfileSerializerMixin {
  int get id;
  String get email;
  String get firstName;
  String get lastName;
  String get languageCode;
  String get gender;
  String get genderCode;
  Phone get phone;
  Uint8List get profilePhoto;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'Id': id,
        'Email': email,
        'FirstName': firstName,
        'LastName': lastName,
        'languageCode': languageCode,
        'Gender': gender,
        'GenderCode': genderCode,
        'Phone': phone,
        'ProfilePhoto': profilePhoto
      };
}

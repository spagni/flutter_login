// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LogInResponse _$LogInResponseFromJson(Map<String, dynamic> json) {
  return new LogInResponse(json['Code'] as int, json['Message'] as String)
    ..token = json['ResponseObject'] == null
        ? null
        : _getResponseObject(json['ResponseObject'] as Map<String, dynamic>);
}

abstract class _$LogInResponseSerializerMixin {
  int get code;
  String get message;
  String get token;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'Code': code,
        'Message': message,
        'ResponseObject': token
      };
}

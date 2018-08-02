import 'package:json_annotation/json_annotation.dart';

class BaseParameter<T> {
  @JsonKey(name: 'Token')
  String token;
  @JsonKey(name: 'Language')
  String language = 'en';

  BaseParameter({this.token, this.language});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Token': this.token,
      'Language': this.language
    };
  }
}
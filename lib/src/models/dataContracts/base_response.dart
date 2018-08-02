import 'package:json_annotation/json_annotation.dart';

class BaseResponse{
  @JsonKey(name: 'Code')
  int code;
  @JsonKey(name: 'Message')
  String message;

  BaseResponse(this.code, this.message);
}
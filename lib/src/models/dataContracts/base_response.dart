import '../login_response.dart';
class BaseResponse{
  int code;
  String message;
  LogInResponse responseObject;

  BaseResponse.fromJson(Map<String, dynamic> parsedJson)
    : code = parsedJson['Code'],
      message = parsedJson['Message'],
      responseObject = LogInResponse.fromJson(parsedJson['ResponseObject']);
}
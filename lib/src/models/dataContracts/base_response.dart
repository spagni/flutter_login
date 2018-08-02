class BaseResponse{
  int code;
  String message;

  BaseResponse({this.code, this.message});

  BaseResponse.fromJson(Map<String, dynamic> parsedJson)
    : code = parsedJson['Code'],
      message = parsedJson['Message'];
}
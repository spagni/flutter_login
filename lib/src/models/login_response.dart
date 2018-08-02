import 'dataContracts/base_response.dart';
class LogInResponse extends BaseResponse{
  String token;
  LogInResponse({this.token}) : super();

  LogInResponse.fromJson(Map<String, dynamic> parsedJson) : super.fromJson(parsedJson) {
    this.token = parsedJson['ResponseObject']['Token'];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Token': this.token
    };
  }
}
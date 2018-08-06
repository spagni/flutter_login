import 'dart:async';
import 'dart:convert';
import '../models/login_parameter.dart';
import '../models/login_response.dart';
import '../models/dataContracts/base_parameter.dart';
import '../utils/http_requests_helper.dart';

class AuthApiProvider {
  final String _serverUri = 'http://oficina.kimn.com.ar:21000/CautusNew/UserManager.svc/';

  Future<LogInResponse> logIn(LogInParameter parameter) async {
    final response = await HttpRequest.postAsync('${_serverUri}SignIn', json.encode(parameter.toMap()));
    
    return LogInResponse.fromJson(response);
  }

  Future<bool> verifyToken(String token) async {
    BaseParameter _body = BaseParameter(token: token);
    final response = await HttpRequest.postAsync('${_serverUri}VerifyUserToken', json.encode(_body.toMap()));
    return response['ResponseObject'];
  }
}
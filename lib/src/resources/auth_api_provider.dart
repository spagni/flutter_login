import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' show Client;
import '../models/login_parameter.dart';
import '../models/login_response.dart';
import '../models/dataContracts/base_response.dart';

class AuthApiProvider {
  Client _httpClient = new Client();
  final String _serverUri = 'http://oficina.kimn.com.ar:21000/CautusNew/UserManager.svc/';

  Future<LogInResponse> logIn(LogInParameter parameter) async {
    final response = await _httpClient.post('${_serverUri}SignIn',
                                            body: json.encode(parameter.toMap()),
                                            headers: {HttpHeaders.CONTENT_TYPE: 'application/json'});
    final jsonResponse = json.decode(response.body);
    
    return LogInResponse.fromJson(jsonResponse);
  }

  Future<bool> verifyToken(String token) async {
    LogInResponse _body = LogInResponse(token: token);
    final response = await _httpClient.post('${_serverUri}VerifyUserToken',body: json.encode(_body.toMap()), headers: {HttpHeaders.CONTENT_TYPE: 'application/json'});
    final jsonResponse = json.decode(response.body);
    return jsonResponse['ResponseObject'];
  }
}
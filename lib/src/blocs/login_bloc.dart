import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' show Client;
import '../../models/login_parameter.dart';
import '../../models/login_response.dart';

class LoginBloc {
  Client _httpClient = new Client();

  Future<LogInResponse> _logIn(LogInParameter parameter) async {
    final response = await _httpClient.post('http://oficina.kimn.com.ar:21000/CautusNew/UserManager.svc/SignIn',body: parameter);
    final jsonResponse = json.decode(response.body);
    
    return LogInResponse.fromJson(jsonResponse);
  }

  //Future<bool> 
}
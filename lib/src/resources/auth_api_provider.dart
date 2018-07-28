import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' show Client;
import '../models/login_parameter.dart';
import '../models/login_response.dart';
import '../models/dataContracts/base_response.dart';

class AuthApiProvider {
  Client _httpClient = new Client();

  Future<BaseResponse> logIn(LogInParameter parameter) async {
    final response = await _httpClient.post('http://oficina.kimn.com.ar:21000/CautusNew/UserManager.svc/SignIn',
                                            body: json.encode(parameter.toMap()),
                                            headers: {HttpHeaders.CONTENT_TYPE: 'application/json'});
    final jsonResponse = json.decode(response.body);
    
    return BaseResponse.fromJson(jsonResponse);
  }
}
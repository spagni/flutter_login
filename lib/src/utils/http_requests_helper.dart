import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' show Client;

class HttpRequest {
  static final Client _httpClient = new Client();

  static Future<dynamic> postAsync(String uri, String body) async {
    final response = await _httpClient.post(uri, body: body, headers: {HttpHeaders.CONTENT_TYPE: 'application/json'});
    return json.decode(response.body);
  }

  static void dispose() {
    _httpClient.close();
  }
}
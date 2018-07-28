class LogInResponse {
  String token;

  LogInResponse.fromJson(Map<String, dynamic> parsedJson) : token = parsedJson['Token'];
}
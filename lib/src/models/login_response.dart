class LogInResponse {
  String token;
  LogInResponse({this.token});

  LogInResponse.fromJson(Map<String, dynamic> parsedJson) : token = parsedJson['Token'];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Token': this.token
    };
  }
}
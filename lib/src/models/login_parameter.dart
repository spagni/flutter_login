class LogInParameter {
  String email;
  String password;
  String language;

  LogInParameter({this.email, this.password});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Email': this.email,
      'Password': this.password,
      'Language': 'en'
    };
  }
}
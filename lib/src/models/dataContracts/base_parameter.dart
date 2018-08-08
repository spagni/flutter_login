class BaseParameter<T> {
  String token;
  String language = 'en';
  T requestObject;

  BaseParameter({this.token, this.language});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Token': this.token,
      'Language': this.language,
      'RequestObject': this.requestObject
    };
  }
}
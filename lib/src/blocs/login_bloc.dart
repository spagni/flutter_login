import 'dart:io';
import 'package:rxdart/rxdart.dart';
import '../resources/auth_api_provider.dart';
import '../models/login_parameter.dart';
import '../utils/shared_preferences.dart';

class LoginBloc {
  final AuthApiProvider api = AuthApiProvider();

  final PublishSubject<bool> _isAuthenticated = PublishSubject<bool>();
  final PublishSubject<LogInParameter> _logInUser = PublishSubject<LogInParameter>();
  final PublishSubject<bool> _tokenIsValid = PublishSubject<bool>();
  final PublishSubject<String> _verifyToken = PublishSubject<String>();

  Observable<bool> get isAuthenticated => _isAuthenticated.stream;
  Function(LogInParameter) get logInUser => _logInUser.sink.add;
  Observable<bool> get tokenIsValid => _tokenIsValid.stream;
  Function(String) get verifyToken => _verifyToken.sink.add;

  LoginBloc() {
    //Escucho eventos que llegan al stream. Se ejecuta cuando se agrega algo al sink desde UI
    _logInUser.stream.listen(_handleLogin);
    _verifyToken.stream.listen(_handleVerifyToken);
  }

  void _handleLogin(LogInParameter parameter) async {
    var response = await api.logIn(parameter);

    if (response.code == HttpStatus.OK) {
      _isAuthenticated.sink.add(true);
      await Preferences.setStringValue('Token', response.responseObject.token);
    }
    else {
      _isAuthenticated.sink.add(false);
    }
  }

  void _handleVerifyToken(String token) async {
    if(token == null) {
      _tokenIsValid.sink.add(false);
      return;
    }
    var response = await api.verifyToken(token);
    if (response) {
      _tokenIsValid.sink.add(true);
    }
    else {
      _tokenIsValid.sink.add(false);
    }
  }

  dispose() {
    _isAuthenticated.close();
    _logInUser.close();
    _tokenIsValid.close();
    _verifyToken.close();
  }
}
import 'dart:io';
import 'package:rxdart/rxdart.dart';
import '../resources/auth_api_provider.dart';
import '../models/login_parameter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginBloc {
  final AuthApiProvider api = AuthApiProvider();

  final PublishSubject<bool> _isAuthenticated = PublishSubject<bool>();
  final PublishSubject<LogInParameter> _logInUser = PublishSubject<LogInParameter>();

  Observable<bool> get isAuthenticated => _isAuthenticated.stream;
  Function(LogInParameter) get logInUser => _logInUser.sink.add;

  LoginBloc() {
    //Escucho eventos que llegan al stream. Se ejecuta cuando se agrega algo al sink desde UI
    _logInUser.stream.listen(_handleLogin);
  }

  void _handleLogin(LogInParameter parameter) async {
    var response = await api.logIn(parameter);
    final SharedPreferences _prefs = await SharedPreferences.getInstance();

    if (response.code == HttpStatus.OK) {
      _isAuthenticated.sink.add(true);
      _prefs.setString('Token', response.responseObject.token);
    }
    else {
    _isAuthenticated.sink.add(false);
    }
  }

  dispose() {
    _isAuthenticated.close();
    _logInUser.close();
  }
}
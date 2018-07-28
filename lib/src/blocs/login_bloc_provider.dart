import 'package:flutter/material.dart';
import 'login_bloc.dart';
export 'login_bloc.dart';

class LoginBlocProvider extends InheritedWidget {
  final bloc;

  LoginBlocProvider({Key key, Widget child})
    : bloc = LoginBloc(),
      super(key:key, child:child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static LoginBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(LoginBlocProvider) as LoginBlocProvider).bloc;
  }
}
import 'package:flutter/material.dart';
import 'user_bloc.dart';
export 'user_bloc.dart';

class UserBlocProvider extends InheritedWidget {
  final bloc;

  UserBlocProvider({Key key, Widget child})
    : bloc = UserBloc(),
      super(key:key, child:child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static UserBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(UserBlocProvider) as UserBlocProvider).bloc;
  }
}
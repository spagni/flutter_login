import 'dart:async';
import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'blocs/login_bloc_provider.dart';
import './utils/shared_preferences.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LoginBlocProvider(
      child: MaterialApp(
        title: 'Cautus',
        theme: ThemeData(
          primarySwatch: Colors.red
        ),
        home: Home(),
      ),
    );
  }
}

class Home extends StatelessWidget {
  //Cre un nuevo widget para que tenga su propio context y poder acceder al bloc que esta en el widget padre
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _buildHome(context),
      builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
        return snapshot.data;
      },
    );
  }

  Future<Widget> _buildHome(BuildContext context) async {
    LoginBloc _bloc = LoginBlocProvider.of(context);
    final token = await Preferences.getStringValue('Token');
    
    //Verifico si el token que tiene el usuario es valido
    return StreamBuilder(
      stream: _bloc.tokenIsValid,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if(!snapshot.hasData) {
          _bloc.verifyToken(token);
          return Container();
        }

        if (snapshot.data) {
          return HomeScreen();
        }
        else {
          return LoginScreen();
        }
      },
    );
  }
}
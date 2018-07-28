import 'dart:async';
import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'blocs/login_bloc_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LoginBlocProvider(
      child: MaterialApp(
        title: 'Cautus',
        home: FutureBuilder(
          future: _buildHome(),
          initialData: LoginScreen(),
          builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
            return snapshot.data;
          },
        ),
      ),
    );
  }

  Future<Widget> _buildHome() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('Token');

    if (token != null) {
      return HomeScreen();
    }
    else {
      return LoginScreen();
    }
  }
}
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cautus'),
      ),
      body: Center(child: Text('Welcome to Cautus')),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.exit_to_app),
        onPressed: () => _onPressed(context),
      ),
    );
  }

  void _onPressed(BuildContext context) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.clear();
    Navigator.push(context, MaterialPageRoute(
      builder: (BuildContext context) => LoginScreen()
    ));
  }
}
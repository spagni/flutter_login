import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cautus'),
      ),
      body: Center(child: Text('Welcome to Cautus'))
    );
  }
}
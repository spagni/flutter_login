import 'package:flutter/material.dart';
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset('assets/images/background.png', fit: BoxFit.cover),
          _buildLogin()
        ],
      ),
    );
  }

  Widget _buildLogin() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 50.0),
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Icon(Icons.alternate_email, size: 250.0, color: Colors.white70),
          SizedBox(height: 12.0),
          _buildInput('Email', false),
          SizedBox(height: 12.0),
          _buildInput('Password', true),
          SizedBox(height: 12.0),
          _buildButtonBar()
        ],
      ),
    );
  }

  Widget _buildInput(String label, bool obscure) {
    return Theme(
      data: ThemeData.dark().copyWith(accentColor: Colors.white),
      child: TextField(
        obscureText: obscure,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(16.0),
          labelText: label,
          hintText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            gapPadding: 2.0
          )
        ),
      ),
    );
  }

  Widget _buildButtonBar() {
    return Stack(
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          child: FlatButton(
            padding: EdgeInsets.all(6.0),
            child: Text('Forgot my password', style: TextStyle(color: Colors.white70)),
            onPressed: () {
              setState(() {
                isLoading = !isLoading;
              });
            },
          ),
        ),
        _buildLoginButton()
      ],
    );
  }

  Widget _buildLoginButton() {
    if (!isLoading) {
      return Container(
        alignment: Alignment.centerRight,
        child: RaisedButton(
          shape: StadiumBorder(),
          child: Text('LOG IN', style: TextStyle(color: Colors.white)),
          elevation: 5.0,
          color: Colors.indigo,
          onPressed: () {
            setState(() {
              isLoading = !isLoading;
            });
          },
        ),
      );
    }
    else {
      return Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: CircularProgressIndicator(
        ),
      );
    }
  }
}
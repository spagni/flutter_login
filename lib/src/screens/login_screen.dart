import 'package:flutter/material.dart';
import '../blocs/login_bloc_provider.dart';
import '../models/login_parameter.dart';
import './home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  //Esta MAL!! Hay que usar InheritedWidget
  LoginBloc bloc; //= LoginBloc();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  // TODO: implement context
  BuildContext get context => super.context;

  @override
  void didChangeDependencies() {
    bloc = LoginBlocProvider.of(context);
    bloc.isAuthenticated.listen((bool value) {
      setState(() {
        //Paro el activity indicator
        isLoading = false;
      });
      print('IS LOGGED $value');
      if (value) {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
          builder: (BuildContext context) => HomeScreen()
        ), (Route<dynamic> route) => false);
      }
    });
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    //bloc = LoginBlocProvider.of(context);

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
          _buildInput('Email', false, _emailController),
          SizedBox(height: 12.0),
          _buildInput('Password', true, _passwordController),
          SizedBox(height: 12.0),
          _buildButtonBar()
        ],
      ),
    );
  }

  Widget _buildInput(String label, bool obscure, TextEditingController controller) {
    return Theme(
      data: ThemeData.dark().copyWith(accentColor: Colors.white),
      child: TextField(
        controller: controller,
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
          color: Colors.indigo[600],
          onPressed: () {
            bloc.logInUser(_buildLoginParameter());
            setState(() {
              isLoading = !isLoading;
              _emailController.clear();
              _passwordController.clear();
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

  LogInParameter _buildLoginParameter() {
    //TODO: Bussines logic no deberia ir aca
    return LogInParameter(email: _emailController.text, password: _passwordController.text);
  }

  void dispose() {
    // Clean up the controller when the Widget is disposed
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
import 'dart:async';
import 'package:flutter/material.dart';
import 'login_screen.dart';
import '../utils/shared_preferences.dart';
import '../screens/products_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/notifications_screen.dart';

class HomeScreen extends StatefulWidget {
  
  @override
  HomeScreenState createState() => new HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin{
  int _currentIndex = 0;
  Widget _currentScreen;
  List<Widget> _screens;
  //Animations
  AnimationController _slideController;
  Animation<Offset> _slideRightAnimation;

  @override
    void initState() {
      super.initState();

      _screens = <Widget>[
        ProductsScreen(),
        Container(color: Colors.red,),
        Container(color: Colors.lightBlue,),
        NotificationsScreen(),
        ProfileScreen()
      ];
      _currentScreen = _screens[0];

      _slideController = AnimationController(
        duration: Duration(milliseconds: 100),
        vsync: this
      );
      _slideRightAnimation = Tween<Offset>(begin: Offset(-1.0, 0.0), end: Offset(0.0, 0.0))
        .animate(_slideController);
      _slideController.forward();
    }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: _buildAppbar(),
        body: SlideTransition(
          position: _slideRightAnimation,
          child: _currentScreen
        ),
        bottomNavigationBar: _buildBottomNavBar(),
        floatingActionButton: _buildFAB()
      ),
    );
  }

  void _onPressed(BuildContext context) async {
    await Preferences.clearValues();
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
      builder: (BuildContext context) => LoginScreen()
    ), (Route<dynamic> route) => false);
  }

  void _navigate(int index) {
    if (index == _currentIndex) return;

    setState(() {
      _currentIndex = index;
      _currentScreen = _screens[index];
    });
    
    if (_slideRightAnimation.status == AnimationStatus.completed) {
      _slideController.reset();
      _slideController.forward();
    }
    else {
      _slideController.forward();
    }
  }

  //Estos metodos los uso para que cada screen pueda tener su propio appbar y FAB
  //Si no es la screen 0, dejo que cada pantalla construya lo suyo.
  //Esto es así para poder mantener bottom nav bar con toda su logica de navegacion
  //Material design no incluye todo este diseño
  Widget _buildAppbar() {
    if (_currentIndex == 0) {
        return AppBar(
        leading: Padding(
          padding: EdgeInsets.all(5.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage('https://instagram.faep9-2.fna.fbcdn.net/vp/05e7b834967dadd1fb44e52bd3d2934f/5C0C9A16/t51.2885-19/s320x320/30084914_231763700899045_353564606909644800_n.jpg'),
            radius: 20.0,
          ),
        ),
        title: Text('Cautus'),
        actions: <Widget>[
          Icon(Icons.search),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Icon(Icons.send),
          )
        ],
      );
    }
    return null;    
  }
  Widget _buildFAB() {
    if (_currentIndex == 0) {
      return FloatingActionButton(
        child: Icon(Icons.exit_to_app),
        onPressed: () => _onPressed(context),
      );
    }
    return null;
  }
  
  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: _navigate,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.menu),
          title: Text('Products')
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.turned_in_not),
          title: Text('Proposals')
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.trending_up),
          title: Text('Sales')
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications_none),
          title: Text('Notifications')
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          title: Text('Profile')
        )
      ],
    );
  }

  Future<bool> _onWillPop() {
    //Si currentScreen es Products salgo de la app
    if(_currentIndex == 0) {
      return Future.value(true);
    }
    //Si currentScreen es otra pagina, navego a Products
    _navigate(0);
    return Future.value(false);
  }
}
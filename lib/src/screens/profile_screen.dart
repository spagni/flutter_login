import 'dart:ui' as dartUi;
import 'package:flutter/material.dart';
import '../blocs/user_bloc_provider.dart';
import '../models/user_profile.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {
  ScrollController _scrollController;
  double _stackHeight = 250.0;

  //AvatarScale Animation
  AnimationController _avatarController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() => setState((){}));

    _avatarController = AnimationController(
      duration: Duration(milliseconds: 700),
      vsync: this
    );
  }

  bool get _showTitle {
    return _scrollController.hasClients
        && _scrollController.offset > _stackHeight - kToolbarHeight;
  }

  @override
  Widget build(BuildContext context) {
    UserBloc _bloc = UserBlocProvider.of(context);

    return StreamBuilder(
      stream: _bloc.userProfile,
      builder: (BuildContext context, AsyncSnapshot<UserProfile> snapshot) {
        if (!snapshot.hasData) {
          _bloc.getUserProfile(null);
          return Center(child: CircularProgressIndicator());
        }

        UserProfile _user = snapshot.data;
        return Scaffold(
          body: _buildSliverBody(_user),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.edit),
            onPressed: () {},
          ),
        );
      },
    );
  }

  Widget _buildSliverBody(UserProfile user) {
    return CustomScrollView(
      //Controller para mostrar icon y title solo cuando se scrollea
      controller: _scrollController,
      slivers: <Widget>[
        SliverAppBar(
          expandedHeight: _stackHeight,
          pinned: true,
          //Para que el titulo quede fijo en la appbar
          floating: false,
          leading: _showTitle ? Padding(
            padding: EdgeInsets.all(5.0),
            child: CircleAvatar(
              backgroundImage: MemoryImage(user.profilePhoto),
              radius: 20.0,
              ),
            ) : null,
          title: _showTitle ? Text('User Profile') : null,
          flexibleSpace: FlexibleSpaceBar(
            background: _buildImagesStack(user),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            <Widget>[
              Container(color: Colors.lime, height: 150.0),
              Container(color: Colors.lightBlue, height: 150.0),
              Container(color: Colors.orange, height: 150.0),
              Container(color: Colors.red, height: 150.0),
              Container(color: Colors.greenAccent, height: 150.0),
              Container(color: Colors.purple, height: 150.0)
            ],
          ),
        )
      ],
    );
  }

  Widget _buildImagesStack(UserProfile user) {
    _avatarController.forward();
    return Container(
      //height: _stackHeight,
      width: double.infinity, 
      child: Stack(
        children: <Widget>[
          //Pongo la img de fondo en el decoration de un container para poder aplicarle el blur
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: MemoryImage(
                  user.profilePhoto,
                ),
                fit: BoxFit.cover
              )
            ),
            child: BackdropFilter(
              filter: dartUi.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              //Para que se vea la imagen de atras con opacity
              child: new Container(
                decoration: new BoxDecoration(color: Colors.black.withOpacity(0.4))
              ),
            )
          ),
          Positioned(
            //Width de la pantalla sobre dos, menos el radio del avatar para que quede en el centro
            left: MediaQuery.of(context).size.width / 2 - 70.0,
            top: 30.0,
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(
                  parent: _avatarController,
                  curve: Interval(
                    0.100,
                    0.900,
                    curve: Curves.elasticOut,
                  )
                )
              ),
              child: CircleAvatar(
                backgroundImage: MemoryImage(user.profilePhoto),
                radius: 70.0,
                //Child para agregar el borde de color
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(70.0),
                    border: Border.all(
                      color: Theme.of(context).accentColor,
                      width: 3.0
                    )
                  ),
                ),
              ),
            )
          ),
          Positioned(
            bottom: 50.0,
            left: 0.0,
            right: 0.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  '${user.firstName} ${user.lastName}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).canvasColor,
                    fontSize: 23.0
                  ),
                ),
                Text(
                  '${user.email}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).canvasColor,
                    fontSize: 15.0
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
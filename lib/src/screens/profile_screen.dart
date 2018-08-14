import 'package:flutter/material.dart';
import '../blocs/user_bloc_provider.dart';
import '../models/user_profile.dart';
import '../widgets/profile_img_stack.dart';
import '../widgets/info_tile.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {
  ScrollController _scrollController;
  double _stackHeight = 250.0;

  //AvatarScale Animation
  AnimationController _avatarController;
  Animation<double> _avatarAnimation;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() => setState((){}));

    _avatarController = AnimationController(
      duration: Duration(milliseconds: 700),
      vsync: this
    );

    _avatarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _avatarController,
        curve: Interval(
          0.100,
          0.900,
          curve: Curves.elasticOut,
        )
      )
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
              Row(
                children: <Widget>[
                  Expanded(child: InfoTile(title: 'First Name', subtitle: user.firstName, icon: Icons.person_outline,)),
                  Expanded(child: InfoTile(title: 'Last Name', subtitle: user.lastName)),
                ],
              ),
              _divider,
              InfoTile(title: 'Email', subtitle: user.email, icon: Icons.alternate_email),
              _divider,
              InfoTile(title: 'Birth Date', subtitle: user.birthDate.toString(), icon: Icons.today),
              _divider,
              InfoTile(title: 'Mobile Phone', subtitle: user.phone.number.toString(), icon: Icons.phone_iphone),
              _divider,
              InfoTile(title: 'Gender', subtitle: user.gender, icon: Icons.face),
              _divider,
              InfoTile(title: 'CBU', subtitle: '123456789', icon: Icons.work),
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

  Widget get _divider => Padding(
    padding: EdgeInsets.symmetric(horizontal: 24.0),
    child: Container(color: Colors.black45, height: 0.5),
  );

  Widget _buildImagesStack(UserProfile user) {
    _avatarController.forward();
    //Extraigo la logica del stack en un nuevo widget reutilizable
    return ProfileImgStack(
      animation: _avatarAnimation,
      title: '${user.firstName} ${user.lastName}',
      subtitle: '${user.email}',
      image: MemoryImage(user.profilePhoto),
    );    
  }
}
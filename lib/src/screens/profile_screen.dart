import 'package:flutter/material.dart';
import '../blocs/user_bloc_provider.dart';
import '../models/user_profile.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
        return ListView(
          children: <Widget>[
            Text('${_user.fistName}'),
            Text('${_user.lastName}'),
          ],
        );
      },
    );
  }
}
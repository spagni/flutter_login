import 'package:rxdart/rxdart.dart';
import '../resources/user_api_provider.dart';
import '../models/user_profile.dart';

class UserBloc {
  final UserApiProvider api = UserApiProvider();

  final PublishSubject<UserProfile> _userProfile =  PublishSubject<UserProfile>();
  final PublishSubject _getUserProfile = PublishSubject();

  Function get getUserProfile => _getUserProfile.sink.add;
  Observable<UserProfile> get userProfile => _userProfile.stream;

  UserBloc() {
    _getUserProfile.stream.listen(_handleGetUser);
  }

  void _handleGetUser(_) async {
    final response = await api.getUserProfile();

    //No valido el codigo porque no estoy usando BaseResponse por cuestiones de reflection del lenguaje
    if (response != null) {
      _userProfile.add(response);
    }
    else {
      _userProfile.sink.addError("ERROR");
    }
  }

  dispose() {
    _userProfile.close();
    _getUserProfile.close();
  }

}
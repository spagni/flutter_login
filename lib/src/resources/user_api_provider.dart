import 'dart:async';
import 'dart:convert';
import 'dart:io' as dartIo;
import '../utils/shared_preferences.dart';
import '../models/user_profile.dart';
import '../models/dataContracts/base_parameter.dart';
import '../utils/http_requests_helper.dart';

class UserApiProvider {
  final String _serverUri = 'http://oficina.kimn.com.ar:21000/CautusNew/UserManager.svc/';

  Future<UserProfile> getUserProfile() async {
    BaseParameter _parameter = BaseParameter(token: await Preferences.getStringValue('Token'));
    final response = await HttpRequest.postAsync('${_serverUri}GetUserProfile', json.encode(_parameter.toMap()));
    
    if (response['Code'] == dartIo.HttpStatus.OK) {
      return UserProfile.fromJson(response['ResponseObject']);
    }
    return null;
  }
}
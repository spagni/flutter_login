import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  static SharedPreferences _prefsInstance;

  static Future<String> getStringValue(String key) async {
    if (_prefsInstance == null) {
      _prefsInstance = await _prefs;
    }
    return _prefsInstance.getString(key);
  }

  static Future setStringValue(String key, String value) async {
    if (_prefsInstance == null) {
      _prefsInstance = await _prefs;
    }
    _prefsInstance.setString(key, value);
  }

  static Future<bool> clearValues() async {
    if (_prefsInstance == null) {
      _prefsInstance = await _prefs;
    }
    return _prefsInstance.clear();
  }
}
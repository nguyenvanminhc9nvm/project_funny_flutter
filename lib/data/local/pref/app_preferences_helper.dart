import 'package:project_funny_flutter/data/local/pref/preferences_helper.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class AppPreferencesHelper extends PreferencesHelper {
  final String keyFirstTimeSignIn = "KEY_FIRST_TIME_SIGN_IN";
  static final AppPreferencesHelper _singleton = AppPreferencesHelper.internal();

  factory AppPreferencesHelper() {
    return _singleton;
  }

  AppPreferencesHelper.internal();

  @override
  Future<bool> getFirstTimeLogin() async {
    final preferences = await StreamingSharedPreferences.instance;
    return preferences.getBool(keyFirstTimeSignIn, defaultValue: false).first;
  }

  @override
  Future<bool> setFirstTimeLogin(bool isFirst) async {
    final preferences = await StreamingSharedPreferences.instance;
    preferences.setBool(keyFirstTimeSignIn, isFirst);
    return Future.value(true);
  }
}
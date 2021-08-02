import 'package:project_funny_flutter/data/local/database/app_database/db_helper.dart';
import 'package:project_funny_flutter/data/local/pref/preferences_helper.dart';
import 'package:project_funny_flutter/data/model/local/on_boar.dart';
import 'package:project_funny_flutter/data/remote/fire_store_helper.dart';

abstract class DataManager implements DbHelper, FireStoreHelper, PreferencesHelper {
  Future<List<OnBoar>> doGetListOnBoarding();
}
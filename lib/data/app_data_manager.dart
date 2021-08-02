import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_funny_flutter/data/data_manager.dart';
import 'package:project_funny_flutter/data/local/database/app_database/app_db_helper.dart';
import 'package:project_funny_flutter/data/local/database/app_database/db_helper.dart';
import 'package:project_funny_flutter/data/local/pref/app_preferences_helper.dart';
import 'package:project_funny_flutter/data/local/pref/preferences_helper.dart';
import 'package:project_funny_flutter/data/model/local/on_boar.dart';
import 'package:project_funny_flutter/data/remote/app_fire_store_helper.dart';
import 'package:project_funny_flutter/data/remote/fire_store_helper.dart';
import 'package:project_funny_flutter/utils/constant/constant.dart';

class AppDataManager extends DataManager {
  late PreferencesHelper _preferencesHelper;
  late DbHelper _dbHelper;
  late FireStoreHelper _fireStoreHelper;

  AppDataManager.internal() {
    _preferencesHelper = AppPreferencesHelper();
    _dbHelper = AppDbHelper();
    _fireStoreHelper = AppFireStoreHelper();
  }

  static final AppDataManager _singleton = AppDataManager.internal();

  factory AppDataManager() {
    return _singleton;
  }

  @override
  Future<bool> getFirstTimeLogin() {
    return _preferencesHelper.getFirstTimeLogin();
  }

  @override
  Future<bool> setFirstTimeLogin(bool isFirst) {
    return _preferencesHelper.setFirstTimeLogin(isFirst);
  }

  @override
  Future<List<OnBoar>> doGetListOnBoarding() {
    List<OnBoar> list = [
      OnBoar(icObFirst, icObContFirst, "key_ob_first_title", "key_ob_first_content"),
      OnBoar(icObSecond, icObContSecond, "key_ob_second_title", "key_ob_second_content"),
      OnBoar(icObThird, icObContThird, "key_ob_third_title", "key_ob_third_content"),
    ];
    return Future.value(list);
  }

  @override
  Stream find1000Picture() {
    return _fireStoreHelper.find1000Picture();
  }

  @override
  Future<Query<Object?>> findNextPicture(DocumentSnapshot nextDocument) {
    return _fireStoreHelper.findNextPicture(nextDocument);
  }

  @override
  Future<bool> updateVotePicture(String documentId, int vote) {
    return _fireStoreHelper.updateVotePicture(documentId, vote);
  }

  @override
  Future<bool> insertComment(String comment) {
    return _fireStoreHelper.insertComment(comment);
  }
}

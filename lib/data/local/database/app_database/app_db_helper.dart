import 'package:project_funny_flutter/data/local/database/app_database/db_helper.dart';

class AppDbHelper extends DbHelper {
  static final AppDbHelper _singleton = AppDbHelper.internal();

  factory AppDbHelper() {
    return _singleton;
  }

  AppDbHelper.internal();
}
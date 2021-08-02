import 'package:floor/floor.dart';
import 'package:project_funny_flutter/data/local/database/dao/tb_dao.dart';
import 'package:project_funny_flutter/data/local/database/entity/tb_funny.dart';

import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_database.g.dart';

@Database(version: 1, entities: [TbFunny])
abstract class AppDatabase extends FloorDatabase {
  TbDao get tbDao;
}

import 'package:floor/floor.dart';
import 'package:project_funny_flutter/data/local/database/entity/tb_funny.dart';
import 'package:project_funny_flutter/utils/constant/constant.dart';

@dao
abstract class TbDao {
  @Query("SELECT * FROM $tbFunny")
  Future<List<TbFunny>> findAllTbFunny();
}
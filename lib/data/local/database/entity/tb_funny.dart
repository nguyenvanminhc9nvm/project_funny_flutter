import 'package:floor/floor.dart';
import 'package:project_funny_flutter/utils/constant/constant.dart';

@Entity(tableName: tbFunny)
class TbFunny {
  @PrimaryKey(autoGenerate: true)
  final int id;

  TbFunny(this.id);
}
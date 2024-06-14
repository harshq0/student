import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:todo/database/student_dao.dart';
import 'package:todo/database/student_entity.dart';

part 'database.g.dart';

@Database(version: 1, entities: [Student])
abstract class AppDatabase extends FloorDatabase {
  StudentDao get studentDao;
}

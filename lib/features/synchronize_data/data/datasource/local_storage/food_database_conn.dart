import 'package:flutter/foundation.dart';
import 'package:nutrients/core/utils/success.dart';
import 'package:sqflite/sqflite.dart';

abstract class FoodDatabaseConn {
  Future<Database> open(String databaseName);

  Future<Success> clearDatabase(
      {@required Database db, @required String tableName});

  Future<List<Map<String, dynamic>>> queryAllData(
      {@required Database db, @required String tableName});

  Future<Success> insertNewData(
      {@required Database db,
      @required List foods,
      @required String tableName});

  Future<void> closeDatabase(Database db);
}

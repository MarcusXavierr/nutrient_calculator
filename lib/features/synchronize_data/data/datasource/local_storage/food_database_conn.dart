import 'package:flutter/foundation.dart';
import 'package:nutrients/core/utils/success.dart';
import 'package:sqflite/sqflite.dart';

abstract class FoodDatabaseConn {
  Future<Database> openDatabase(String databaseName);

  Future<Success> clearDatabase(Database db);

  Future<List<Map<String, dynamic>>> queryAllData(Database db);

  Future<Success> insertNewData({@required Database db, @required List foods});

  Future<void> closeDatabase(Database db);
}

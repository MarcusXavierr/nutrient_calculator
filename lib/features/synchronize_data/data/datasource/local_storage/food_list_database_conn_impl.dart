import 'package:nutrients/constants.dart';
import 'package:nutrients/core/error/exceptions.dart';
import 'package:nutrients/core/utils/success.dart';
import 'package:nutrients/features/synchronize_data/data/datasource/local_storage/food_database_conn.dart';
import 'package:nutrients/repositories/db_connection.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class FoodListDatabaseConnImpl implements FoodDatabaseConn {
  final String _tableName = 'foods';

  @override
  Future<Success> clearDatabase(Database db) async {
    try {
      await db.delete(_tableName);
      return SuccessDownload();
    } catch (e) {
      throw SQLiteException();
    }
  }

  @override
  Future<void> closeDatabase(Database db) async {
    try {
      await db.close();
    } catch (e) {
      throw SQLiteException();
    }
  }

  @override
  Future<Success> insertNewData({Database db, List foods}) async {
    try {
      for (var food in foods) {
        await db.insert(
          _tableName,
          food.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }

      return SuccessDownload(successMessage: 'Data downloaded sucessfully');
    } catch (e) {
      throw SQLiteException();
    }
  }

  @override
  Future<Database> open(String databaseName) async {
    try {
      final Database database = await openDatabase(
        join(await getDatabasesPath(), DatabaseName),
        onCreate: (db, version) {
          return createDatabase(db);
        },
        version: 1,
      );

      return database;
    } catch (e) {
      throw SQLiteException();
    }
  }

  @override
  Future<List<Map<String, dynamic>>> queryAllData(Database db) async {
    try {
      List<Map<String, dynamic>> allFoods = await db.query(_tableName);
      return allFoods;
    } catch (e) {
      throw SQLiteException();
    }
  }
}

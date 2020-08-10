import 'dart:async';
import 'package:nutrients/models/food_tracker_model.dart';
import 'package:nutrients/repositories/db_connection.dart';
import 'package:sqflite/sqflite.dart';

class FoodTrackerRepository {
  DBConnection conn;
  FoodTrackerRepository() {
    conn = DBConnection();
  }

  Future<void> create(FoodTrackerModel model) async {
    try {
      final Database db = await conn.open();
      await db.insert(
        'tracker',
        model.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      db.close();
    } catch (e) {}
  }

  Future<List<Map<String, dynamic>>> recoverFoodTracker(String datetime) async {
    final Database db = await conn.open();

    final List<Map<String, dynamic>> food = await db
        .rawQuery('SELECT * FROM tracker WHERE datetime = ?', ['$datetime']);

    db.close();
    return food;
  }
}

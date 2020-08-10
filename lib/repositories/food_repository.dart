import 'dart:async';
import 'package:nutrients/models/food_model.dart';
import 'package:nutrients/repositories/db_connection.dart';
import 'package:sqflite/sqflite.dart';

class FoodRepository {
  DBConnection conn; //* Connection with database
  FoodRepository() {
    conn = DBConnection();
  }

  dynamic createFood(FoodModel model) async {
    try {
      final Database db = await conn.open();

      await db.insert(
        'foods',
        model.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      db.close();

      return "Food successfully added";
    } catch (e) {
      print(e);
      return "Error adding food";
    }
  }

  Future<List<Map<String, dynamic>>> recoverAllFoods() async {
    final Database db = await conn.open();

    final List<Map<String, dynamic>> maps = await db.query('foods');

    db.close();

    return maps;
  }

  Future<List<Map<String, dynamic>>> recoverFood(int columnId) async {
    final Database db = await conn.open();

    final List<Map<String, dynamic>> food =
        await db.rawQuery('SELECT * FROM foods WHERE id = ?', ['$columnId']);

    db.close();
    return food;
  }

  Future<String> updateFood(FoodModel model) async {
    try {
      final Database db = await conn.open();

      await db.update(
        'foods',
        model.toMap(),
        where: "id = ?",
        whereArgs: [model.id],
      );

      db.close();

      return "Food updated successfully";
    } catch (e) {
      print(e);
      return "Error updating food";
    }
  }

  Future<bool> deleteFood(int id) async {
    try {
      final db = await conn.open();

      await db.delete('foods', where: "id = ?", whereArgs: [id]);

      db.close();

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}

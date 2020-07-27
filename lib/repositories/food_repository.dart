import 'dart:async';

import 'package:nutrients/models/food_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class FoodRepository {
  Future<Database> open() async {
    final Future<Database> database = openDatabase(
      join(await getDatabasesPath(), 'food_database.db'),
      onCreate: (db, version) {
        return db.execute(
            "CREATE TABLE foods (id INTEGER PRIMARY KEY, name TEXT NOT NULL,carbo REAL NOT NULL,protein REAL NOT NULL, fat REAL NOT NULL)"); //I'll not put id now
      },
      version: 1,
    );

    return database;
  }

  dynamic createFood(FoodModel model) async {
    try {
      final Database db = await open();

      await db.insert(
        'foods',
        model.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      db.close();

      return "Alimento adicionado com sucesso";
    } catch (e) {
      print(e);
      return "Erro ao adicionar alimento";
    }
  }

  Future<List<Map<String, dynamic>>> recoverAllFoods() async {
    final Database db = await open();

    final List<Map<String, dynamic>> maps = await db.query('foods');

    db.close();

    return maps;
  }

  Future<List<Map<String, dynamic>>> recoverFood(int columnId) async {
    final Database db = await open();

    final List<Map<String, dynamic>> food =
        await db.rawQuery('SELECT * FROM foods WHERE id = ?', ['$columnId']);

    db.close();
    return food;
  }

  Future<String> updateFood(FoodModel model) async {
    try {
      final Database db = await open();

      await db.update(
        'foods',
        model.toMap(),
        where: "id = ?",
        whereArgs: [model.id],
      );

      db.close();

      return "Alimento atualizado com sucesso";
    } catch (e) {
      print(e);
      return "Erro ao atualizar alimento";
    }
  }

  Future<bool> deleteFood(int id) async {
    try {
      final db = await open();

      await db.delete('foods', where: "id = ?", whereArgs: [id]);

      db.close();

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}

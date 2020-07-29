import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBConnection {
  void _createDatabase(Database db) async {
    await db.execute('''CREATE TABLE foods (id INTEGER PRIMARY KEY, 
        name TEXT NOT NULL,carbo REAL NOT NULL,protein REAL NOT NULL, 
        fat REAL NOT NULL)''');

    await db.execute('''CREATE TABLE tracker (id INTEGER PRIMARY KEY, 
    food_id INTEGER NOT NULL,food_carbo REAL NOT NULL, 
    protein REAL NOT NULL, fat REAL NOT NULL)''');
  }

  Future<Database> open() async {
    final Future<Database> database = openDatabase(
      join(await getDatabasesPath(), 'food_database.db'),
      onCreate: (db, version) {
        return _createDatabase(db); //I'll not put id now
      },
      version: 1,
    );

    return database;
  }
}

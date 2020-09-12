import 'package:nutrients/constants.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void createDatabase(Database db) async {
  await db.execute('''CREATE TABLE foods (id INTEGER PRIMARY KEY, 
        name TEXT NOT NULL,carbo REAL NOT NULL,protein REAL NOT NULL, 
        fat REAL NOT NULL)''');

  await db.execute('''CREATE TABLE tracker (id INTEGER PRIMARY KEY, 
    food_id INTEGER NOT NULL,food_carbo REAL NOT NULL, 
    food_protein REAL NOT NULL, food_fat REAL NOT NULL,datetime TEXT NOT NULL)''');
}

class DBConnection {
  Future<Database> open() async {
    final Future<Database> database = openDatabase(
      join(await getDatabasesPath(), DatabaseName),
      onCreate: (db, version) {
        return createDatabase(db);
      },
      version: 1,
    );

    return database;
  }
}

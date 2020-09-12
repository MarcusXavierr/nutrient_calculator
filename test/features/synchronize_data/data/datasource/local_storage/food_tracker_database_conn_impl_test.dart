import 'package:flutter_test/flutter_test.dart';
import 'package:nutrients/constants.dart';
import 'package:nutrients/features/synchronize_data/data/datasource/local_storage/food_list_database_conn_impl.dart';
import 'package:nutrients/features/synchronize_data/data/models/food_list_data_model.dart';
import 'package:nutrients/features/synchronize_data/data/models/food_tracker_data_model.dart';
import 'package:nutrients/repositories/db_connection.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  setUp(() {
    sqfliteFfiInit();
  });

  final String _tableName = 'tracker';

  _setupDB() async {
    var db = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath,
        options: OpenDatabaseOptions(
          onCreate: (db, version) {
            return createDatabase(db);
          },
          version: 1,
        ));
    return db;
  }

  Future<void> _populateDb(List tListOfFoodDataModel, Database db) async {
    for (var food in tListOfFoodDataModel) {
      await db.insert(
        _tableName,
        food.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  final List<FoodTrackerDataModel> tListOfFoodDataModel = [
    FoodTrackerDataModel(
        foodCarbo: 10.5,
        foodFat: 10.5,
        foodProtein: 10.5,
        userId: 'user id',
        datetime: '2020-04-04'),
    FoodTrackerDataModel(
        foodCarbo: 10.5,
        foodFat: 10.5,
        foodProtein: 10.5,
        userId: 'user id 2',
        datetime: '2020-04-04'),
  ];

  test(
    'should open the Database',
    () async {
      //Act
      var db = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath,
          options: OpenDatabaseOptions(
            onCreate: (db, version) {
              return createDatabase(db);
            },
            version: 1,
          ));
      //Assert
      expect(await db.getVersion(), 1);
    },
  );

  test(
    'should write file in db',
    () async {
      // Arrange
      var db = await _setupDB();
      //Act
      for (var food in tListOfFoodDataModel) {
        await db.insert(
          _tableName,
          food.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }

      //Assert
      final result = await db.query(_tableName);
      print(result);
      await db.close();
    },
  );

  test(
    'should delete all files in database',
    () async {
      // Arrange
      var db = await _setupDB();
      await _populateDb(tListOfFoodDataModel, db);
      print('---------------Before delete---------------');
      print(await db.query(_tableName));
      //Act
      db.delete(_tableName);
      //Assert
      print('---------------After delete---------------');
      print(await db.query(_tableName));
      await db.close();
    },
  );

  test(
    'should query data',
    () async {
      // Arrange
      var db = await _setupDB();
      await _populateDb(tListOfFoodDataModel, db);
      //Act
      List<Map<String, dynamic>> allFoods = await db.query(_tableName);
      print(allFoods);
      //Assert
    },
  );
}

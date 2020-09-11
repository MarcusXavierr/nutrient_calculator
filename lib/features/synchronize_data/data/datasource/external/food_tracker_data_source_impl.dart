import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:nutrients/constants.dart';
import 'package:nutrients/core/error/exceptions.dart';
import 'package:nutrients/core/utils/success.dart';
import 'package:nutrients/features/synchronize_data/data/datasource/food_list_data_source.dart';
import 'package:nutrients/features/synchronize_data/data/datasource/local_storage/food_list_database_conn.dart';
import 'package:nutrients/features/synchronize_data/data/models/food_tracker_data_model.dart';
import 'package:nutrients/mypass.dart';

class FoodTrackerDataSourceImpl implements FoodListDataSource {
  List<FoodTrackerDataModel> listOfFoodTrackerData = [];
  // HasuraConnect hasuraConnect;

  final HasuraConnect hasuraConnect;
  final FoodDatabaseConn foodDatabaseConn;

  FoodTrackerDataSourceImpl({
    @required this.hasuraConnect,
    @required this.foodDatabaseConn,
  });
  @override
  Future<Success> downloadData(String userId) async {
    //   hasuraConnect =
    //       HasuraConnect(HasuraUrl, headers: {"x-hasura-admin-secret": myPass});
    dynamic response;
    listOfFoodTrackerData = [];
    try {
      response = await hasuraConnect
          .query(KQueryFoodTracker, variables: {"userId": userId});
    } catch (e) {
      throw ServerException();
    }

    var dataJson = Map<String, dynamic>.from(response);

    if (dataJson['data']['food_tracker'].isEmpty) {
      throw EmptyDataException('There is no data of yours in the cloud');
    }

    for (var data in dataJson['data']['food_tracker']) {
      FoodTrackerDataModel newFoodListData =
          FoodTrackerDataModel.fromJson(data);

      listOfFoodTrackerData.add(newFoodListData);
    }

    try {
      Success result = await _insertDataIntoDatabase(listOfFoodTrackerData);
      return result;
    } catch (e) {
      throw SQLiteException();
    }
  }

  _insertDataIntoDatabase(List<FoodTrackerDataModel> list) async {
    final db = await foodDatabaseConn.openDatabase(DatabaseName);
    await foodDatabaseConn.clearDatabase(db);
    final result = await foodDatabaseConn.insertNewData(db: db, foods: list);
    return result;
  }

  @override
  Future<Success> uploadData(String userId) async {
    listOfFoodTrackerData = [];
    List<Map<String, dynamic>> allFoods;
    try {
      final db = await foodDatabaseConn.openDatabase(DatabaseName);
      allFoods = await foodDatabaseConn.queryAllData(db);
    } catch (e) {
      throw SQLiteException();
    }

    if (allFoods.isEmpty) {
      throw EmptyDataException('You have no data in the local database');
    }

    try {
      for (var data in allFoods) {
        FoodTrackerDataModel newFoodListData =
            FoodTrackerDataModel.fromJson(data);
        newFoodListData.userId = userId;
        listOfFoodTrackerData.add(newFoodListData);
      }
    } catch (e) {
      throw SQLiteException();
    }

    try {
      await hasuraConnect
          .mutation(KMutationDeleteFoodTracker, variables: {"userId": userId});

      for (FoodTrackerDataModel food in listOfFoodTrackerData) {
        await hasuraConnect.mutation(KMutationInsertFoodTracker,
            variables: food.toJson());
      }

      return SuccessUpload(successMessage: 'Successful cloud sync');
    } catch (e) {
      throw ServerException();
    }
  }
}

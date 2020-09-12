import 'package:hasura_connect/hasura_connect.dart';
import 'package:meta/meta.dart';
import 'package:nutrients/constants.dart';
import 'package:nutrients/core/error/exceptions.dart';
import 'package:nutrients/core/utils/success.dart';
import 'package:nutrients/features/synchronize_data/data/datasource/food_list_data_source.dart';
import 'package:nutrients/features/synchronize_data/data/datasource/local_storage/food_database_conn.dart';
import 'package:nutrients/features/synchronize_data/data/models/food_list_data_model.dart';

class FoodListDataSourceImpl implements FoodListDataSource {
  final FoodDatabaseConn foodListTableConn;
  final HasuraConnect hasuraConnect;

  List<FoodListDataModel> listOfFoodListData = [];

  FoodListDataSourceImpl(
      {@required this.foodListTableConn, @required this.hasuraConnect});

  //! Should get data from Hasura and put it into SQLite local db
  @override
  Future<Success> downloadData(String userId) async {
    listOfFoodListData = [];
    dynamic response;
    //* Try to connect to hasura server and query all foods
    try {
      response = await _queryAllFoods(userId);
      hasuraConnect.disconnect();
    } catch (e) {
      throw ServerException();
    }

    // * Try to convert the String response into a List of FoodListDataModel
    var dataJson = Map<String, dynamic>.from(response);

    if (dataJson['data']['food_list'].isEmpty) {
      throw EmptyDataException('There is no data of yours in the cloud');
    }

    for (var data in dataJson['data']['food_list']) {
      FoodListDataModel newFoodListData = FoodListDataModel.fromJson(data);
      listOfFoodListData.add(newFoodListData);
    }

    // * Try to clear database and insert new values
    try {
      Success result = await _insertDataIntoDatabase(listOfFoodListData);
      hasuraConnect
          .disconnect(); //! Use factories instead singleton for HasuraConnect
      return result;
    } catch (e) {
      throw SQLiteException();
    }
  }

  _queryAllFoods(String userId) async {
    final response = await hasuraConnect
        .query(KQueryFoodList, variables: {"userId": "$userId"});
    return response;
  }

  _insertDataIntoDatabase(List<FoodListDataModel> list) async {
    final db = await foodListTableConn.open(DatabaseName);
    await foodListTableConn.clearDatabase(db);
    final result = await foodListTableConn.insertNewData(db: db, foods: list);
    await foodListTableConn.closeDatabase(db);
    return result;
  }

  //! Should get data from SQLite local db and upload it to Hasura
  @override
  Future<Success> uploadData(String userId) async {
    listOfFoodListData = [];
    List<Map<String, dynamic>> allFoods;
    try {
      final db = await foodListTableConn.open(DatabaseName);

      allFoods = await foodListTableConn.queryAllData(db);

      await foodListTableConn.closeDatabase(db);
    } catch (e) {
      throw SQLiteException();
    }

    if (allFoods.isEmpty) {
      throw EmptyDataException('You have no data in the local database');
    }

    try {
      for (var data in allFoods) {
        FoodListDataModel newFoodListData = FoodListDataModel.fromJson(data);
        newFoodListData.userId = userId;
        listOfFoodListData.add(newFoodListData);
      }
    } catch (e) {
      throw SQLiteException();
    }

    try {
      await hasuraConnect
          .mutation(KMutationDeleteFoodList, variables: {"userId": userId});

      for (FoodListDataModel food in listOfFoodListData) {
        await hasuraConnect.mutation(KMutationInsertFoodList,
            variables: food.toJson());
      }
      hasuraConnect.disconnect();
      return SuccessUpload(successMessage: 'Successful cloud sync');
    } catch (e) {
      throw ServerException();
    }
  }
}

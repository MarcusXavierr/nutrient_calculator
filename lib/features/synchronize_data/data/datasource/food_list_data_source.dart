import 'package:nutrients/core/error/exceptions.dart';
import 'package:nutrients/core/utils/success.dart';

abstract class FoodListDataSource {
  ///Calls the https://hasura-on-postgresql.herokuapp.com/v1/graphql endpoint.
  ///
  ///Throws a [ServerException] for server errors.
  ///Throws a [SQLiteException] for sqflite errors.
  Future<Success> uploadData(String userId);

  ///Calls the https://hasura-on-postgresql.herokuapp.com/v1/graphql endpoint.
  ///
  ///Throws a [ServerException] for server errors.
  ///Throws a [SQLiteException] for sqflite errors.
  Future<Success> downloadData(String userId);
}

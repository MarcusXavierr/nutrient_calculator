import 'package:nutrients/core/utils/success.dart';

abstract class FoodTrackerDataSource {
  ///Calls the https://hasura-on-postgresql.herokuapp.com/v1/graphql endpoint.
  ///
  ///Throws a [ServerException] for all error codes.
  Future<Success> uploadData(String userId);

  ///Calls the https://hasura-on-postgresql.herokuapp.com/v1/graphql endpoint.
  ///
  ///Throws a [ServerException] for all error codes.
  Future<Success> downloadData(String userId);
}

import 'package:nutrients/core/utils/success.dart';
import 'package:nutrients/features/synchronize_data/data/models/food_list_data_model.dart';

abstract class FoodListDataSource {
  ///Calls the https://hasura-on-postgresql.herokuapp.com/v1/graphql endpoint.
  ///
  ///Throws a [ServerException] for all error codes.
  Future<Success> uploadData(String userId);

  ///Calls the https://hasura-on-postgresql.herokuapp.com/v1/graphql endpoint.
  ///
  ///Throws a [ServerException] for all error codes.
  Future<Success> downloadData(String userId);
}

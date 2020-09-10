import 'package:dartz/dartz.dart';
import 'package:nutrients/core/error/failure.dart';
import 'package:nutrients/core/utils/success.dart';

abstract class FoodListDataRepository {
  Future<Either<Failure, Success>> uploadFoodListData(String userId);

  Future<Either<Failure, Success>> downloadFoodListData(String userId);
}

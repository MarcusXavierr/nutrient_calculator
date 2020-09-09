import 'package:dartz/dartz.dart';
import 'package:nutrients/core/error/failure.dart';
import 'package:nutrients/core/utils/success.dart';
import 'package:nutrients/features/synchronize_data/domain/entities/food_list_data.dart';

abstract class FoodListDataRepository {
  Future<Either<Failure, Success>> uploadFoodListData(String userId);

  Future<Either<Failure, FoodListData>> downloadFoodListData(String userId);
}

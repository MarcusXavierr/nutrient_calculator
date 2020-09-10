import 'package:dartz/dartz.dart';
import 'package:nutrients/core/error/failure.dart';
import 'package:nutrients/core/utils/success.dart';
import 'package:nutrients/features/synchronize_data/domain/entities/food_tracker_data.dart';

abstract class FoodTrackerDataRepository {
  Future<Either<Failure, Success>> uploadFoodTrackerData(String userId);

  Future<Either<Failure, Success>> downloadFoodTrackerData(String userId);
}

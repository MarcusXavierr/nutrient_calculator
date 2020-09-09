import 'package:dartz/dartz.dart';
import 'package:nutrients/core/error/failure.dart';
import 'package:nutrients/features/synchronize_data/domain/entities/food_tracker_data.dart';
import 'package:nutrients/features/synchronize_data/domain/repositories/food_tracker_data_repository.dart';

class DownloadFoodTrackerData {
  final FoodTrackerDataRepository repository;

  DownloadFoodTrackerData(this.repository);

  Future<Either<Failure, FoodTrackerData>> call(String userId) async {
    return await repository.downloadFoodTrackerData(userId);
  }
}

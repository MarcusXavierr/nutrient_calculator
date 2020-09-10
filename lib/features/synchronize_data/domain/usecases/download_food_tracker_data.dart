import 'package:dartz/dartz.dart';
import 'package:nutrients/core/error/failure.dart';
import 'package:nutrients/core/utils/success.dart';
import 'package:nutrients/features/synchronize_data/domain/repositories/food_tracker_data_repository.dart';

class DownloadFoodTrackerData {
  final FoodTrackerDataRepository repository;

  DownloadFoodTrackerData(this.repository);

  Future<Either<Failure, Success>> call(String userId) async {
    return await repository.downloadFoodTrackerData(userId);
  }
}

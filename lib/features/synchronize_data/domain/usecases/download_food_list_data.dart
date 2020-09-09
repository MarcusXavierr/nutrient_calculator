import 'package:dartz/dartz.dart';
import 'package:nutrients/core/error/failure.dart';
import 'package:nutrients/features/synchronize_data/domain/entities/food_list_data.dart';
import 'package:nutrients/features/synchronize_data/domain/repositories/food_list_repository.dart';

class DownloadFoodListData {
  final FoodListRepository repository;

  DownloadFoodListData(this.repository);

  Future<Either<Failure, FoodListData>> call(String userId) async {
    final result = await repository.downloadFoodListData(userId);
    return result;
  }
}

import 'package:dartz/dartz.dart';
import 'package:nutrients/core/error/failure.dart';
import 'package:nutrients/core/utils/success.dart';
import 'package:nutrients/features/synchronize_data/domain/repositories/food_list_data_repository.dart';

class UploadFoodListData {
  final FoodListDataRepository repository;

  UploadFoodListData(this.repository);

  Future<Either<Failure, Success>> call(String userId) async {
    final result = await repository.uploadFoodListData(userId);
    return result;
  }
}

import 'package:nutrients/core/error/exceptions.dart';
import 'package:nutrients/core/network/network_info.dart';
import 'package:nutrients/features/synchronize_data/data/datasource/food_list_data_source.dart';
import 'package:nutrients/features/synchronize_data/domain/entities/food_list_data.dart';
import 'package:nutrients/core/utils/success.dart';
import 'package:nutrients/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:nutrients/features/synchronize_data/domain/repositories/food_list_data_repository.dart';

class FoodListDataRepositoryImpl extends FoodListDataRepository {
  final NetworkInfo networkInfo;
  final FoodListDataSource dataSource;

  FoodListDataRepositoryImpl({
    @required this.networkInfo,
    @required this.dataSource,
  });
  @override
  Future<Either<Failure, FoodListData>> downloadFoodListData(String userId) {
    // TODO: implement downloadFoodListData
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Success>> uploadFoodListData(String userId) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }
    try {
      return Right(await dataSource.uploadData(userId));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}

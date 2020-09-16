import 'package:nutrients/core/error/exceptions.dart';
import 'package:nutrients/core/network/network_info.dart';
import 'package:nutrients/features/synchronize_data/data/datasource/food_list_data_source.dart';
import 'package:nutrients/core/utils/success.dart';
import 'package:nutrients/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:nutrients/features/synchronize_data/domain/repositories/food_list_data_repository.dart';

typedef Future<Success> _DownloadOrUpload();

class FoodListDataRepositoryImpl extends FoodListDataRepository {
  final NetworkInfo networkInfo;
  final FoodListDataSource dataSource;

  FoodListDataRepositoryImpl({
    @required this.networkInfo,
    @required this.dataSource,
  });
  @override
  Future<Either<Failure, Success>> downloadFoodListData(String userId) async {
    return await _downloadOrUploadData(() => dataSource.downloadData(userId));
  }

  @override
  Future<Either<Failure, Success>> uploadFoodListData(String userId) async {
    return await _downloadOrUploadData(() => dataSource.uploadData(userId));
  }

  Future<Either<Failure, Success>> _downloadOrUploadData(
    _DownloadOrUpload function,
  ) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }
    try {
      return Right(await function());
    } on ServerException {
      return Left(ServerFailure());
    } on SQLiteException {
      return Left(SQLiteFailure());
    } on EmptyDataException {
      return Left(EmptyDataFailure('You don\'t have data to synchronize'));
    }
  }
}

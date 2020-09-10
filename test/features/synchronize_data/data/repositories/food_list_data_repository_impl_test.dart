import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:nutrients/core/error/exceptions.dart';
import 'package:nutrients/core/error/failure.dart';
import 'package:nutrients/core/network/network_info.dart';
import 'package:nutrients/core/utils/success.dart';
import 'package:nutrients/features/synchronize_data/data/datasource/food_list_data_source.dart';
import 'package:nutrients/features/synchronize_data/data/repositories/food_list_data_repository_impl.dart';

class MockFoodListDataSource extends Mock implements FoodListDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  FoodListDataRepositoryImpl repository;
  MockNetworkInfo mockNetworkInfo;
  MockFoodListDataSource mockFoodListDataSource;

  setUp(() {
    mockNetworkInfo = MockNetworkInfo();
    mockFoodListDataSource = MockFoodListDataSource();
    repository = FoodListDataRepositoryImpl(
      networkInfo: mockNetworkInfo,
      dataSource: mockFoodListDataSource,
    );
  });

  final tUserId = 'userId';

  void runTestsOnline(Function body) {
    group('Device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestsOffline(Function body) {
    group('Device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group('uploadFoodListData', () {
    final tSuccesUpload = SuccessUpload(successMessage: 'Affected Rows: 1');
    test(
      'should check if the device is online',
      () async {
        // Arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        //Act
        repository.uploadFoodListData(tUserId);
        //Assert
        verify(mockNetworkInfo.isConnected);
      },
    );

    runTestsOnline(() {
      test(
        'should return FoodListDataModel when the call is successful',
        () async {
          // Arrange
          when(mockFoodListDataSource.uploadData(tUserId))
              .thenAnswer((_) async => tSuccesUpload);
          //Act
          final result = await repository.uploadFoodListData(tUserId);
          //Assert
          verify(mockFoodListDataSource.uploadData(tUserId));
          expect(result, Right(tSuccesUpload));
        },
      );

      test(
        'should return Server Failure if the call is not successful',
        () async {
          // Arrange
          when(mockFoodListDataSource.uploadData(any))
              .thenThrow(ServerException());
          //Act
          final result = await repository.uploadFoodListData(tUserId);
          //Assert
          verify(mockFoodListDataSource.uploadData(tUserId));
          expect(result, Left(ServerFailure()));
        },
      );
    });

    runTestsOffline(() {
      test(
        'should return NetWorkFailure if the device if offline',
        () async {
          //Act
          final result = await repository.uploadFoodListData(tUserId);
          //Assert
          verifyZeroInteractions(mockFoodListDataSource);
          expect(result, Left(NetworkFailure()));
        },
      );
    });
  });

//!
//!
//!
//!
//!
//! New group of tests
  group('downloadFoodListData', () {
    final tSuccessDownload = SuccessDownload(successMessage: 'Deu tudo certo');
    test(
      'should check if the device is online',
      () async {
        // Arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        //Act
        repository.downloadFoodListData(tUserId);
        //Assert
        verify(mockNetworkInfo.isConnected);
      },
    );

    runTestsOnline(() {
      test(
        'should return FoodListDataModel when the call is successful',
        () async {
          // Arrange
          when(mockFoodListDataSource.downloadData(tUserId))
              .thenAnswer((_) async => tSuccessDownload);
          //Act
          final result = await repository.downloadFoodListData(tUserId);
          //Assert
          verify(mockFoodListDataSource.downloadData(tUserId));
          expect(result, Right(tSuccessDownload));
        },
      );

      test(
        'should return Server Failure if the call is not successful',
        () async {
          // Arrange
          when(mockFoodListDataSource.downloadData(any))
              .thenThrow(ServerException());
          //Act
          final result = await repository.downloadFoodListData(tUserId);
          //Assert
          verify(mockFoodListDataSource.downloadData(tUserId));
          expect(result, Left(ServerFailure()));
        },
      );
    });

    runTestsOffline(() {
      test(
        'should return NetWorkFailure if the device if offline',
        () async {
          //Act
          final result = await repository.downloadFoodListData(tUserId);
          //Assert
          verifyZeroInteractions(mockFoodListDataSource);
          expect(result, Left(NetworkFailure()));
        },
      );
    });
  });
}

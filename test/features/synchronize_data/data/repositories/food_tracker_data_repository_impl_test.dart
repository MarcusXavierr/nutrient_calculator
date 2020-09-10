import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:nutrients/core/error/exceptions.dart';
import 'package:nutrients/core/error/failure.dart';
import 'package:nutrients/core/network/network_info.dart';
import 'package:nutrients/core/utils/success.dart';
import 'package:nutrients/features/synchronize_data/data/datasource/food_tracker_data_source.dart';
import 'package:nutrients/features/synchronize_data/data/repositories/food_tracker_data_repository_impl.dart';

class MockFoodTrackerDataSource extends Mock implements FoodTrackerDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  MockFoodTrackerDataSource mockFoodTrackerDataSource;
  MockNetworkInfo mockNetworkInfo;
  FoodTrackerDataRepositoryImpl repository;

  setUp(() {
    mockFoodTrackerDataSource = MockFoodTrackerDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = FoodTrackerDataRepositoryImpl(
      dataSource: mockFoodTrackerDataSource,
      networkInfo: mockNetworkInfo,
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

  group('uploadFoodListData', () {
    final tSuccesUpload = SuccessUpload(successMessage: 'Affected Rows: 1');
    runTestsOnline(() {
      test(
        'should check if the device is online',
        () async {
          //Act
          repository.uploadFoodListData(tUserId);
          //Assert
          verify(mockNetworkInfo.isConnected);
        },
      );

      test(
        'should return Success from datasource',
        () async {
          // Arrange
          when(mockFoodTrackerDataSource.uploadData(any))
              .thenAnswer((realInvocation) async => tSuccesUpload);
          //Act
          final result = await repository.uploadFoodListData(tUserId);
          //Assert
          verify(mockFoodTrackerDataSource.uploadData(tUserId));
          expect(result, Right(tSuccesUpload));
        },
      );

      test(
        'should return ServerFailure if the call is not successful',
        () async {
          // Arrange
          when(mockFoodTrackerDataSource.uploadData(any))
              .thenThrow(ServerException());
          //Act
          final result = await repository.uploadFoodListData(tUserId);
          //Assert
          expect(result, Left(ServerFailure()));
        },
      );
    });

    test(
      'should return NetworkFailure if device is offline',
      () async {
        // Arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
        //Act
        final result = await repository.uploadFoodListData(tUserId);
        //Assert
        expect(result, Left(NetworkFailure()));
        verifyZeroInteractions(mockFoodTrackerDataSource);
      },
    );
  });

//!
//!
//!
//!
//!
//! NEW GROUP OF TESTS

  group('downloadFoodListData', () {
    final tSuccessDownload =
        SuccessDownload(successMessage: 'Affected Rows: 1');
    runTestsOnline(() {
      test(
        'should check if the device is online',
        () async {
          //Act
          repository.downloadFoodListData(tUserId);
          //Assert
          verify(mockNetworkInfo.isConnected);
        },
      );

      test(
        'should return Success from datasource',
        () async {
          // Arrange
          when(mockFoodTrackerDataSource.downloadData(any))
              .thenAnswer((realInvocation) async => tSuccessDownload);
          //Act
          final result = await repository.downloadFoodListData(tUserId);
          //Assert
          verify(mockFoodTrackerDataSource.downloadData(tUserId));
          expect(result, Right(tSuccessDownload));
        },
      );

      test(
        'should return ServerFailure if the call is not successful',
        () async {
          // Arrange
          when(mockFoodTrackerDataSource.downloadData(any))
              .thenThrow(ServerException());
          //Act
          final result = await repository.downloadFoodListData(tUserId);
          //Assert
          expect(result, Left(ServerFailure()));
        },
      );
    });

    test(
      'should return NetworkFailure if device is offline',
      () async {
        // Arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
        //Act
        final result = await repository.downloadFoodListData(tUserId);
        //Assert
        expect(result, Left(NetworkFailure()));
        verifyZeroInteractions(mockFoodTrackerDataSource);
      },
    );
  });
}

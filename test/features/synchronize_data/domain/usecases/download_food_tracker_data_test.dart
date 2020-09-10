import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:nutrients/core/utils/success.dart';
import 'package:nutrients/features/synchronize_data/domain/repositories/food_tracker_data_repository.dart';
import 'package:nutrients/features/synchronize_data/domain/usecases/download_food_tracker_data.dart';

class MockFoodTrackerData extends Mock implements FoodTrackerDataRepository {}

void main() {
  MockFoodTrackerData mockFoodTrackerData;
  DownloadFoodTrackerData usecase;

  setUp(() {
    mockFoodTrackerData = MockFoodTrackerData();
    usecase = DownloadFoodTrackerData(mockFoodTrackerData);
  });

  final tUserId = 'UserId';
  final tSuccessDownload = SuccessDownload(successMessage: 'Affected Rows: 1');

  test(
    'should return FoodTrackerData from FoodTrackerDataRepository',
    () async {
      // Arrange
      when(mockFoodTrackerData.downloadFoodTrackerData(tUserId))
          .thenAnswer((_) async => Right(tSuccessDownload));
      //Act
      final result = await usecase.call(tUserId);
      //Assert
      expect(result, Right(tSuccessDownload));
    },
  );
}

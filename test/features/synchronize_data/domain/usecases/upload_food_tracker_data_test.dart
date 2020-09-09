import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:nutrients/core/utils/success.dart';
import 'package:nutrients/features/synchronize_data/domain/repositories/food_tracker_data_repository.dart';

import 'package:nutrients/features/synchronize_data/domain/usecases/upload_food_tracker_data.dart';

class MockFoodTrackerRepository extends Mock
    implements FoodTrackerDataRepository {}

void main() {
  MockFoodTrackerRepository mockFoodTrackerRepository;
  UploadFoodTrackerData usecase;

  setUp(() {
    mockFoodTrackerRepository = MockFoodTrackerRepository();
    usecase = UploadFoodTrackerData(mockFoodTrackerRepository);
  });
  final tUserId = 'UserId';
  final tSuccesUpload = SuccessUpload(successMessage: 'Affected Rows: 1');
  test(
    'should return Success from FoodTrackerRepository',
    () async {
      // Arrange
      when(mockFoodTrackerRepository.uploadFoodTrackerData(tUserId))
          .thenAnswer((_) async => Right(tSuccesUpload));
      //Act
      final result = await usecase.call(tUserId);
      //Assert
      expect(result, Right(tSuccesUpload));
    },
  );
}

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:nutrients/core/utils/success.dart';
import 'package:nutrients/features/synchronize_data/domain/repositories/food_list_data_repository.dart';
import 'package:nutrients/features/synchronize_data/domain/usecases/download_food_list_data.dart';

class MockFoodListRepository extends Mock implements FoodListDataRepository {}

void main() {
  MockFoodListRepository mockFoodListRepository;
  DownloadFoodListData usecase;
  setUp(() {
    mockFoodListRepository = MockFoodListRepository();
    usecase = DownloadFoodListData(mockFoodListRepository);
  });

  final tUserId = 'UserId';
  final tSuccessDownload = SuccessDownload(successMessage: 'Affected Rows: 1');
  test(
    'should return a FoodListData from repository',
    () async {
      // Arrange
      when(mockFoodListRepository.downloadFoodListData(tUserId))
          .thenAnswer((_) async => Right(tSuccessDownload));
      //Act
      final result = await usecase.call(tUserId);
      //Assert
      expect(result, Right(tSuccessDownload));
    },
  );
}

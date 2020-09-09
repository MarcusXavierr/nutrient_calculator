import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:nutrients/features/synchronize_data/domain/entities/food_list_data.dart';
import 'package:nutrients/features/synchronize_data/domain/repositories/food_list_repository.dart';
import 'package:nutrients/features/synchronize_data/domain/usecases/download_food_list_data.dart';

class MockFoodListRepository extends Mock implements FoodListRepository {}

void main() {
  MockFoodListRepository mockFoodListRepository;
  DownloadFoodListData usecase;
  setUp(() {
    mockFoodListRepository = MockFoodListRepository();
    usecase = DownloadFoodListData(mockFoodListRepository);
  });

  final tUserId = 'UserId';
  final tFoodListData = FoodListData(
      carbo: 12.0, fat: 12.5, protein: 12.9, name: 'seila', userId: tUserId);
  test(
    'should return a FoodListData from repository',
    () async {
      // Arrange
      when(mockFoodListRepository.downloadFoodListData(tUserId))
          .thenAnswer((_) async => Right(tFoodListData));
      //Act
      final result = await usecase.call(tUserId);
      //Assert
      expect(result, Right(tFoodListData));
    },
  );
}

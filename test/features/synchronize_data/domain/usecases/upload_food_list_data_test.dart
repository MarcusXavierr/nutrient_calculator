import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:nutrients/core/utils/success.dart';
import 'package:nutrients/features/synchronize_data/domain/repositories/food_list_repository.dart';
import 'package:nutrients/features/synchronize_data/domain/usecases/upload_food_list_data.dart';

class MockFoodListRepository extends Mock implements FoodListRepository {}

void main() {
  UploadFoodListData usecase;
  MockFoodListRepository mockFoodListRepository;

  setUp(() {
    mockFoodListRepository = MockFoodListRepository();
    usecase = UploadFoodListData(mockFoodListRepository);
  });

  final tSuccesUpload = SuccessUpload('Affected Rows: 1');
  final tUserId = 'userId';
  test(
    'should return a Success from Repository',
    () async {
      // Arrange
      when(mockFoodListRepository.uploadFoodListData(tUserId))
          .thenAnswer((_) async => Right(tSuccesUpload));
      //Act
      final result = await usecase.call(tUserId);
      //Assert
      expect(result, Right(tSuccesUpload));
    },
  );
}

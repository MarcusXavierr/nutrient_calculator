import 'package:nutrients/models/food_tracker_model.dart';
import 'package:nutrients/repositories/food_tracker_repository.dart';

class FoodTrackerController {
  FoodTrackerRepository repository;

  FoodTrackerController() {
    repository = FoodTrackerRepository();
  }

  Future<void> create(FoodTrackerModel model) async {
    await repository.create(model);
  }

  Future<List<FoodTrackerModel>> read() async {
    DateTime today = new DateTime.now();
    String datetime =
        "${today.year.toString()}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}";
    final List<Map<String, dynamic>> maps =
        await repository.recoverFoodTracker(datetime);

    return List.generate(maps.length, (i) {
      return FoodTrackerModel(
        id: maps[i]['id'],
        foodProtein: maps[i]['food_protein'],
        foodCarbo: maps[i]['food_carbo'],
        foodFat: maps[i]['food_fat'],
        foodId: maps[i]['food_id'],
        datetime: maps[i]['datetime'],
      );
    });
  }
}

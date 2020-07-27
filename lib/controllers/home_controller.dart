import 'package:nutrients/components/food_tracker.dart';
import 'package:nutrients/controllers/food_controller.dart';
import 'package:nutrients/models/food_model.dart';

class HomeController {
  final FoodController foodController = FoodController();
  List<FoodTracker> foodTrackerList;

  Future getFoods() async {
    List<FoodTracker> foodTrackerList = [];

    final List<FoodModel> allFoods = await foodController.readAll();

    for (var food in allFoods) {
      print(food.toJson());
      var foodTracker = FoodTracker(
        counter: 1,
        foodName: food.name,
        fat: food.fat,
        carbo: food.carbo,
        protein: food.protein,
        id: food.id,
      );

      foodTrackerList.add(foodTracker);
    }

    return allFoods;
  }
}

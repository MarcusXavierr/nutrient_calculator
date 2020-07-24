import 'package:nutrients/controllers/food_controller.dart';
import 'package:nutrients/models/food_model.dart';

class HomeController {
  final FoodController foodController = FoodController();

  Future<List<FoodModel>> getFoods() async {
    final List<FoodModel> allFoods = await foodController.readAll();

    for (var food in allFoods) {
      print(food.toJson());
    }

    return allFoods;
  }
}

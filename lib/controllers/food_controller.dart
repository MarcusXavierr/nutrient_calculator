import 'package:nutrients/models/food_model.dart';
import 'package:nutrients/repositories/food_repository.dart';
import 'dart:async';

class FoodController {
  FoodRepository repository;

  FoodController() {
    repository = new FoodRepository();
  }
  dynamic create(FoodModel model) async {
    String response = await repository.createFood(model);
    List<FoodModel> allFoods = await readAll();
    for (var food in allFoods) {
      print(food.toJson());
    }

    return response;
  }

  Future<List<FoodModel>> readAll() async {
    final List<Map<String, dynamic>> maps = await repository.recoverAllFoods();

    return List.generate(maps.length, (i) {
      return FoodModel(
        id: maps[i]['id'],
        name: maps[i]['name'],
        protein: maps[i]['protein'],
        carbo: maps[i]['carbo'],
        fat: maps[i]['fat'],
      );
    });
  }

  Future readFood(int id) async {
    try {
      List food = await repository.recoverFood(id);

      return List.generate(food.length, (i) {
        return FoodModel(
          id: food[i]['id'],
          name: food[i]['name'],
          protein: food[i]['protein'],
          carbo: food[i]['carbo'],
          fat: food[i]['fat'],
        );
      });
    } catch (e) {
      print(e);
    }
  }

  dynamic update(FoodModel model) async {
    String response = await repository.updateFood(model);

    return response;
  }

  dynamic delete(int id) async {
    bool response = await repository.deleteFood(id);

    return response;
  }
}

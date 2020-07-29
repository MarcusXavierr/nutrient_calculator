import 'package:mobx/mobx.dart';
import 'package:nutrients/controllers/food_controller.dart';
import 'package:nutrients/models/food_model.dart';

part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  final FoodController foodController = FoodController();
  @observable
  List<FoodModel> foods;

  @action
  Future<void> getFoods() async {
    var allFoods = await foodController.readAll();
    foods = allFoods;
  }
}

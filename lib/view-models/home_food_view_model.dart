import 'package:mobx/mobx.dart';
import 'package:nutrients/controllers/food_tracker_controller.dart';
import 'package:nutrients/models/food_tracker_model.dart';
part 'home_food_view_model.g.dart';

class HomeFoodViewModel = _HomeFoodViewModelBase with _$HomeFoodViewModel;

abstract class _HomeFoodViewModelBase with Store {
  FoodTrackerController _controller;

  _HomeFoodViewModelBase() {
    _controller = FoodTrackerController();
  }

  @observable
  int _protein = 0;

  @observable
  int _carbo = 0;

  @observable
  int _fat = 0;

  int get protein => _protein;

  int get carbo => _carbo;
  int get fat => _fat;

  @action
  setProtein(double value) => _protein = value.round();

  @action
  setCarbo(double value) => _carbo = value.round();

  @action
  setFat(double value) => _fat = value.round();

  Future<List<FoodTrackerModel>> getAll() async {
    List<FoodTrackerModel> trackerList = await _controller.read();
    return trackerList;
  }

  getProtein() async {
    var trackerList = await getAll();
    double value = 0;
    for (var tracker in trackerList) {
      value += tracker.foodProtein;
    }
    setProtein(value);
  }

  getCarbo() async {
    var trackerList = await getAll();
    double value = 0;
    for (var tracker in trackerList) {
      value += tracker.foodCarbo;
    }
    setCarbo(value);
  }

  getFat() async {
    var trackerList = await getAll();
    double value = 0;
    for (var tracker in trackerList) {
      value += tracker.foodFat;
    }
    setFat(value);
  }

  setAllValues() async {
    await getProtein();
    await getFat();
    await getCarbo();
  }
}

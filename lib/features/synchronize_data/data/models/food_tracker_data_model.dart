import 'package:meta/meta.dart';
import 'package:nutrients/features/synchronize_data/domain/entities/food_tracker_data.dart';

class FoodTrackerDataModel extends FoodTrackerData {
  String userId;
  double foodProtein;
  double foodCarbo;
  double foodFat;
  String datetime;

  FoodTrackerDataModel({
    @required this.foodCarbo,
    @required this.foodFat,
    @required this.foodProtein,
    @required this.userId,
    @required this.datetime,
  });

  /// * You should pass json['data']['food_tracker'] to this function
  FoodTrackerDataModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    foodFat = json['food_fat'];
    foodProtein = json['food_protein'];
    foodCarbo = json['food_carbo'];
    datetime = json['datetime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['food_fat'] = this.foodFat;
    data['food_protein'] = this.foodProtein;
    data['food_carbo'] = this.foodCarbo;
    data['datetime'] = this.datetime;
    return data;
  }
}

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
    foodFat = json['food_fat'].toDouble();
    foodProtein = json['food_protein'].toDouble();
    foodCarbo = json['food_carbo'].toDouble();
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

  Map<String, dynamic> toMap() {
    return {
      'food_id': 1,
      'food_protein': foodProtein,
      'food_carbo': foodCarbo,
      'food_fat': foodFat,
      'datetime': datetime,
    };
  }
}

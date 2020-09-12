import 'package:meta/meta.dart';
import 'package:nutrients/features/synchronize_data/domain/entities/food_list_data.dart';

class FoodListDataModel extends FoodListData {
  double carbo;
  double protein;
  String name;
  String userId;
  double fat;

  FoodListDataModel({
    @required this.carbo,
    @required this.protein,
    @required this.name,
    @required this.userId,
    @required this.fat,
  });

  /// * You should pass json['data']['food_list'] to this function
  FoodListDataModel.fromJson(Map<String, dynamic> json) {
    carbo = json['carbo'].toDouble();
    protein = json['protein'].toDouble();
    name = json['name'];
    userId = json['user_id'];
    fat = json['fat'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['carbo'] = this.carbo;
    data['protein'] = this.protein;
    data['name'] = this.name;
    data['user_id'] = this.userId;
    data['fat'] = this.fat;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'protein': protein,
      'carbo': carbo,
      'fat': fat,
    };
  }
}

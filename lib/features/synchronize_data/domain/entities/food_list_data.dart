import 'package:meta/meta.dart';

class FoodListData {
  String userId;
  String name;
  double protein;
  double carbo;
  double fat;

  FoodListData({
    @required this.userId,
    @required this.name,
    @required this.protein,
    @required this.carbo,
    @required this.fat,
  });
}

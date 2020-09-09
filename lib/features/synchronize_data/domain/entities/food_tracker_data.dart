import 'package:meta/meta.dart';

class FoodTrackerData {
  String userId;
  double foodProtein;
  double foodCarbo;
  double foodFat;
  String datetime;

  FoodTrackerData({
    @required this.foodCarbo,
    @required this.foodFat,
    @required this.foodProtein,
    @required this.userId,
    @required this.datetime,
  });
}

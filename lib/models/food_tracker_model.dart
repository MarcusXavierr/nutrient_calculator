class FoodTrackerModel {
  int id;
  int foodId;
  double foodCarbo;
  double foodProtein;
  double foodFat;
  String datetime;

  FoodTrackerModel({
    this.id,
    this.foodId,
    this.foodCarbo,
    this.foodProtein,
    this.foodFat,
    this.datetime,
  });

  FoodTrackerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    foodId = json['food_id'];
    foodCarbo = json['food_carbo'];
    foodProtein = json['food_protein'];
    foodFat = json['food_fat'];
    datetime = json['datetime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['food_id'] = this.foodId;
    data['food_carbo'] = this.foodCarbo;
    data['food_protein'] = this.foodProtein;
    data['food_fat'] = this.foodFat;
    data['datetime'] = this.datetime;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'food_id': foodId,
      'food_protein': foodProtein,
      'food_carbo': foodCarbo,
      'food_fat': foodFat,
      'datetime': datetime,
    };
  }
}

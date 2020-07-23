class FoodModel {
  int id;
  String name;
  double protein;
  double carbo;
  double fat;

  FoodModel({this.id, this.name, this.protein, this.carbo, this.fat});

  FoodModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    protein = json['protein'];
    carbo = json['carbo'];
    fat = json['fat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['protein'] = this.protein;
    data['carbo'] = this.carbo;
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

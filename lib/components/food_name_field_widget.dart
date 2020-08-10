import 'package:flutter/material.dart';
import 'package:nutrients/screens/edit_food_view.dart';

class FoodNameFieldWidget extends StatelessWidget {
  const FoodNameFieldWidget({
    Key key,
    @required this.foodName,
    @required this.carbo,
    @required this.id,
    @required this.protein,
    @required this.fat,
  }) : super(key: key);

  final String foodName;
  final double carbo;
  final int id;
  final double protein;
  final double fat;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditFoodView(
              foodName: foodName,
              carbo: carbo,
              id: id,
              protein: protein,
              fat: fat,
            ),
          ),
        ),
        child: Text(
          foodName,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

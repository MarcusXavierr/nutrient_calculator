import 'package:flutter/material.dart';
import 'package:nutrients/components/round_button.dart';
import 'package:nutrients/models/Controller.dart';

Controller controller = Controller();

class FoodTracker extends StatelessWidget {
  FoodTracker({
    @required this.counter,
    this.foodName,
    this.carbo,
    this.fat,
    this.protein,
    this.id,
  });

  final int counter;
  final String foodName;
  final double carbo;
  final double protein;
  final double fat;
  final int id;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0),
      child: Row(
        children: <Widget>[
          Row(
            children: <Widget>[
              RoundIconButton(
                icon: Icons.add,
                onPressed: () {
                  print(foodName);
                  print(fat);
                  print(protein);
                  print(carbo);
                  print(id);
                  print('________');
                },
              ),
              SizedBox(width: 7.0),
              RoundIconButton(
                icon: Icons.remove,
                onPressed: () {
                  controller.printDogs();
                },
              ),
              SizedBox(width: 15.0),
            ],
          ),
          Expanded(
            child: Text(
              foodName,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          SizedBox(width: 10),
          Text(
            counter.toString(),
            style: TextStyle(
              color: Colors.blueGrey.shade700,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}

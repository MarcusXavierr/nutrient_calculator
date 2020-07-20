import 'package:flutter/material.dart';
import 'package:nutrients/components/round_button.dart';

class FoodTracker extends StatelessWidget {
  FoodTracker({@required this.counter, this.foodName});
  final int counter;
  final String foodName;

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
                onPressed: () {},
              ),
              SizedBox(width: 7.0),
              RoundIconButton(
                icon: Icons.remove,
                onPressed: () {},
              ),
              SizedBox(width: 15.0),
              Text(
                counter.toString(),
                style: TextStyle(
                  color: Colors.blueGrey.shade700,
                  fontSize: 20,
                ),
              ),
              SizedBox(width: 10),
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
        ],
      ),
    );
  }
}

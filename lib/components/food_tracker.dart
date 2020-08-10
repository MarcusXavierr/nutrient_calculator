import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:nutrients/components/food_name_field_widget.dart';
import 'package:nutrients/components/round_button.dart';
import 'package:nutrients/components/warning_add_food_widget.dart';
import 'package:nutrients/controllers/food_tracker_controller.dart';
import 'package:nutrients/models/food_tracker_model.dart';
import 'package:nutrients/screens/edit_food_view.dart';
import 'package:nutrients/view-models/home_food_view_model.dart';

class FoodTracker extends StatelessWidget {
  FoodTracker({
    @required this.counter,
    this.foodName,
    this.carbo,
    this.fat,
    this.protein,
    this.id,
  }) {
    model.foodCarbo = this.carbo;
    model.foodFat = this.fat;
    model.foodId = this.id;
    model.foodProtein = this.protein;
  }

  final int counter;
  final String foodName;
  final double carbo;
  final double protein;
  final double fat;
  final int id;

  FoodTrackerController _controller = FoodTrackerController();
  FoodTrackerModel model = FoodTrackerModel();
  final homeFoodViewModel = GetIt.I.get<HomeFoodViewModel>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
      child: Row(
        children: <Widget>[
          Row(
            children: <Widget>[
              RoundIconButton(
                icon: Icons.add,
                onPressed: () {
                  warningAddFoodWidget(
                      context: context,
                      addLogic: () async {
                        DateTime today = new DateTime.now();
                        model.datetime =
                            "${today.year.toString()}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}";
                        await _controller.create(model);
                        await homeFoodViewModel.setAllValues();
                        Navigator.pop(context);
                      }).show();
                },
              ),
              SizedBox(width: 25.0),
            ],
          ),
          FoodNameFieldWidget(
            foodName: foodName,
            carbo: carbo,
            id: id,
            protein: protein,
            fat: fat,
          ),
          SizedBox(width: 10),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nutrients/components/food_tracker.dart';
import 'package:nutrients/controllers/home_controller.dart';

class FoodListWidget extends StatelessWidget {
  final _controller = GetIt.I.get<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (BuildContext context) {
        return Column(
          children: _controller.foods != null
              ? _controller.foods.length != 0
                  ? _controller.foods
                      .map<Widget>(
                        (food) => FoodTracker(
                          counter: 1,
                          foodName: food.name,
                          fat: food.fat,
                          id: food.id,
                          carbo: food.carbo,
                          protein: food.protein,
                        ),
                      )
                      .toList()
                  : <Widget>[Container()]
              : <Widget>[Container()],
        );
      },
    );
  }
}

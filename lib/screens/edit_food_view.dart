import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:nutrients/components/form_body_edit_widget.dart';
import 'package:nutrients/controllers/food_controller.dart';
import 'package:nutrients/controllers/home_controller.dart';
import 'package:nutrients/controllers/insert_food_controller.dart';
import 'package:nutrients/models/food_model.dart';

class EditFoodView extends StatefulWidget {
  EditFoodView({
    this.foodName,
    this.carbo,
    this.fat,
    this.protein,
    this.id,
  });
  final String foodName;
  final double carbo;
  final double protein;
  final double fat;
  final int id;

  @override
  _EditFoodViewState createState() => _EditFoodViewState();
}

class _EditFoodViewState extends State<EditFoodView> {
  final homeController = GetIt.I.get<HomeController>();
  final FoodController foodController = FoodController();
  final FoodModel foodModel = FoodModel();
  final _controller = InsertFoodController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    foodModel.carbo = this.widget.carbo;
    foodModel.id = this.widget.id;
    foodModel.protein = this.widget.protein;
    foodModel.name = this.widget.foodName;
    foodModel.fat = this.widget.fat;
  }

  @override
  void dispose() {
    super.dispose();
    homeController.getFoods();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: Text('Nutrient Calculator'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Edit Food',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 37.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 20.0),
                      child: FormBodyEditWidget(
                        foodModel: foodModel,
                        controller: _controller,
                        formKey: _formKey,
                        foodController: foodController,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

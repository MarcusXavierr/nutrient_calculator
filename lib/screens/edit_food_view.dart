import 'package:flutter/material.dart';
import 'package:nutrients/components/alert_dialog_widget.dart';
import 'package:nutrients/components/form_button.dart';
import 'package:nutrients/components/warning_delete_widget.dart';

import 'package:nutrients/constants.dart';
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
  HomeController homeController = HomeController();
  final FoodController foodController = FoodController();
  final FoodModel foodModel = FoodModel();
  final _controller = InsertFoodController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    print(this.widget.foodName);
    foodModel.carbo = this.widget.carbo;
    foodModel.id = this.widget.id;
    foodModel.protein = this.widget.protein;
    foodModel.name = this.widget.foodName;
    foodModel.fat = this.widget.fat;
    print(foodModel.id);
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
        title: Text('Calculadora de nutrientes'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Editar Alimento',
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
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            onSaved: (value) => foodModel.name = value,
                            keyboardType: TextInputType.text,
                            initialValue: foodModel.name,
                            decoration: InputDecoration(
                              hintText: 'Insira o nome do alimento',
                              labelText: 'Nome',
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Por favor preencha o campo";
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: kSizedBoxHeight,
                          ),
                          TextFormField(
                            onSaved: (value) =>
                                foodModel.protein = _controller.saver(value),
                            initialValue: foodModel.protein.toString(),
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              hintText: 'Insira a quantidade de proteína',
                              labelText: 'Proteína',
                            ),
                            validator: (value) => _controller.validator(value),
                          ),
                          SizedBox(
                            height: kSizedBoxHeight,
                          ),
                          TextFormField(
                            onSaved: (value) =>
                                foodModel.carbo = _controller.saver(value),
                            initialValue: foodModel.carbo.toString(),
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              hintText: 'Insira a quantidade de carboidrato',
                              labelText: 'Carboidrato',
                            ),
                            validator: (value) => _controller.validator(value),
                          ),
                          SizedBox(
                            height: kSizedBoxHeight,
                          ),
                          TextFormField(
                            onSaved: (value) =>
                                foodModel.fat = _controller.saver(value),
                            initialValue: foodModel.fat.toString(),
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              hintText: 'Insira a quantidade de gordura',
                              labelText: 'Gordura',
                            ),
                            validator: (value) => _controller.validator(value),
                          ),
                          SizedBox(
                            height: 40.0,
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: FormButton(
                                  text: 'Salvar',
                                  colour: Theme.of(context).primaryColor,
                                  onPressed: () async {
                                    if (_formKey.currentState.validate()) {
                                      _formKey.currentState.save();

                                      String dialog = await foodController
                                          .update(foodModel);

                                      return buildAlert(dialog, context).show();
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(width: 15.0),
                              Expanded(
                                child: FormButton(
                                  onPressed: () {
                                    return warningDelete(
                                      context: context,
                                      deleteLogic: () async {
                                        foodController.delete(foodModel.id);
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                      },
                                    ).show();
                                  },
                                  text: 'Apagar',
                                  colour: Colors.red,
                                ),
                              )
                            ],
                          ),
                        ],
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

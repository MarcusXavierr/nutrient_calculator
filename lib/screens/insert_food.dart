import 'package:flutter/material.dart';

import 'package:nutrients/constants.dart';
import 'package:nutrients/controllers/food_controller.dart';
import 'package:nutrients/controllers/insert_food_controller.dart';
import 'package:nutrients/models/food_model.dart';

class InsertFood extends StatefulWidget {
  @override
  _InsertFoodState createState() => _InsertFoodState();
}

class _InsertFoodState extends State<InsertFood> {
  final FoodController foodController = FoodController();
  final FoodModel foodModel = FoodModel();
  final _controller = InsertFoodController();
  final _formKey = GlobalKey<FormState>();
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
                'Insira um alimento',
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
                          RaisedButton(
                            color: Theme.of(context).primaryColor,
                            padding: EdgeInsets.symmetric(
                              horizontal: 30.0,
                              vertical: 10.0,
                            ),
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                              }
                            },
                            textColor: Colors.white,
                            child: Text(
                              'Enviar',
                              style: TextStyle(fontSize: 23.0),
                            ),
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

import 'package:flutter/material.dart';
import 'package:nutrients/components/alert_dialog_widget.dart';
import 'package:nutrients/components/form_button.dart';
import 'package:nutrients/controllers/food_controller.dart';
import 'package:nutrients/controllers/insert_food_controller.dart';
import 'package:nutrients/models/food_model.dart';
import '../constants.dart';

class FormBodyInsertWidget extends StatelessWidget {
  const FormBodyInsertWidget({
    Key key,
    @required this.foodModel,
    @required InsertFoodController controller,
    @required GlobalKey<FormState> formKey,
    @required this.foodController,
  })  : _controller = controller,
        _formKey = formKey,
        super(key: key);

  final FoodModel foodModel;
  final InsertFoodController _controller;
  final GlobalKey<FormState> _formKey;
  final FoodController foodController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextFormField(
          onSaved: (value) => foodModel.name = value,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
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
          onSaved: (value) => foodModel.protein = _controller.saver(value),
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Insira a quantidade de proteína',
            labelText: 'Proteína',
          ),
          validator: (value) => _controller.validator(value),
        ),
        SizedBox(
          height: kSizedBoxHeight,
        ),
        TextFormField(
          onSaved: (value) => foodModel.carbo = _controller.saver(value),
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Insira a quantidade de carboidrato',
            labelText: 'Carboidrato',
          ),
          validator: (value) => _controller.validator(value),
        ),
        SizedBox(
          height: kSizedBoxHeight,
        ),
        TextFormField(
          onSaved: (value) => foodModel.fat = _controller.saver(value),
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Insira a quantidade de gordura',
            labelText: 'Gordura',
          ),
          validator: (value) => _controller.validator(value),
        ),
        SizedBox(
          height: 40.0,
        ),
        FormButton(
          text: 'Salvar',
          colour: Theme.of(context).primaryColor,
          onPressed: () async {
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();

              String dialog = await foodController.create(foodModel);
              return buildAlert(dialog, context).show();
            }

            return null;
          },
        ),
      ],
    );
  }
}

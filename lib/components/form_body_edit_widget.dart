import 'package:flutter/material.dart';
import 'package:nutrients/components/alert_dialog_widget.dart';
import 'package:nutrients/components/form_button.dart';
import 'package:nutrients/components/warning_delete_widget.dart';
import 'package:nutrients/controllers/food_controller.dart';
import 'package:nutrients/controllers/insert_food_controller.dart';
import 'package:nutrients/models/food_model.dart';
import '../constants.dart';

class FormBodyEditWidget extends StatelessWidget {
  const FormBodyEditWidget({
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
          initialValue: foodModel.name,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter the name of the food',
            labelText: 'Name',
          ),
          validator: (value) {
            if (value.isEmpty) {
              return "Please fill in the field";
            }
            return null;
          },
        ),
        SizedBox(
          height: kSizedBoxHeight,
        ),
        TextFormField(
          onSaved: (value) => foodModel.protein = _controller.saver(value),
          initialValue: foodModel.protein.toString(),
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter the amount of protein',
            labelText: 'Protein',
          ),
          validator: (value) => _controller.validator(value),
        ),
        SizedBox(
          height: kSizedBoxHeight,
        ),
        TextFormField(
          onSaved: (value) => foodModel.carbo = _controller.saver(value),
          initialValue: foodModel.carbo.toString(),
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter the amount of carbohydrate',
            labelText: 'Carbohydrate',
          ),
          validator: (value) => _controller.validator(value),
        ),
        SizedBox(
          height: kSizedBoxHeight,
        ),
        TextFormField(
          onSaved: (value) => foodModel.fat = _controller.saver(value),
          initialValue: foodModel.fat.toString(),
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter the amount of fat',
            labelText: 'Fat',
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
                text: 'Save',
                colour: Theme.of(context).primaryColor,
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();

                    String dialog = await foodController.update(foodModel);

                    await buildAlert(dialog, context).show();
                  }
                  Navigator.pop(context);
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
                text: 'Delete',
                colour: Colors.red,
              ),
            )
          ],
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

Alert warningAddFoodWidget({BuildContext context, Function addLogic}) {
  return Alert(
    title: 'System Message',
    desc: 'Did you eat that food?',
    context: context,
    buttons: [
      DialogButton(
        child: Text(
          'Yes',
          style: TextStyle(color: Colors.white),
        ),
        color: Theme.of(context).primaryColor,
        onPressed: addLogic,
      ),
      DialogButton(
        child: Text(
          'No',
          style: TextStyle(color: Colors.white),
        ),
        color: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    ],
  );
}

import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

Alert warningDelete({BuildContext context, Function deleteLogic}) {
  return Alert(
    title: 'System Message',
    desc: 'Are you sure you want to delete this food?',
    context: context,
    buttons: [
      DialogButton(
        child: Text(
          'Yes',
          style: TextStyle(color: Colors.white),
        ),
        color: Theme.of(context).primaryColor,
        onPressed: deleteLogic,
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

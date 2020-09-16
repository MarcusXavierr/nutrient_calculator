import 'package:flutter/material.dart';
import 'package:nutrients/constants.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

Alert errorAlertWidget(String dialog, BuildContext context, {Color color}) {
  return Alert(
    title: 'System Message',
    desc: dialog,
    context: context,
    buttons: [
      DialogButton(
        child: Text(
          'Close',
          style: TextStyle(color: Colors.white),
        ),
        color: color == null ? Theme.of(context).primaryColor : color,
        onPressed: () {
          Navigator.pop(context);
        },
      )
    ],
  );
}

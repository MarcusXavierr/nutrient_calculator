import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

Alert buildAlert(String dialog, BuildContext context) {
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
        color: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.pop(context);
        },
      )
    ],
  );
}

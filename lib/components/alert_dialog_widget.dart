import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

Alert buildAlert(String dialog, BuildContext context) {
  return Alert(
    title: 'Mensagem do sistema',
    desc: dialog,
    context: context,
    buttons: [
      DialogButton(
        child: Text(
          'Fechar',
          style: TextStyle(color: Colors.white),
        ),
        color: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.pop(context);
          Navigator.pop(context);
        },
      )
    ],
  );
}

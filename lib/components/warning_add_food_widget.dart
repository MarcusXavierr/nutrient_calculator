import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

Alert warningAddFoodWidget({BuildContext context, Function addLogic}) {
  return Alert(
    title: 'Mensagem do sistema',
    desc: 'Você comeu esse alimento?',
    context: context,
    buttons: [
      DialogButton(
        child: Text(
          'Sim',
          style: TextStyle(color: Colors.white),
        ),
        color: Theme.of(context).primaryColor,
        onPressed: addLogic,
      ),
      DialogButton(
        child: Text(
          'Não',
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

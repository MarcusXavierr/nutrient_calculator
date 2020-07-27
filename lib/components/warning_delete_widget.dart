import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

Alert warningDelete({BuildContext context, Function deleteLogic}) {
  return Alert(
    title: 'Mensagem do sistema',
    desc: 'Você tem certeza que deseja apagar esse alimento?',
    context: context,
    buttons: [
      DialogButton(
        child: Text(
          'Sim',
          style: TextStyle(color: Colors.white),
        ),
        color: Theme.of(context).primaryColor,
        onPressed: deleteLogic,
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

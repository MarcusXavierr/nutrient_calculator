import 'package:flutter/material.dart';

class RoundIconButton extends StatelessWidget {
  RoundIconButton({this.icon, this.onPressed});

  final Function onPressed;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: Icon(
        icon,
        color: Colors.white,
      ),
      onPressed: onPressed,
      elevation: 5.0,
      constraints: BoxConstraints.tightFor(
        width: 47.0,
        height: 47.0,
      ),
      shape: CircleBorder(),
      fillColor: Theme.of(context).primaryColor,
    );
  }
}

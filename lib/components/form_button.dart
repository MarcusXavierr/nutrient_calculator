import 'package:flutter/material.dart';

class FormButton extends StatelessWidget {
  const FormButton({
    @required this.onPressed,
    @required this.text,
    @required this.colour,
  });

  final String text;
  final Function onPressed;
  final Color colour;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: colour,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 30.0,
        vertical: 10.0,
      ),
      onPressed: this.onPressed,
      textColor: Colors.white,
      child: Text(
        text,
        style: TextStyle(fontSize: 23.0),
      ),
    );
  }
}

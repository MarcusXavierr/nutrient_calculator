import 'package:flutter/material.dart';
import 'package:nutrients/constants.dart';

class SyncButtonWidget extends StatelessWidget {
  final String title;
  final String text;
  final Function function;

  const SyncButtonWidget({
    Key key,
    @required this.title,
    @required this.text,
    @required this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          RaisedButton(
            onPressed: function,
            child: Text(this.title),
            color: Theme.of(context).primaryColor,
            textColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
          ),
          SizedBox(height: 10.0),
          Text(
            text,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:nutrients/constants.dart';

class CarouselContent extends StatelessWidget {
  CarouselContent({@required this.value, @required this.text});
  final int value;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '$value',
                style: kCarouselValueTextStyle,
              ),
              // SizedBox(
              //   width: 3.0,
              // ),
              Text(
                'g',
                style: kCarouselGTextStyle,
              ),
            ],
          ),
          Text(
            text,
            style: kCarouselTextTextStyle,
          ),
        ],
      ),
    );
  }
}

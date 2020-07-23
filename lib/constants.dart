import 'package:flutter/material.dart';

final Color kPrimaryColor = Colors.purple.shade900;

const TextStyle kCarouselValueTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 80.0,
);

const TextStyle kCarouselGTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 25.0,
);

const TextStyle kCarouselTextTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 28.0,
);

const TextStyle kLargeButtonTextStyle = TextStyle(
  fontSize: 22.0,
  fontWeight: FontWeight.bold,
);

const kTextFieldDecoration = InputDecoration(
  hintStyle: TextStyle(
    color: Colors.grey,
  ),
  hintText: 'Forgot .copyWith()',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.deepPurple, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.deepPurple, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

const double kSizedBoxHeight = 10;

import 'package:flutter/material.dart';

import 'package:nutrients/screens/home_page.dart';

void main() {
  runApp(MaterialApp(
    title: 'Calculadora de Nutrientes',
    theme: ThemeData(
      primaryColor: Colors.purple.shade900,
      accentColor: Colors.blueGrey.shade700,
    ),
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}

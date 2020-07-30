import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:nutrients/controllers/home_controller.dart';

import 'package:nutrients/screens/home_page.dart';
import 'package:nutrients/view-models/home_food_view_model.dart';

void main() {
  GetIt getIt = GetIt.I;
  getIt.registerSingleton<HomeController>(HomeController());
  getIt.registerSingleton<HomeFoodViewModel>(HomeFoodViewModel());
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

import 'package:flutter/material.dart';
import 'package:nutrients/core/utils/logged_user_data.dart';
import 'package:nutrients/features/login/presentation/pages/login/login_page.dart';
import 'package:nutrients/screens/home_page.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<LoggedUserData>(context);

    // * Return home or authenticate widget
    if (user == null) {
      return LoginPage();
    } else {
      return HomePage();
    }
  }
}

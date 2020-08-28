import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:nutrients/features/login/data/datasources/auth_remote_data_source.dart';
import 'package:nutrients/screens/home_page.dart';
import 'package:provider/provider.dart';
import 'core/utils/wrapper.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  di.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: GetIt.I.get<AuthRemoteDataSource>().user,
      child: MaterialApp(
        title: 'Nutrient Calculator',
        theme: ThemeData(
          primaryColor: Colors.blue.shade800,
          accentColor: Colors.blueGrey.shade700,
        ),
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:fridge/themes.dart';

import 'screens/home_sreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: greenTheme(context),
      home: HomeScreen(),
    );
  }
}
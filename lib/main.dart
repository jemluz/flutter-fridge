import 'package:flutter/material.dart';
import 'package:fridge/screens/splash_screen.dart';
import 'package:fridge/themes.dart';
import 'package:provider/provider.dart';

import 'models/products.dart';
import 'models/transactions.dart';
import 'screens/home_sreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => new Products(),
        ),
        ChangeNotifierProvider(
          create: (_) => new Transactions(),
        ),
      ],
      child: MaterialApp(
        theme: greenTheme(context),
        home: HomeScreen(),
        initialRoute: '/splash_screen',
        routes: {
          '/home_screen': (ctx) => HomeScreen(),
          '/splash_screen': (ctx) => SplashScreen(),
        },
      ),
    );
  }
}
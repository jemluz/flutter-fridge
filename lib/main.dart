import 'package:flutter/material.dart';
import 'package:fridge/models/theme.dart';
import 'package:fridge/themes.dart';
import 'package:provider/provider.dart';

import 'models/products.dart';
import 'models/transactions.dart';
import 'screens/home_sreen.dart';
import 'screens/splash_screen/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeProvider themeChangeProvider = new ThemeProvider();

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
    themeChangeProvider.addListener(() {
      setState(() {});
    });
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.setWhiteTheme = await themeChangeProvider.themePreference.getTheme();
  }

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
        ChangeNotifierProvider(
          create: (_) => themeChangeProvider,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Styles.themeData(themeChangeProvider.isWhiteTheme, context),
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

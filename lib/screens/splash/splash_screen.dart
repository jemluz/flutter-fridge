import 'package:flutter/material.dart';
import 'package:fridge/components/background.dart';
import 'package:fridge/components/logo.dart';

import 'components/navigation.dart';
import 'components/splash_content.dart';

class SplashScreen extends StatelessWidget {
  static String routeName = '/splash';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "title": "Monitore suas comidas",
      "text": "Saiba sempre o que há na sua geladeira",
    },
    {
      "title": "Entenda o seu consumo",
      "text":
          "Você vai descobrir quais são os recursos\n mais usados por você.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Background(),
        SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: <Widget>[
                Spacer(),
                Logo(),
                SizedBox(height: 40),
                Image.asset(
                  'assets/images/fridge-green.png',
                  width: 250,
                ),
                Expanded(
                  flex: 1,
                  child: PageView.builder(
                    onPageChanged: (value) {
                      setState(() {
                        currentPage = value;
                      });
                    },
                    itemCount: splashData.length,
                    itemBuilder: (context, index) => SplashContent(
                      text: splashData[index]["text"],
                      title: splashData[index]["title"],
                    ),
                  ),
                ),
                Navigation(splashData: splashData, currentPage: currentPage, size: size)
              ],
            ),
          ),
        ),
      ],
    );
  }
}


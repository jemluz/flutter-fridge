import 'package:flutter/material.dart';
import 'package:fridge/components/background.dart';
import 'package:fridge/components/logo.dart';
import 'package:fridge/themes.dart';

import 'home_sreen.dart';

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
    AnimatedContainer buildDot({int index}) {
      return AnimatedContainer(
        height: 6,
        width: currentPage == index ? 20 : 6,
        margin: EdgeInsets.only(right: 5),
        duration: Duration(seconds: 1),
        decoration: BoxDecoration(
          color:
              currentPage == index ? AppColors.GREEN_n51 : AppColors.GREEN_n234,
          borderRadius: BorderRadius.circular(3),
        ),
      );
    }

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
                Navigation(splashData: splashData, size: size)
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class Navigation extends StatelessWidget {
  const Navigation({
    Key key,
    @required this.splashData,
    @required this.size,
  }) : super(key: key);

  final List<Map<String, String>> splashData;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: <Widget>[
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                splashData.length,
                (index) => buildDot(index: index),
              ),
            ),
            Spacer(),
            InkWell(
              onTap: () =>
                  Navigator.pushNamed(context, '/home_screen'),
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: size.width * .26,
                padding: EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                    color: AppColors.GREEN_n234,
                    borderRadius: BorderRadius.circular(8)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Pular',
                      style: TextStyle(
                          fontSize: 20, color: AppColors.GREEN_n0),
                    ),
                    SizedBox(width: 8),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.GREEN_n0,
                      size: 16,
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

class SplashContent extends StatelessWidget {
  final String text, title;
  const SplashContent({
    Key key,
    this.text,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Spacer(),
        Text(
          title,
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, color: AppColors.GRAY_n135),
        ),
        // Spacer(flex: 2),
      ],
    );
  }
}

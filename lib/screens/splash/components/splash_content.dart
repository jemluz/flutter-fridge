import 'package:flutter/material.dart';

import '../../../themes.dart';

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
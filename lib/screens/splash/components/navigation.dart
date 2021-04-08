import 'package:flutter/material.dart';

import 'dot.dart';
import 'skip_button.dart';

class Navigation extends StatelessWidget {
  const Navigation({
    Key key,
    @required this.splashData,
    @required this.currentPage,
    @required this.size,
  }) : super(key: key);

  final List<Map<String, String>> splashData;
  final int currentPage;
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
                (index) => Dot(index: index, currentPage: currentPage),
              ),
            ),
            Spacer(),
            SkipButton(size: size),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
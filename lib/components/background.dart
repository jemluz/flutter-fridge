import 'package:flutter/material.dart';
import 'package:fridge/themes.dart';

class Background extends StatelessWidget {
  const Background({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          alignment: Alignment.topCenter,
          image: Theme.of(context).primaryColor == AppColors.YELLOW_n119 ? AssetImage('assets/images/white-bg.png') : AssetImage('assets/images/green-bg.png'),
        ),
      ),
    );
  }
}
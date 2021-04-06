import 'package:flutter/material.dart';

import '../themes.dart';

class Logo extends StatelessWidget {
  const Logo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          'Minha',
          style: TextStyle(
            fontFamily: 'Imprima',
            fontSize: 25,
            color: AppColors.BLACK,
          ),
        ),
        Text(
          'Geladeira',
          style: TextStyle(
            fontFamily: 'Imprima',
            fontSize: 50,
            color: AppColors.BLACK,
          ),
        )
      ],
    );
  }
}

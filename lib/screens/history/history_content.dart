import 'package:flutter/material.dart';
import 'package:fridge/components/action_button.dart';

import 'components/content.dart';

class HistoryContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    
    return SafeArea(
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Content(size: size),
          ActionButton(text: 'Nova transação'),
        ],
      ),
    );
  }
}
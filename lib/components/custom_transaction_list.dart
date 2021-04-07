import 'package:flutter/material.dart';

import '../themes.dart';

class CustomTransactionList extends StatelessWidget {
  CustomTransactionList({
    Key key,
    @required this.child,
    @required this.isTagsDisplayed,
  }) : super(key: key);

  Widget child;
  bool isTagsDisplayed = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      height: size.height * .65,
      width: size.width,
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: size.width * .05),
      decoration: backgroundDecoration(),
      child: SingleChildScrollView(
        child: Container(
          alignment: Alignment.bottomCenter,
          height: size.height * (isTagsDisplayed ? .6 : .5),
          margin: EdgeInsets.only(top: isTagsDisplayed ? 70 : 110),
          child: child,
        ),
      ),
    );
  }

  BoxDecoration backgroundDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(46),
        topRight: Radius.circular(46),
      ),
      boxShadow: <BoxShadow>[
        BoxShadow(
          offset: Offset(0, -10),
          blurRadius: 10,
          color: AppColors.BLACK.withOpacity(.05),
        )
      ],
    );
  }
}

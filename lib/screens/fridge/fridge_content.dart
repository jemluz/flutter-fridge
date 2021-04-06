import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../themes.dart';

class FridgeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SafeArea(
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          ContentBackground(size: size),
          MainButton()
        ],
      ),
    );
  }
}

class ContentBackground extends StatelessWidget {
  const ContentBackground({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * .65,
      width: size.width,
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: size.width * .1),
      decoration: BoxDecoration(
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
      ),
    );
  }
}

class MainButton extends StatelessWidget {
  const MainButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(16),
        highlightColor: Theme.of(context).primaryColor.withOpacity(.2),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: <BoxShadow>[
              BoxShadow(
                offset: Offset(0, 0),
                blurRadius: 30,
                color: Theme.of(context).colorScheme.secondary.withOpacity(.20)
              )
            ]
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.add,
                color: Colors.white,
              ),
              SizedBox(width: 10),
              Text(
                'Adicionar item',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500
                ),
              ),
              SizedBox(width: 10),
            ],
          ),
        ),
      ),
    );
  }
}

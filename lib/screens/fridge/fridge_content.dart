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
          Container(
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
                  blurRadius: 20,
                  color: AppColors.BLACK.withOpacity(.05),
                )
              ],
            ),
          ),
          Positioned(
            top: 0,
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(16),
              highlightColor: AppColors.GREEN_n51.withOpacity(.2),
              child: Container(
                width: size.width * .4,
                padding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(12),
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
                        fontSize: 14,
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

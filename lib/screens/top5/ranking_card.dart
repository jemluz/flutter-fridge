import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fridge/models/product.dart';

import '../../themes.dart';

class RankingCard extends StatelessWidget {
  const RankingCard({
    Key key,
    @required this.size,
    @required this.onPressed,
    @required this.product,
    @required this.index,
  }) : super(key: key);

  final Size size;
  final GestureTapCallback onPressed;
  final Product product;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 18),
      margin: EdgeInsets.only(bottom: 12, left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            index.toString(),
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: AppColors.GRAY_n141.withOpacity(.6),
              fontFamily: 'Roboto'
            ),
          ),
          SizedBox(width: size.width * .05),
          buildProductImage(product.imgSrc),
          SizedBox(width: size.width * .05),
          buildProductInfo(product.name, product.totalUsed),
          Spacer(),
        ],
      ),
    );
  }

  Container buildProductImage(String image) {
    return Container(
      width: size.width * .15,
      height: size.width * .15,
      decoration: BoxDecoration(
          image: DecorationImage(
        alignment: Alignment.topCenter,
        image: AssetImage(image),
      )),
    );
  }

  Column buildProductInfo(String name, int amount) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          name,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Text('$amount unidades'),
      ],
    );
  }
}

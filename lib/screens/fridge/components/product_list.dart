import 'package:flutter/material.dart';
import 'package:fridge/models/products.dart';

import 'product_card.dart';

class ProductsList extends StatelessWidget {
  const ProductsList({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.bottomCenter,
        height: size.height * .6,
        margin: EdgeInsets.only(top: 70),
        child: ListView.builder(
          itemCount: demoProducts.length,
          itemBuilder: (context, index) => ProductCard(
            product: demoProducts[index],
            onPressed: () {},
            size: size,
          ),
        ),
      ),
    );
  }
}
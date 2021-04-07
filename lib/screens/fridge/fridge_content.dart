import 'package:flutter/material.dart';
import 'package:fridge/components/action_button.dart';
import 'package:fridge/components/custom_list.dart';
import 'package:fridge/models/products.dart';

import 'product_card.dart';

class FridgeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SafeArea(
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          CustomList(
            size: size,
            child: ListView.builder(
              itemCount: demoProducts.length,
              itemBuilder: (context, index) => ProductCard(
                product: demoProducts[index],
                onPressed: () {},
                size: size,
              ),
            ),
          ),
          ActionButton(text: 'Adicionar item'),
        ],
      ),
    );
  }
}

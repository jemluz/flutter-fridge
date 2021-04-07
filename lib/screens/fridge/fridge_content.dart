import 'package:flutter/material.dart';
import 'package:fridge/screens/fridge/action_button.dart';
import 'package:fridge/components/custom_list.dart';
import 'package:fridge/models/products.dart';
import 'package:provider/provider.dart';

import 'product_card.dart';

class FridgeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final products = Provider.of<Products>(context);

    return SafeArea(
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          CustomList(
            size: size,
            child: ListView.builder(
              itemCount: products.items.length,
              itemBuilder: (context, index) => ProductCard(
                product: products.items[index],
                onPressed: () {},
                size: size,
              ),
            ),
          ),
          ActionButton(
            text: 'Adicionar item',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

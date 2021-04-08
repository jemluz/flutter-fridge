import 'package:flutter/material.dart';
import 'package:fridge/screens/fridge/action_button.dart';
import 'package:fridge/components/custom_list.dart';
import 'package:fridge/models/products.dart';
import 'package:provider/provider.dart';

import 'product_card.dart';
import 'product_form.dart';

class FridgeContent extends StatefulWidget {
  @override
  _FridgeContentState createState() => _FridgeContentState();
}

class _FridgeContentState extends State<FridgeContent> {

  _showDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (_) {
          return ProductForm();
        });
  }

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context);

    return SafeArea(
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          CustomList(
            child: ListView.builder(
              itemCount: products.items.length,
              itemBuilder: (context, index) => ProductCard(
                product: products.items[index],
                onPressed: () {},
              ),
            ),
          ),
          ActionButton(
            text: 'Adicionar item',
            onPressed: () => _showDialog(context),
          ),
        ],
      ),
    );
  }
}

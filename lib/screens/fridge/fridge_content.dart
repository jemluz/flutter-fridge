import 'package:flutter/material.dart';
import 'package:fridge/models/product.dart';
import 'package:fridge/screens/fridge/action_button.dart';
import 'package:fridge/components/custom_list.dart';
import 'package:fridge/models/products.dart';
import 'package:provider/provider.dart';

import '../../enums.dart';
import 'product_card.dart';
import 'product_form.dart';
import '../../components/transaction_form.dart';

class FridgeContent extends StatefulWidget {
  @override
  _FridgeContentState createState() => _FridgeContentState();
}

class _FridgeContentState extends State<FridgeContent> {
  _showProductDialog(BuildContext context, SubmitType type, String dialogTitle,
      [Product receivedProduct]) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (_) {
          return ProductForm(type, receivedProduct, dialogTitle);
        });
  }

  _showTransactionDialog(
      BuildContext context, SubmitType type, String dialogTitle,
      [Product productParent]) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (_) {
          return TransactionForm(
            submitType: type,
            productParent: productParent,
            dialogTitle: dialogTitle,
          );
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
                onPressed: () => _showProductDialog(
                  context,
                  SubmitType.update,
                  'Editar item',
                  products.items[index],
                ),
                onButtonPressed: () => _showTransactionDialog(
                  context,
                  SubmitType.save,
                  'Adicionar transação',
                  products.items[index],
                ),
              ),
            ),
          ),
          ActionButton(
            text: 'Adicionar item',
            onPressed: () =>
                _showProductDialog(context, SubmitType.save, 'Adicionar Item'),
          ),
        ],
      ),
    );
  }
}

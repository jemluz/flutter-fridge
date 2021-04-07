import 'package:flutter/material.dart';
import 'package:fridge/components/action_button.dart';
import 'package:fridge/components/custom_list.dart';
import 'package:fridge/models/transactions.dart';

import '../../components/custom_list.dart';
import 'transaction_card.dart';

class HistoryContent extends StatelessWidget {
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
              itemCount: demoTransactions.length,
              itemBuilder: (context, index) => TransactionCard(
                transaction: demoTransactions[index],
                onPressed: () {},
                size: size,
              ),
            ),
          ),
          ActionButton(text: 'Nova transação'),
        ],
      ),
    );
  }
}

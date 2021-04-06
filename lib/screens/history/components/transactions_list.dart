import 'package:flutter/material.dart';
import 'package:fridge/models/transactions.dart';

import 'transaction_card.dart';

class TransactionsList extends StatelessWidget {
  const TransactionsList({
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
          itemCount: demoTransactions.length,
          itemBuilder: (context, index) => TransactionCard(
            transaction: demoTransactions[index],
            onPressed: () {},
            size: size,
          ),
        ),
      ),
    );
  }
}
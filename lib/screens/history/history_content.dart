import 'package:flutter/material.dart';
import 'package:fridge/components/custom_list.dart';
import 'package:fridge/models/transactions.dart';
import 'package:provider/provider.dart';

import '../../components/custom_list.dart';
import 'action_bar.dart';
import 'transaction_card.dart';

class HistoryContent extends StatefulWidget {
  @override
  _HistoryContentState createState() => _HistoryContentState();
}

class _HistoryContentState extends State<HistoryContent> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final transactions = Provider.of<Transactions>(context);


    int _currentTitle = 1;
    final List<String> _titles = ['', 'Apenas consumo', 'Apenas adições'];

    _setFilter(int index) {
      setState(() {
        _currentTitle = index;
      });
    }

    return SafeArea(
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          CustomList(
            size: size,
            child: ListView.builder(
              itemCount: transactions.items.length,
              itemBuilder: (context, index) => TransactionCard(
                transaction: transactions.items[index],
                size: size,
              ),
            ),
          ),
          ActionBar(
            text: 'Nova transação',
            onPressed: () {},
            onPressedMinus: () => _setFilter(1),
            onPressedPlus: () => _setFilter(2),
          ),
          Positioned(
            top: 60,
            child: Container(
              // color: Colors.black,
              // alignment: Alignment.center,
              width: size.width * .7,
              margin: EdgeInsets.only(top: 0),
              child: Text(
                _titles[_currentTitle],
                textAlign: TextAlign.right,
                style: TextStyle(fontSize: 25),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

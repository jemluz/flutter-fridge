import 'package:flutter/material.dart';

import 'transaction.dart';

List<Transaction> demoTransactions = [
  Transaction(productName: 'Maçã', amount: 2, isAdditive: false, date: DateTime.now()),
  Transaction(productName: 'Couve', amount: 12, isAdditive: true, date: DateTime.parse('2021-04-01 20:18:04Z')),
  Transaction(productName: 'Ovos', amount: 5, isAdditive: false, date: DateTime.parse('2021-03-29 20:18:04Z')),
  Transaction(productName: 'Cenoura', amount: 16, isAdditive: true, date: DateTime.parse('2021-03-28 20:18:04Z')),
  Transaction(productName: 'Ovos', amount: 5, isAdditive: true, date: DateTime.parse('2021-03-29 20:18:04Z')),
  Transaction(productName: 'Couve', amount: 12, isAdditive: true, date: DateTime.parse('2021-04-01 20:18:04Z')),
];


class Transactions with ChangeNotifier{
  List<Transaction> _items = demoTransactions;

  List<Transaction> get items => [..._items];

  List<Transaction> get onlyConsume {
    List<Transaction> filteredList = _items;
    filteredList.retainWhere((prod) => prod.isAdditive == false);
    print(filteredList);

    return filteredList;
  }

  List<Transaction> get onlyAdditive {
    List<Transaction> filteredList = _items;
    filteredList.retainWhere((prod) => prod.isAdditive == true);
    print(filteredList);

    return filteredList;
  }

  void deleteTransaction(String id) {
    final index = _items.indexWhere((prod) => prod.id == id);
    if (index >= 0) {
      _items.removeWhere((prod) => prod.id == id);
      notifyListeners();
    }
  }
}


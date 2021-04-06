import 'package:flutter/material.dart';

import 'transaction.dart';

List<Transaction> demoTransactions = [
  Transaction(productName: 'Couve', amount: 12, isAdditive: true, date: DateTime.now()),
  Transaction(productName: 'Couve', amount: 2, isAdditive: false, date: DateTime.now()),
  Transaction(productName: 'Ovos', amount: 5, isAdditive: false, date: DateTime.now()),
  Transaction(productName: 'Cenoura', amount: 16, isAdditive: true, date: DateTime.now()),
];


class Transactions with ChangeNotifier{
  List<Transaction> _items = demoTransactions;

  int get itemsCount {
    return _items.length;
  }

  void deleteTransaction(String id) {
    final index = _items.indexWhere((prod) => prod.id == id);
    if (index >= 0) {
      _items.removeWhere((prod) => prod.id == id);
      notifyListeners();
    }
  }
}


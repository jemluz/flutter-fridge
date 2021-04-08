import 'package:flutter/material.dart';

import 'transaction.dart';

List<Transaction> demoTransactions = [
  Transaction(productName: 'Couve', amount: 12, isAdditive: true, date: DateTime.parse('2021-04-01 20:18:04Z')),
  Transaction(productName: 'Ovos', amount: 5, isAdditive: true, date: DateTime.parse('2021-03-29 20:18:04Z')),
  Transaction(productName: 'Ovos', amount: 5, isAdditive: false, date: DateTime.parse('2021-03-29 20:18:04Z')),
  Transaction(productName: 'Cenoura', amount: 16, isAdditive: true, date: DateTime.parse('2021-03-28 20:18:04Z')),
  Transaction(productName: 'Maçã', amount: 2, isAdditive: false, date: DateTime.now()),
  Transaction(productName: 'Couve', amount: 12, isAdditive: true, date: DateTime.parse('2021-04-01 20:18:04Z')),
];


class Transactions with ChangeNotifier{
  List<Transaction> _items = demoTransactions;

  List<Transaction> get items => [..._items];

  List<Transaction> get onlyConsume {
    List<Transaction> filteredList = [..._items];
    filteredList.retainWhere((prod) => prod.isAdditive == false);
    filteredList.sort((a, b) => b.date.compareTo(a.date));
    // print(filteredList);

    notifyListeners();  
    return filteredList;
  }

  List<Transaction> get onlyAdditive {
    List<Transaction> filteredList = [..._items];
    filteredList.retainWhere((prod) => prod.isAdditive == true);
    filteredList.sort((a, b) => b.date.compareTo(a.date));

    // print(filteredList);

    notifyListeners();
    return filteredList;
  }

  List<Transaction> get orderByDate {
    List<Transaction> filteredList = [..._items];
    filteredList.sort((a, b) => b.date.compareTo(a.date));
    // print(filteredList);
    notifyListeners();
    return filteredList;
  }

  // void deleteTransaction(String id) {
  //   final index = _items.indexWhere((prod) => prod.id == id);
  //   if (index >= 0) {
  //     _items.removeWhere((prod) => prod.id == id);
  //     notifyListeners();
  //   }
  // }
}


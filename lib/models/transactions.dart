import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'transaction.dart';

List<Transaction> demoTransactions = [
  Transaction(
      productName: 'Couve',
      amount: 12,
      isAdditive: true,
      date: '2021-04-01 20:18:04Z'),
  Transaction(
      productName: 'Ovos',
      amount: 5,
      isAdditive: true,
      date: '2021-03-29 20:18:04Z'),
  Transaction(
      productName: 'Ovos',
      amount: 5,
      isAdditive: false,
      date: '2021-03-29 20:18:04Z'),
  Transaction(
      productName: 'Cenoura',
      amount: 16,
      isAdditive: true,
      date: '2021-03-28 20:18:04Z'),
  Transaction(
      productName: 'Maçã', amount: 2, isAdditive: false, date: DateTime.now().toString()),
  Transaction(
      productName: 'Couve',
      amount: 12,
      isAdditive: true,
      date: '2021-04-01 20:18:04Z'),
];

class Transactions with ChangeNotifier {
  final String _baseApiUrl =
      'https://flutter-fridge-default-rtdb.firebaseio.com/transactions';
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

  Future<void> loadTransactions() async {
    final res = await http.get('$_baseApiUrl.json');
    Map<String, dynamic> data = json.decode(res.body);

    _items.clear();
    if (data != null) {
      data.forEach((productId, productData) {
        _items.add(Transaction(
          id: productId,
          productName: productData['name'],
          amount: productData['amount'],
          date: productData['date'],
          isAdditive: productData['isAdditive'],
        ));
      });
      notifyListeners();
    }

    return Future.value();
  }

  Future<void> saveTransaction(Transaction newTransaction) async {
    var body = json.encode({
      'productName': newTransaction.productName,
      'amount': newTransaction.amount,
      'date': newTransaction.date,
      'isAdditive': newTransaction.isAdditive,
    });

    print(body);

    // add product
    final res = await http.post('$_baseApiUrl.json', body: body);
    _items.add(Transaction(
      id: json.decode(res.body)['name'],
      productName: newTransaction.productName,
      amount: newTransaction.amount,
      date: newTransaction.date,
      isAdditive: newTransaction.isAdditive,
    ));
    notifyListeners();

    return null;
  }

  Future<void> updateTransaction(String id, Transaction newTransaction) async {
    var alreadyExists = _items.indexWhere((prod) => prod.id == id);

    var body = json.encode({
      'productName': newTransaction.productName,
      'amount': newTransaction.amount,
      'date': newTransaction.date,
      'isAdditive': newTransaction.isAdditive,
    });

    if (alreadyExists >= 0) {
      await http.patch('$_baseApiUrl/$id.json', body: body);
      _items[alreadyExists] = newTransaction;
      notifyListeners();
    }

    return null;
  }
}

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'transaction.dart';

class Transactions with ChangeNotifier {
  final String _baseApiUrl =
      'https://flutter-fridge-default-rtdb.firebaseio.com/transactions';
  List<Transaction> _items = [];

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

  Transaction loadTransaction(String id) {
    final alreadyExists = _items.indexWhere((transaction) => transaction.id == id);

    if(alreadyExists >= 0) {
      return _items[alreadyExists];
    }
  }

  Future<void> loadTransactions() async {
    final res = await http.get('$_baseApiUrl.json');
    Map<String, dynamic> data = json.decode(res.body);

    _items.clear();
    if (data != null) {
      data.forEach((productId, productData) {
        _items.add(Transaction(
          id: productId,
          productName: productData['productName'],
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
    // int oldAmount;
    // int newAmount;

    var body = json.encode({
      'productName': newTransaction.productName,
      'amount': newTransaction.amount,
      'date': newTransaction.date,
      'isAdditive': newTransaction.isAdditive,
    });

    // procurar um produto do mesmo nome
    // var getProductToBalance = _items.indexWhere((transaction) {
    //   oldAmount = transaction.amount;
    //   return transaction.id ==   ;
    // });

    // newAmount = newTransaction.isAdditive
    //     ? oldAmount + newTransaction.amount
    //     : oldAmount - newTransaction.amount;

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
    var alreadyExists =
        _items.indexWhere((transaction) => transaction.id == id);

    var body = json.encode({
      'productName': newTransaction.productName,
      'amount': newTransaction.date,
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

  Future<void> deleteTransaction(String id) async {
    final alreadyExists = _items.indexWhere((transaction) => transaction.id == id);

    if(alreadyExists >= 0) {
      _items.removeWhere((transaction) => transaction.id == id);
      notifyListeners();
    }
  }
}

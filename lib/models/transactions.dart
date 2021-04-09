import 'package:flutter/material.dart';
import 'package:fridge/models/product.dart';
import 'package:fridge/models/products.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'transaction.dart';

class Transactions with ChangeNotifier {
  final String _baseApiUrl =
      'https://flutter-fridge-default-rtdb.firebaseio.com';
  final String _colection = '/transactions';

  final List<Transaction> _items = [];
  Products products = new Products(); 
  int newProductAmount;
  int newTransactionAmount;

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
    final res = await http.get('$_baseApiUrl$_colection.json');
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
    products.loadProducts();

    updateProductAmount(newTransaction);

    print(newProductAmount);

    var body = json.encode({
      'productName': newTransaction.productName,
      'amount': newTransactionAmount,
      'date': newTransaction.date,
      'isAdditive': newTransaction.isAdditive,
    });

    final res = await http.post('$_baseApiUrl$_colection.json', body: body);
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
    final alreadyExists =
        _items.indexWhere((transaction) => transaction.id == id);

    if (alreadyExists >= 0) {
      final transaction = _items[alreadyExists];
      _items.remove(transaction);
      notifyListeners();

      final res = await http.delete('$_baseApiUrl/${transaction.id}.json');

      if (res.statusCode >= 400) {
        _items.insert(alreadyExists, transaction);
        notifyListeners();
      }
    }
  }

  Future<int> updateProductAmount(Transaction newTransaction) async {
    Product parentProduct;
    int getProductIndex;
    int oldProductAmount;

    newTransactionAmount = newTransaction.amount;

    getProductIndex = products.items.indexWhere((prod) => prod.name == newTransaction.productName);

    if (getProductIndex >= 0) {
      parentProduct = products.items[getProductIndex];
      oldProductAmount = parentProduct.amount;
      newProductAmount = parentProduct.amount;
    }

    if (newTransaction.isAdditive) {
      print('botou: $newProductAmount = $oldProductAmount + ${newTransaction.amount}');
      newProductAmount += newTransaction.amount;
      // print(newProductAmount);
    }

    if (!newTransaction.isAdditive &&
        newTransaction.amount <= oldProductAmount) {
      print('tirou: $newProductAmount = $oldProductAmount - ${newTransaction.amount}');
      newProductAmount -= newTransaction.amount;
      // print(newProductAmount);
    }

    if (!newTransaction.isAdditive &&
        newTransaction.amount > oldProductAmount) {
      newTransaction.amount = oldProductAmount;
      newTransactionAmount = oldProductAmount;
      newProductAmount = oldProductAmount - newTransaction.amount;
    }

    var body = json.encode({
      'name': parentProduct.name,
      'amount': newProductAmount,
      'imgSrc': parentProduct.imgSrc,
      'totalUsed': parentProduct.totalUsed,
      'totalAdded': parentProduct.totalAdded,
    });

    if (getProductIndex >= 0) {
      await http.patch('$_baseApiUrl/products/${parentProduct.id}.json', body: body);

      products.loadProducts().then((value) => null);
      products.items[getProductIndex] = parentProduct;

      notifyListeners();
    }

    return Future.value(newProductAmount);
  }
}

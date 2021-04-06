import 'package:flutter/foundation.dart';

import 'transactions.dart';

class Product with ChangeNotifier{
  String id;
  String name;
  int amount;

  int _totalUsed = 0;
  int _totalAdded = 0;
  List<Transactions> _transactions = [];

  Product({
    this.id,
    @required this.name,
    @required this.amount,
  });

  int get totalUsed {
    return _totalUsed;
  }

  int get totalAdded {
    return _totalAdded;
  }

  List<Transactions> get transactions {
    return _transactions;
  }

  void updatedTotalAdded(int number) {
    _totalAdded += number;
    notifyListeners();
  }

  void updatedTotalUsed(int number) {
    _totalUsed += number;
    notifyListeners();
  }
}
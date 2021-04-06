import 'package:flutter/foundation.dart';

// import 'transaction.dart';

class Product with ChangeNotifier{
  String id;
  String name;
  String imgSrc;
  int amount;

  int _totalUsed = 0;
  int _totalAdded = 0;

  Product({
    this.id,
    @required this.name,
    @required this.amount,
    @required this.imgSrc,
  });

  int get totalUsed {
    return _totalUsed;
  }

  int get totalAdded {
    return _totalAdded;
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
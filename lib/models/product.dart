import 'dart:math';

import 'dart:math';
import 'package:flutter/foundation.dart';

// import 'transaction.dart';

class Product with ChangeNotifier{
  String id = Random().nextDouble().toString();
  String name = '';
  String imgSrc = '';
  int amount = 0;

  int totalUsed = 0;
  int totalAdded = 0;

  Product({
    this.id,
    @required this.name,
    @required this.amount,
    @required this.imgSrc,
    this.totalAdded,
    this.totalUsed,
  });

  @override
    String toString() {
      return '{ ${this.name}, ${this.totalUsed} }';
    }

  // int get totalUsed {
  //   return _totalUsed;
  // }

  // int get totalAdded {
  //   return _totalAdded;
  // }

  // void updatedTotalAdded(int number) {
  //   _totalAdded += number;
  //   notifyListeners();
  // }

  // void updatedTotalUsed(int number) {
  //   _totalUsed += number;
  //   notifyListeners();
  // }
}
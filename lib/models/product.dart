import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  String id ;
  String name ;
  String imgSrc;
  int amount;

  int totalUsed;

  Product({
    this.id,
    @required this.name,
    @required this.amount,
    @required this.imgSrc,
    this.totalUsed = 0,
  });

  @override
  String toString() {
    return '{ ${this.id}, ${this.name}, ${this.amount}, ${this.imgSrc}, ${this.totalUsed}, }';
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

import 'package:flutter/material.dart';

class Transaction with ChangeNotifier{
  String id;
  String productName;
  String date;
  bool isAdditive;
  int amount;

  Transaction({
    this.id,
    @required this.productName,
    @required this.amount,
    this.isAdditive,
    @required this.date,
  });
}


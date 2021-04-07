import 'dart:math';
import 'package:flutter/material.dart';

class Transaction with ChangeNotifier{
  String id = Random().nextDouble().toString();
  String productName = '';
  DateTime date = DateTime.now();
  bool isAdditive = true;
  int amount = 0;

  Transaction({
    this.id,
    @required this.productName,
    @required this.amount,
    this.isAdditive,
    this.date,
  });
}


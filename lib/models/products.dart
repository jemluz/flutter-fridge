import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'product.dart';

List<Product> demoProducts = [
  Product(name: 'Couve', amount: 6),
  Product(name: 'Cebola', amount: 4),
  Product(name: 'Maçã', amount: 12),
  Product(name: 'Ovos', amount: 30),
  Product(name: 'Cenoura', amount: 7),
];

class Products with ChangeNotifier {
  List<Product> _items = demoProducts;

  int get itemsCount {
    return _items.length;
  }

  Future<void> addProduct(Product newProduct) {
    const url =
        'https://flutter-loja-41af1-default-rtdb.firebaseio.com/products';

    return http
        .post(
      url,
      body: json.encode({'name': newProduct.name, 'amount': newProduct.amount}),
    )
        .then((response) {
      _items.add(Product(
        id: json.decode(response.body)['name'],
        name: newProduct.name,
        amount: newProduct.amount,
      ));
      notifyListeners();
    }).then((_) => null);
  }
}

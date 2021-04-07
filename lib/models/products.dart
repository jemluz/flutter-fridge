import 'dart:math';

import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// import 'dart:convert';
import 'product.dart';

List<Product> demoProducts = [
  Product(
    id: Random().nextDouble().toString(),
    name: 'Couve',
    amount: 6,
    imgSrc: 'assets/images/couve.png',
    totalAdded: 100,
    totalUsed: 12,
  ),
  Product(
    id: Random().nextDouble().toString(),
    name: 'Cebola',
    amount: 4,
    imgSrc: 'assets/images/cebola.png',
    totalAdded: 100,
    totalUsed: 12,
  ),
  Product(
    id: Random().nextDouble().toString(),
    name: 'Cenoura',
    amount: 7,
    imgSrc: 'assets/images/cenoura.png',
    totalAdded: 100,
    totalUsed: 10,
  ),
  Product(
    id: Random().nextDouble().toString(),
    name: 'Maçã',
    amount: 12,
    imgSrc: 'assets/images/maca.png',
    totalAdded: 100,
    totalUsed: 71,
  ),
  Product(
    id: Random().nextDouble().toString(),
    name: 'Ovos',
    amount: 30,
    imgSrc: 'assets/images/ovos.png',
    totalAdded: 100,
    totalUsed: 67,
  ),
];

class Products with ChangeNotifier {
  List<Product> _items = demoProducts;

  List<Product> get items => [..._items];

  int get itemsCount {
    return _items.length;
  }

  List<Product> get usedRanking {
    List<Product> ranking = _items;
    ranking.sort((a, b) => b.totalUsed.compareTo(a.totalUsed));
    // print('Sort by Age: ' + list.toString());
    print(ranking);
    return ranking;
  }

  void addProduct(Product newProduct) {
    _items.add(Product(
      id: Random().nextDouble().toString(),
      name: newProduct.name,
      amount: newProduct.amount,
      imgSrc: newProduct.imgSrc,
      totalUsed: newProduct.totalUsed,
      totalAdded: newProduct.totalAdded,
    ));
    notifyListeners();
  } // chamado sempre que for feita uma mudança importante, para notificar os componentes interessados

  void updateProduct(Product product) {
    if (product != null && product.id != null) {
      return;
    }

    final index = _items.indexWhere((prod) => prod.id == product.id);

    if (index >= 0) {
      _items[index] = product;
      notifyListeners();
    }
  }

  void deleteProduct(String id) {
    final index = _items.indexWhere((prod) => prod.id == id);
    if (index >= 0) {
      _items.removeWhere((prod) => prod.id == id);
      notifyListeners();
    }
  }

  // Future<void> addProduct(Product newProduct) {
  //   const url =
  //       'https://flutter-loja-41af1-default-rtdb.firebaseio.com/products';

  //   return http
  //       .post(
  //     url,
  //     body: json.encode({'name': newProduct.name, 'amount': newProduct.amount}),
  //   )
  //       .then((response) {
  //     _items.add(Product(
  //       id: json.decode(response.body)['name'],
  //       name: newProduct.name,
  //       amount: newProduct.amount,
  //     ));
  //     notifyListeners();
  //   }).then((_) => null);
  // }

}

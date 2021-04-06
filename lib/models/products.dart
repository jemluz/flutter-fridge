import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// import 'dart:convert';
import 'product.dart';

List<Product> demoProducts = [
  Product(name: 'Couve', amount: 6, imgSrc: 'assets/images/couve.png'),
  Product(name: 'Cebola', amount: 4, imgSrc: 'assets/images/cebola.png'),
  Product(name: 'Maçã', amount: 12, imgSrc: 'assets/images/maca.png'),
  Product(name: 'Ovos', amount: 30, imgSrc: 'assets/images/ovos.png'),
  Product(name: 'Cenoura', amount: 7, imgSrc: 'assets/images/cenoura.png'),
  Product(name: 'Maçã', amount: 12, imgSrc: 'assets/images/maca.png'),
  Product(name: 'Ovos', amount: 30, imgSrc: 'assets/images/ovos.png'),
];

class Products with ChangeNotifier {
  List<Product> _items = demoProducts;

  int get itemsCount {
    return _items.length;
  }

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

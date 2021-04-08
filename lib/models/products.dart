import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'product.dart';

// List<Product> demoProducts = [
//   Product(
//     id: Random().nextDouble().toString(),
//     name: 'Couve',
//     amount: 6,
//     imgSrc: 'https://assets.instabuy.com.br/ib.item.image.medium/m-761f9db66b0f4f10904263e1b120e8e6.jpeg',
//     totalAdded: 100,
//     totalUsed: 12,
//   ),
//   Product(
//     id: Random().nextDouble().toString(),
//     name: 'Cebola',
//     amount: 4,
//     imgSrc: 'https://assets.instabuy.com.br/ib.item.image.medium/m-b73f139405b748fdaf1615dba491894e.jpeg',
//     totalAdded: 100,
//     totalUsed: 12,
//   ),
//   Product(
//     id: Random().nextDouble().toString(),
//     name: 'Cenoura',
//     amount: 7,
//     imgSrc: 'https://assets.instabuy.com.br/ib.item.image.medium/m-c5c75f72467b4089997934c21a6295cd.jpeg',
//     totalAdded: 100,
//     totalUsed: 10,
//   ),
//   Product(
//     id: Random().nextDouble().toString(),
//     name: 'Maçã',
//     amount: 12,
//     imgSrc: 'https://assets.instabuy.com.br/ib.item.image.medium/m-edc6efc8547b47a8829f2997e45a9421.png',
//     totalAdded: 100,
//     totalUsed: 71,
//   ),
//   Product(
//     id: Random().nextDouble().toString(),
//     name: 'Ovos',
//     amount: 30,
//     imgSrc: 'https://assets.instabuy.com.br/ib.item.image.medium/m-4f6d958f593c4d07892a0dbee10197a8.png',
//     totalAdded: 100,
//     totalUsed: 67,
//   ),
// ];

class Products with ChangeNotifier {
  final String _apiUrl =
      'https://flutter-fridge-default-rtdb.firebaseio.com/products.json';
  List<Product> _items = [];

  List<Product> get items => [..._items];

  int get itemsCount {
    return _items.length;
  }

  List<Product> get usedRanking {
    List<Product> ranking = [..._items];
    ranking.sort((a, b) => b.totalUsed.compareTo(a.totalUsed));
    // print('Sort by Age: ' + list.toString());
    print(ranking);
    return ranking;
  }

  Future<void> loadProducts() async {
    final res = await http.get(_apiUrl);
    Map<String, dynamic> data = json.decode(res.body);

    if(data != null) {
      data.forEach((productId, productData) {
        addProductToLocalItems(
          id: productId,
          name: productData['name'],
          amount: productData['amount'],
          imgSrc: productData['imgSrc'],
          totalUsed: productData['totalUsed'],
          totalAdded: productData['totalAdded'],
        );
      });
      notifyListeners();
    }

    return Future.value();
  }

  Future<void> saveProduct(Product newProduct) async {
    final alreadyExists =
        _items.indexWhere((prod) => prod.name == newProduct.name);

    var body = json.encode({
      'name': newProduct.name,
      'amount': newProduct.amount,
      'imgSrc': newProduct.imgSrc,
      'totalUsed': newProduct.totalUsed,
      'totalAdded': newProduct.totalAdded,
    });

    // update product
    if (alreadyExists >= 0) {
      _items[alreadyExists] = newProduct;
      notifyListeners();
    } else {
      // add product
      final res = await http.post(_apiUrl, body: body);
      var id = json.decode(res.body)['name'];

      addProductToLocalItems(
        id: id,
        name: newProduct.name,
        amount: newProduct.amount,
        imgSrc: newProduct.imgSrc,
        totalUsed: newProduct.totalUsed,
        totalAdded: newProduct.totalAdded,
      );
      notifyListeners();
    }

    return null;
  }

  addProductToLocalItems({String id, String name, int amount, String imgSrc, int totalUsed, int totalAdded}) {
    _items.add(Product(
      id: id,
      name: name,
      amount: amount,
      imgSrc: imgSrc,
      totalUsed: totalUsed,
      totalAdded: totalAdded,
    ));
  }

}

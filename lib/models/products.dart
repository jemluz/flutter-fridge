import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'product.dart';

class Products with ChangeNotifier {
  final String _baseApiUrl = 'https://flutter-fridge-default-rtdb.firebaseio.com';
  final String _colection = '/products';

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

  Future<List<Product>> loadProducts() async {
    final res = await http.get('$_baseApiUrl$_colection.json');
    Map<String, dynamic> data = json.decode(res.body);

    _items.clear();
    if (data != null) {
      data.forEach((productId, productData) {
        _items.add(Product(
          id: productId,
          name: productData['name'],
          amount: productData['amount'],
          imgSrc: productData['imgSrc'],
          totalUsed: productData['totalUsed'],
          totalAdded: productData['totalAdded'],
        ));
      });
      notifyListeners();
    }

    print('atualizou');

    return Future.value(_items);
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
      var error =  'Calma lá... já existe um produto cadastrado com esse nome ';
      throw error;
    } else {
      // add product
      final res = await http.post('$_baseApiUrl$_colection.json', body: body);

      _items.add(Product(
        id: json.decode(res.body)['name'],
        name: newProduct.name,
        amount: newProduct.amount,
        imgSrc: newProduct.imgSrc,
        totalUsed: newProduct.totalUsed,
        totalAdded: newProduct.totalAdded,
      ));
      notifyListeners();
    }

    return null;
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    var alreadyExists = _items.indexWhere((prod) => prod.id == id);

    var body = json.encode({
      'name': newProduct.name,
      'amount': newProduct.amount,
      'imgSrc': newProduct.imgSrc,
      'totalUsed': newProduct.totalUsed,
      'totalAdded': newProduct.totalAdded,
    });

    if (alreadyExists >= 0) {
      await http.patch('$_baseApiUrl$_colection/$id.json', body: body);
      _items[alreadyExists] = newProduct;
      notifyListeners();
    }

    return Future.value();
  }

  Future<void> deleteProduct(String id) async {
    final alreadyExists = _items.indexWhere((prod) => prod.id == id);

    if(alreadyExists >= 0) {
      final product = _items[alreadyExists];
      _items.remove(product);
        notifyListeners();

      final res = await http.delete('$_baseApiUrl$_colection/${product.id}.json');

      if(res.statusCode >= 400) {
        _items.insert(alreadyExists, product);
        notifyListeners();
      }
    }
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:stylish/models/Product.dart';
import 'package:http/http.dart' as http;

class ProductProvider with ChangeNotifier {
  List<Product> products = [];
  List<Product> showProducts = [];
  ProductProvider() {
    // print("xdd");

    loadAllProducts();
  }
  Future<void> filterWord({required String word}) async {
    showProducts = [];
    for (Product p in products) {
      if (p.title.contains(word.toLowerCase())) {
        showProducts.add(p);
      }
    }
    notifyListeners();
  }

  Future<void> filter({required String category}) async {
    showProducts = [];
    for (Product p in products) {
      if (p.category.toLowerCase() == category.toLowerCase()) {
        showProducts.add(p);
      }
    }
    notifyListeners();
  }

  Future<void> loadAllProducts() async {
    // print("xdd");
    final response = await http.get(
      Uri.parse('http://localhost:3000/products'),
      headers: {
        "Content-Type": "application/json",
        // 'Authorization': 'Bearer ${UserData.token!}'
      },
    );
    List productsJson = jsonDecode(response.body);
    products = [];
    for (Map productJson in productsJson) {
      Product newProduct = Product(
          id: productJson["_id"],
          title: productJson["name"],
          price: productJson["price"],
          description: productJson["description"],
          stock: productJson["quantity"],
          category: productJson["category"]);
      products.add(newProduct);
    }
    showProducts = [];
    showProducts.addAll(products);
    notifyListeners();
    // print(productsJson);
  }
}

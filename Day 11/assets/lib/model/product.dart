import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class Product {
  final int id;
  final String name;
  final int price;

  Product({required this.id, required this.name, required this.price});

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['id'],
        name: json['name'],
        price: json['price'],
      );
}

Future<List<Product>> loadProducts() async {
  final jsonString = await rootBundle.loadString('assets/data/products.json');
  final List<dynamic> jsonList = jsonDecode(jsonString);
  return jsonList.map((item) => Product.fromJson(item)).toList();
}

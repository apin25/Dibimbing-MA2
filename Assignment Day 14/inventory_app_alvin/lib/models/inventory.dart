import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventory_app_alvin/models/category.dart';

Inventory inventoryFromJson(String str) => Inventory.fromJson(json.decode(str));

String inventorylToJson(Inventory data) => json.encode(data.toJson());

class Inventory {
  dynamic id;
  String productName;
  String category;        
  Category? categoryDetails; 
  String brand;
  int quantity;
  String description;
  String createdAt;
  String updatedAt;
  bool isActive;

  Inventory({
    required this.id,
    required this.productName,
    required this.category,
    this.categoryDetails, 
    required this.brand,
    required this.quantity,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.isActive,
  });

  factory Inventory.fromJson(Map<String, dynamic> json) {
    return Inventory(
      id: json["id"],
      productName: json["product_name"],
      category: json["category"],
      brand: json["brand"],
      quantity: json["quantity"],
      description: json["description"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
      isActive: json["is_active"] == 1,
    );
  }

  factory Inventory.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc, {
    Category? categoryDetails,
  }) {
    final data = doc.data()!;
    return Inventory(
      id: doc.id,
      productName: data["product_name"],
      category: data["category"],
      categoryDetails: categoryDetails,
      brand: data["brand"],
      quantity: data["quantity"],
      description: data["description"],
      createdAt: data["created_at"],
      updatedAt: data["updated_at"],
      isActive: data["is_active"] == 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "product_name": productName,
      "category": category,
      "brand": brand,
      "quantity": quantity,
      "description": description,
      "created_at": createdAt,
      "updated_at": updatedAt,
      "is_active": isActive ? 1 : 0,
    };
  }

}
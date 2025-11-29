import 'dart:convert';

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));

String categoryToJson(Category data) => json.encode(data.toJson());

class Category {
  dynamic id;
  String categoryName;
  String description;
  bool isActive;

  Category({
    required this.id,
    required this.categoryName,
    required this.description,
    required this.isActive,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    final isActiveValue = json["is_active"] == 1 ? true : false;
    return Category(
      id: json["id"],
      categoryName: json["category_name"],
      description: json["description"],
      isActive: isActiveValue,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "category_name": categoryName,
      "description": description,
      "is_active": isActive ? 1 : 0,
    };
  }
}
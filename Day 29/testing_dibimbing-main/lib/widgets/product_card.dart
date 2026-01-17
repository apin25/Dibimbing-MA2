// lib/widgets/product_card.dart
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String name;
  final int price;
  final int stock;

  const ProductCard({
    super.key,
    required this.name,
    required this.price,
    required this.stock,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Text(name),
          Text('Rp $price'),
          ElevatedButton(
            // LOGIC UTAMA: Kalau stok 0, onPressed jadi null (Disable)
            onPressed: stock > 0 ? () {} : null,
            child: const Text('Beli'),
          ),
        ],
      ),
    );
  }
}
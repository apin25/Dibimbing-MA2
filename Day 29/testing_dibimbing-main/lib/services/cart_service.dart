// Lokasi: lib/services/cart_service.dart
class CartService {
  List<Map<String, dynamic>> items = [];

  void addToCart(String product, int price, int qty) {
    items.add({'product': product, 'price': price, 'qty': qty});
  }

  double getTotalPrice() {
    double total = 0;
    for (var item in items) {
      total += (item['price'] as int) * (item['qty'] as int);
    }

    // Logic Diskon (Nanti kita uncomment saat Test Case 2)
    if (total > 100000) {
      return total * 0.9; // Diskon 10%
    }

    return total;
  }
}
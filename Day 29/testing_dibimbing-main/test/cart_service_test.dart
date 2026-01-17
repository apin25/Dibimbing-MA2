import 'package:flutter_test/flutter_test.dart';
import 'package:testing_dibimbing/services/cart_service.dart';

void main() {
  group('Uji Logic CartService', () {
    print("🛒 [CART SERVICE TEST] Starting CartService unit tests...");

    // TASK 1: Hitung Total Harga Normal
    test('Given cart masih kosong, when pengguna add to cart, then menghasilkan harga total', () {
      print("📝 [CART TEST 1] Starting: Calculate total price without discount");
      // 1. SETUP
      print("  ├─ SETUP: Creating CartService instance");
      final cart = CartService(); 

      // 2. ACT (Skenario: Beli Apel 10rb sebanyak 2 biji)
      print("  ├─ ACT: Adding Apel 10000 qty 2");
      cart.addToCart('Apel', 10000, 2);

      // 3. EXPECT (Harusnya 20.000)
      print("  ├─ EXPECT: Total price should be 20000");
      expect(cart.getTotalPrice(), 20000);
      print("  └─ ✅ TEST 1 PASSED!");
    });

    // TASK 2: Cek Diskon > 100.000
    test('Harus dapat diskon 10% jika total belanja > 100.000', () {
      print("📝 [CART TEST 2] Starting: Check 10% discount for > 100000");
      // 1. SETUP
      print("  ├─ SETUP: Creating CartService instance");
      final cart = CartService();

      // 2. ACT (Skenario: Beli Laptop 200rb)
      print("  ├─ ACT: Adding Laptop 200000 qty 1");
      cart.addToCart('Laptop', 200000, 1);

      // 3. EXPECT (200rb - 10% = 180rb)
      print("  ├─ EXPECT: Total price should be 180000 (200000 - 10%)");
      expect(cart.getTotalPrice(), 180000);
      print("  └─ ✅ TEST 2 PASSED!");
    });

    print("✅ [CART SERVICE TEST] All tests completed!");
  });
}
// test/product_card_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:testing_dibimbing/widgets/product_card.dart'; // Sesuaikan import

void main() {
  print("🎨 [PRODUCT CARD TEST] Starting ProductCard widget tests...");

  testWidgets('ProductCard harus disable tombol Beli jika stok 0', (WidgetTester tester) async {
    print("📝 [PRODUCT TEST 1] Starting: ProductCard with stock = 0");
    // 1. SETUP & RENDER (PUMP)
    // Widget butuh MaterialApp sebagai induknya biar gak error error directionality
    print("  ├─ SETUP: Building widget tree with MaterialApp...");
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ProductCard(
            name: 'Laptop Gaming',
            price: 15000000,
            stock: 0, // SKENARIO KITA: STOK 0
          ),
        ),
      ),
    );
    print("  ├─ PUMP: Widget rendered");

    // 2. VERIFIKASI NAMA PRODUK
    // Pastikan text 'Laptop Gaming' muncul di layar
    print("  ├─ VERIFY: Checking for product name 'Laptop Gaming'");
    expect(find.text('Laptop Gaming'), findsOneWidget);
    print("  ├─ ✅ Product name found");

    // 3. VERIFIKASI TOMBOL MATI (DISABLED)
    // Cari tombolnya dulu
    print("  ├─ VERIFY: Looking for 'Beli' button");
    final tombolBeli = find.widgetWithText(ElevatedButton, 'Beli');

    // Pastikan tombolnya ketemu 1
    print("  ├─ VERIFY: Button should exist");
    expect(tombolBeli, findsOneWidget);
    print("  ├─ ✅ Button found");

    // Cek properti tombol: Apakah benar-benar disabled?
    // Cara ambil widget aslinya: tester.widget(...)
    print("  ├─ VERIFY: Checking button is disabled (onPressed == null)");
    final buttonWidget = tester.widget<ElevatedButton>(tombolBeli);

    // Kalau onPressed null, berarti disabled
    print("  ├─ ASSERT: onPressed property should be null");
    expect(buttonWidget.onPressed, isNull);
    print("  └─ ✅ TEST 1 PASSED! Button is disabled");
  });

  testWidgets('ProductCard harus enable tombol Beli jika stok > 0', (WidgetTester tester) async {
    print("📝 [PRODUCT TEST 2] Starting: ProductCard with stock = 1");
    // 1. SETUP & RENDER (PUMP)
    // Widget butuh MaterialApp sebagai induknya biar gak error error directionality
    print("  ├─ SETUP: Building widget tree with MaterialApp...");
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ProductCard(
            name: 'Laptop Gaming Tuf',
            price: 15000000,
            stock: 1, // SKENARIO KITA: STOK 1
          ),
        ),
      ),
    );
    print("  ├─ PUMP: Widget rendered");

    // 2. VERIFIKASI NAMA PRODUK
    // Pastikan text 'Laptop Gaming Tuf' muncul di layar
    print("  ├─ VERIFY: Checking for product name 'Laptop Gaming Tuf'");
    expect(find.text('Laptop Gaming Tuf'), findsOneWidget);
    print("  ├─ ✅ Product name found");

    // 3. VERIFIKASI TOMBOL AKTIF (ENABLED)
    // Cari tombolnya dulu
    print("  ├─ VERIFY: Looking for 'Beli' button");
    final tombolBeli = find.widgetWithText(ElevatedButton, 'Beli');

    // Pastikan tombolnya ketemu 1
    print("  ├─ VERIFY: Button should exist");
    expect(tombolBeli, findsOneWidget);
    print("  ├─ ✅ Button found");

    // Cek properti tombol: Apakah benar-benar enable?
    // Cara ambil widget aslinya: tester.widget(...)
    print("  ├─ VERIFY: Checking button is enabled (onPressed != null)");
    final buttonWidget = tester.widget<ElevatedButton>(tombolBeli);

    // Kalau onPressed tidak null, berarti enable
    print("  ├─ ASSERT: onPressed property should not be null");
    expect(buttonWidget.onPressed, isNotNull);
    print("  └─ ✅ TEST 2 PASSED! Button is enabled");
  });

  print("✅ [PRODUCT CARD TEST] All tests completed!");
}
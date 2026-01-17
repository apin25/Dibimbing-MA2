// integration_test/app_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:testing_dibimbing/main.dart' as app; // Import main.dart

void main() {
  // 1. Inisialisasi Integration Test (Wajib)
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('End-to-End Test: App start & check title', (tester) async {
    // 2. Jalankan Aplikasi (Full App)
    app.main();

    // 3. Tunggu app selesai rendering (PENTING: pumpAndSettle)
    // Beda sama pump(), pumpAndSettle nunggu sampai semua animasi kelar.
    await tester.pumpAndSettle();

    // 4. Skenario Sederhana: Pastikan text tertentu muncul
    // (Sesuaikan dengan text yang ada di main.dart mu)
    expect(find.text('Flutter Demo Home Page'), findsOneWidget);

    // Kalau mau simulasi tap tombol (+)
    final fab = find.byTooltip('Increment');
    await tester.tap(fab);
    await tester.pumpAndSettle(); // Tunggu animasi scroll/pindah

    expect(find.text('1'), findsOneWidget);
    print("berhasil");
  });
}
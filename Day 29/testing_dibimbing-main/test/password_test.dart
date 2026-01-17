// test/password_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:testing_dibimbing/utils/validator.dart'; // Import file logic (yg belum ada isinya)

void main() {
  print("🔐 [PASSWORD TEST] Starting password validation tests...");

  test('Password harus gagal jika kurang dari 6 karakter', () {
    print("📝 [PASSWORD TEST] Starting: Password < 6 chars should fail");
    // 1. Arrange & Act
    print("  ├─ ARRANGE: Testing password '12345' (5 characters)");
    print("  ├─ ACT: Calling validatePassword('12345')");
    bool result = validatePassword("12345"); // Panggil fungsi yg belum dibuat
    print("  ├─ RESULT: Got $result");

    // 2. Assert
    print("  ├─ ASSERT: Expecting false (password too short)");
    expect(result, false); // Harapannya False
    print("  └─ ✅ PASSWORD TEST PASSED!");
  });

  print("✅ [PASSWORD TEST] All tests completed!");
}
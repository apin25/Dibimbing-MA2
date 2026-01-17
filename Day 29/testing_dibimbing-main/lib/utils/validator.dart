// lib/utils/validator.dart
bool validatePassword(String password) {
  // Logic minimalis: Cuma cek panjang
  return password.length >= 6;
}

// Update lib/utils/validator.dart
bool validatePasswordRefined(String password) {
  if (password.length < 6) return false;

  // Cek apakah mengandung angka (Regex simple)
  bool hasDigit = password.contains(RegExp(r'[0-9]'));
  return hasDigit;
}
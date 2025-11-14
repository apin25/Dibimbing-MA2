import 'package:flutter/material.dart';

final ThemeData customTheme = ThemeData(
  brightness: Brightness.light,

  colorScheme: const ColorScheme.light(
    primary: Color(0xFF619BFE), // default
    secondary: Color(0xFFFEC559), // sunny
    tertiary: Color(0xFFBDB8EB), //rainy
    surface: Colors.white,
    onPrimary: Colors.white,
    onSurface: Colors.black87,
  ),
  
  scaffoldBackgroundColor: const Color(0xFFE9F0FB),

  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF9AB6F2),
    foregroundColor: Colors.white,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  ),

  textTheme: const TextTheme(
    // Ini suhu
    headlineLarge: TextStyle(
      fontSize: 72,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    // Ini cuaca
    titleMedium: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    // Lokasi dan info lainnya
    bodyMedium: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
    // Label kecil di kotak info
    labelLarge: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w500,
      color: Colors.black54,
      letterSpacing: 0.2,
    ),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFFFFD77B),
      foregroundColor: Colors.black87,
      textStyle: const TextStyle(
        fontWeight: FontWeight.w600,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 3,
      shadowColor: Colors.black26,
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white.withValues(alpha:0.8),
    hintStyle: const TextStyle(color: Colors.black45),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
  ),

  cardTheme: CardThemeData(
    color: Colors.white.withValues(alpha:0.8),
    elevation: 3,
    shadowColor: Colors.black12,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  ),
);
const LinearGradient berawanGradient = LinearGradient( 
  begin: Alignment.topCenter, 
  end: Alignment.bottomCenter, 
  colors: [ 
    Color(0xFFE7F1FF), 
    Color(0xFF619BFE), 
  ],
);
const LinearGradient beranginGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Color(0xFFD9F3F5),
    Color(0xFF9ED7E6),
    Color(0xFF6BC1D6), 
  ],
);
const LinearGradient panasGradient = LinearGradient(
   begin: Alignment.topCenter, 
   end: Alignment.bottomCenter, 
   colors: [
    Color(0xFFFEF9E2), 
    Color(0xFFFEC559)
  ],
);
const LinearGradient hujanGradient = LinearGradient( 
  begin: Alignment.topCenter, 
  end: Alignment.bottomCenter, 
  colors: [ 
    Color(0xFF777898), 
    Color(0xFFB1B1CB), 
    Color(0xFFB4B4E8), 
    Color(0xFF5770C2), 
  ],
);
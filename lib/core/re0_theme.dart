import 'package:flutter/material.dart';

class Re0Theme {
  // --- 配色方案 (Colors) ---
  static const Color royalWhite = Color(0xFFFDFDFD);
  static const Color witchLavender = Color(0xFFE6E6FA);
  static const Color crystalBlue = Color(0xFF4682B4);
  static const Color deepMidnight = Color(0xFF2C3E50);
  static const Color manaGlow = Color(0xFF7FFFD4);
  static const Color forbiddenGold = Color(0xFFD4AF37);
  static const Color errorRed = Color(0xFFA23535);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.light(
        primary: crystalBlue,
        secondary: witchLavender,
        surface: royalWhite,
        error: errorRed,
      ),
      scaffoldBackgroundColor: royalWhite,
      cardTheme: CardTheme(
        color: Colors.white.withOpacity(0.9),
        elevation: 8,
        shadowColor: crystalBlue.withOpacity(0.2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
          side: BorderSide(color: witchLavender.withOpacity(0.5), width: 1.5),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: witchLavender.withOpacity(0.1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: witchLavender),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: witchLavender.withOpacity(0.5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: crystalBlue, width: 2),
        ),
        labelStyle: const TextStyle(color: deepMidnight, fontWeight: FontWeight.bold),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: crystalBlue,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(999),
          ),
          elevation: 4,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: deepMidnight,
          fontSize: 22,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}

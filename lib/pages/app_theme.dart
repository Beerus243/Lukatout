import 'package:flutter/material.dart';

class AppTheme {
  // Palette de couleurs
  static const Color bg = Colors.white;
  static const Color form = Color(0xFFF5F5F5);
  static const Color primary = Color(0xFFCA9B6F); // Chocolat léger
  static const Color primaryLight = Color(0xFFD7B899);
  static const Color accent = Colors.white;
  static const Color inputFill = Color(0xFFF0F0F0);
  static const Color textPrimary = Color(0xFF5D4037); // Chocolat foncé
  static const Color textSecondary = Color(0xFF8D6E63);

  static ThemeData lightTheme() {
    return ThemeData(
      scaffoldBackgroundColor: bg,
      primaryColor: primary,
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: primary,
        secondary: primaryLight,
        background: bg,
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(
            fontSize: 26, fontWeight: FontWeight.w800, color: textPrimary),
        bodyMedium: TextStyle(fontSize: 14, color: textPrimary),
        titleMedium: TextStyle(fontSize: 13, color: textSecondary),
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        labelStyle: const TextStyle(fontSize: 14, color: textSecondary),
        filled: true,
        fillColor: inputFill,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFECF0F1), width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primary, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFECF0F1), width: 1.5),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: accent,
          minimumSize: const Size.fromHeight(55),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 2,
          shadowColor: Colors.black.withOpacity(0.1),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primary,
          textStyle: const TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      iconTheme: const IconThemeData(size: 24, color: textPrimary),
      cardTheme: CardThemeData(
        color: form,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 0,
        margin: EdgeInsets.zero,
        surfaceTintColor: Colors.transparent,
      ),
    );
  }
}

import 'package:flutter/material.dart';

class AppTheme {
  // 颜色定义 - 基于原项目的 Tailwind 配置
  static const Color wheat50 = Color(0xFFFFFBF5);
  static const Color wheat100 = Color(0xFFFFF7EB);
  static const Color wheat200 = Color(0xFFFEEFD6);
  static const Color wheat300 = Color(0xFFFDE7C2);
  static const Color wheat400 = Color(0xFFFCDFAD);
  static const Color wheat500 = Color(0xFFFBD799);
  static const Color wheat600 = Color(0xFFF9CF84);

  static const Color rosyBrown50 = Color(0xFFFAF5F5);
  static const Color rosyBrown100 = Color(0xFFF5EBEB);
  static const Color rosyBrown200 = Color(0xFFE6CDCD);
  static const Color rosyBrown300 = Color(0xFFD7AFAF);
  static const Color rosyBrown400 = Color(0xFFC89191);
  static const Color rosyBrown500 = Color(0xFFB97373);
  static const Color rosyBrown600 = Color(0xFFAA5555);
  static const Color rosyBrown700 = Color(0xFF8B4444);
  static const Color rosyBrown800 = Color(0xFF6C3333);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.light(
        primary: rosyBrown600,
        secondary: wheat500,
        surface: wheat50,
        error: Colors.red.shade400,
      ),
      scaffoldBackgroundColor: wheat50,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: rosyBrown800,
        elevation: 0,
        centerTitle: true,
      ),
      cardTheme: CardTheme(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: wheat200, width: 1),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: const BorderSide(color: rosyBrown300, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: const BorderSide(color: rosyBrown300, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: const BorderSide(color: rosyBrown400, width: 3),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: wheat300,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 48,
          fontWeight: FontWeight.bold,
          color: rosyBrown800,
        ),
        displayMedium: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          color: rosyBrown800,
        ),
        displaySmall: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: rosyBrown800,
        ),
        headlineMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: rosyBrown800,
        ),
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: rosyBrown800,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          color: rosyBrown800,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          color: rosyBrown600,
        ),
      ),
      fontFamily: 'System',
    );
  }
}

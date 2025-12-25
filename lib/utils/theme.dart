import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  // Dark Mode Colors
  static const Color darkBg = Color(0xFF1A1614);
  static const Color darkSurface = Color(0xFF2D2622);
  static const Color darkSurfaceHighlight = Color(0xFF403630);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.light(
        primary: rosyBrown600,
        secondary: wheat500,
        surface: wheat50,
        error: Colors.red.shade400,
        onSurface: rosyBrown800,
        outline: Color(0xFFE6D5D5),
        outlineVariant: Color(0xFFF2E4CF),
      ),
      scaffoldBackgroundColor: wheat50,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: rosyBrown800,
        elevation: 0,
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: wheat50,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
      ),
      cardTheme: CardThemeData(
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
          borderSide: const BorderSide(color: rosyBrown200, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: const BorderSide(color: rosyBrown200, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: const BorderSide(color: rosyBrown300, width: 2),
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

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.dark(
        primary: rosyBrown300,
        secondary: wheat500,
        surface: darkSurface,
        onSurface: wheat100,
        outline: Color(0xFF4A3F3A),
        outlineVariant: Color(0xFF3D342F),
      ),
      scaffoldBackgroundColor: darkBg,
      appBarTheme: const AppBarTheme(
        backgroundColor: darkSurface,
        foregroundColor: wheat100,
        elevation: 0,
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: darkBg,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
      ),
      cardTheme: CardThemeData(
        color: darkSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: darkSurfaceHighlight, width: 1),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: darkSurface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: const BorderSide(color: darkSurfaceHighlight, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: const BorderSide(color: darkSurfaceHighlight, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: const BorderSide(color: rosyBrown400, width: 2),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        hintStyle: const TextStyle(color: Colors.white38),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: rosyBrown300,
          foregroundColor: darkBg,
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
          color: wheat100,
        ),
        displayMedium: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          color: wheat100,
        ),
        displaySmall: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: wheat100,
        ),
        headlineMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: wheat100,
        ),
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: wheat100,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          color: wheat100,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          color: wheat200,
        ),
      ),
      fontFamily: 'System',
    );
  }
}

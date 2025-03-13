import 'package:flutter/material.dart';

class AppTheme {
  // Primary colors
  static const Color primary = Color(0xFF046E4A);
  static const Color primaryLight = Color(0xFFECF8F3);
  static const Color primaryDark = Color(0xFF035238);
  
  // Secondary colors
  static const Color accent = Color(0xFF32B596);
  static const Color accentLight = Color(0xFFE6F5F0);
  
  // Neutral colors
  static const Color background = Colors.white;
  static const Color surface = Color(0xFFF8F8F8);
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color divider = Color(0xFFEEEEEE);
  
  // Animation durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 500);
  static const Duration longAnimation = Duration(milliseconds: 800);

  // Radius values
  static const double radiusSmall = 8.0;
  static const double radiusMedium = 16.0;
  static const double radiusLarge = 32.0;
  
  // Elevation values
  static const List<BoxShadow> elevation1 = [
    BoxShadow(
      color: Color(0x0D000000),
      blurRadius: 5,
      offset: Offset(0, 2),
    )
  ];
  
  static const List<BoxShadow> elevation2 = [
    BoxShadow(
      color: Color(0x1A000000),
      blurRadius: 10,
      offset: Offset(0, 4),
    )
  ];
  
  // Common text styles
  static TextStyle get headlineLarge => const TextStyle(
    fontSize: 28.0,
    fontWeight: FontWeight.bold,
    color: textPrimary,
    height: 1.3,
  );
  
  static TextStyle get headlineMedium => const TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
    color: textPrimary,
    height: 1.3,
  );
  
  static TextStyle get headlineSmall => const TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.w600,
    color: textPrimary,
    height: 1.3,
  );
  
  static TextStyle get bodyLarge => const TextStyle(
    fontSize: 16.0,
    color: textPrimary,
    height: 1.5,
  );
  
  static TextStyle get bodyMedium => const TextStyle(
    fontSize: 14.0,
    color: textPrimary,
    height: 1.5,
  );
  
  static TextStyle get bodySmall => const TextStyle(
    fontSize: 12.0,
    color: textSecondary,
    height: 1.5,
  );
  
  // Get ThemeData
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: primary,
      colorScheme: const ColorScheme.light(
        primary: primary,
        secondary: accent,
        background: background,
        surface: surface,
      ),
      scaffoldBackgroundColor: background,
      fontFamily: 'Poppins',
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
        ),
        buttonColor: primary,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMedium),
          ),
        ),
      ),
      cardTheme: CardTheme(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
        ),
        color: background,
      ),
    );
  }
}

import 'package:flutter/material.dart';

// Light theme colors
class LightThemeColors {
  static const Color primary = Color(0xFFC39E18);
  static const Color gray900 = Color(0xFF3E3E3E);
  static const Color gray700 = Color(0xFF626262);
  static const Color gray500 = Color(0xFF8E8E8E);
  static const Color gray300 = Color(0xFFBEBEBE);
  static const Color gray100 = Color(0xFFE9E9E9);
  static const Color background = Color(0xFFF1F2F6);
  static const Color black = Colors.black;
  static const Color white = Colors.white;
}

// Dark theme colors
class DarkThemeColors {
  static const Color primary = Color(0xFFE5B82D); // Brighter gold for dark mode
  static const Color gray900 = Color(0xFFE1E1E1); // Inverted grays
  static const Color gray700 = Color(0xFFCCCCCC);
  static const Color gray500 = Color(0xFFAAAAAA);
  static const Color gray300 = Color(0xFF666666);
  static const Color gray100 = Color(0xFF424242);
  static const Color background = Color(0xFF121212); // Material dark background
  static const Color black = Colors.white; // Inverted
  static const Color white = Colors.black; // Inverted
}

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: LightThemeColors.primary,
      surface: LightThemeColors.white,
      onSurface: LightThemeColors.gray900,
    ),
    scaffoldBackgroundColor: LightThemeColors.background,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: LightThemeColors.gray900),
      bodyMedium: TextStyle(color: LightThemeColors.gray700),
      titleLarge: TextStyle(color: LightThemeColors.gray900),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: LightThemeColors.white,
      foregroundColor: LightThemeColors.gray900,
      elevation: 0,
    ),
    iconTheme: const IconThemeData(
      color: LightThemeColors.gray700,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: DarkThemeColors.primary,
      surface: DarkThemeColors.gray100,
      onSurface: DarkThemeColors.gray900,
    ),
    scaffoldBackgroundColor: DarkThemeColors.background,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: DarkThemeColors.gray900),
      bodyMedium: TextStyle(color: DarkThemeColors.gray700),
      titleLarge: TextStyle(color: DarkThemeColors.gray900),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: DarkThemeColors.gray100,
      foregroundColor: DarkThemeColors.gray900,
      elevation: 0,
    ),
    iconTheme: const IconThemeData(
      color: DarkThemeColors.gray700,
    ),
  );
}

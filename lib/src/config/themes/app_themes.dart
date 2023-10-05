import 'package:flutter/material.dart';

abstract class AppTheme {
  // Settings Light Theme
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: const Color(0xFF792C2C),
      brightness: Brightness.light,
    );
  }

  static ThemeData get dark {
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: const Color(0xFF792C2C),
      brightness: Brightness.dark
    );
  }
}
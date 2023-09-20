import 'package:anime_list/src/config/color/color_scheme.dart';
import 'package:flutter/material.dart';

abstract class AppTheme {
  // Settings Light Theme
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      colorScheme: lightColorScheme,
    );
  }

  static ThemeData get dark {
    return ThemeData(
      useMaterial3: true,
      colorScheme: darkColorScheme,
    );
  }
}
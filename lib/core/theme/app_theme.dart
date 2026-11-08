import 'package:flutter/material.dart';

class AppTheme {
  static const seed = Color(0xFF6750A4);

  static ThemeData get light => _build(Brightness.light);
  static ThemeData get dark => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final scheme = ColorScheme.fromSeed(seedColor: seed, brightness: brightness);
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: brightness == Brightness.light
          ? const Color(0xFFF8F7FC)
          : const Color(0xFF121118),
      appBarTheme: const AppBarTheme(centerTitle: false, elevation: 0),
      cardTheme: CardTheme(
        elevation: 0,
        color: brightness == Brightness.light ? Colors.white : const Color(0xFF211F27),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

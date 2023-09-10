import 'package:flutter/material.dart';

ThemeData generateLightTheme() {
  return ThemeData.from(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.indigo,
      brightness: Brightness.light,
    ),
  );
}

ThemeData generateDarkTheme() {
  return ThemeData.from(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.indigo,
      brightness: Brightness.dark,
    ),
  );
}

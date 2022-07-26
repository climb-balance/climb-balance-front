import 'package:climb_balance/ui/theme/colorSchema.dart';
import 'package:flutter/material.dart';

ThemeData mainLightTheme() {
  return ThemeData().copyWith(
    colorScheme: lightColorScheme,
    extensions: <ThemeExtension<dynamic>>[],
  );
}

ThemeData mainDarkTheme() {
  return ThemeData.dark().copyWith(
    colorScheme: darkColorScheme,
    extensions: <ThemeExtension<dynamic>>[],
  );
}

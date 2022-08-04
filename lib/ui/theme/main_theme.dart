import 'package:climb_balance/ui/theme/color_schema.dart';
import 'package:climb_balance/ui/theme/text_theme.dart';
import 'package:flutter/material.dart';

ThemeData mainLightTheme() {
  return ThemeData().copyWith(
    colorScheme: lightColorScheme,
    extensions: <ThemeExtension<dynamic>>[],
    textTheme: customTextTheme(ThemeData.light().textTheme, lightColorScheme),
  );
}

ThemeData mainDarkTheme() {
  return ThemeData.dark().copyWith(
    colorScheme: darkColorScheme,
    extensions: <ThemeExtension<dynamic>>[],
    textTheme: customTextTheme(ThemeData.dark().textTheme, darkColorScheme),
  );
}

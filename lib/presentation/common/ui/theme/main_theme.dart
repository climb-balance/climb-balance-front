import 'package:climb_balance/presentation/common/ui/theme/text_theme.dart';
import 'package:flutter/material.dart';

import 'color_schema.dart';

ThemeData mainLightTheme() {
  return ThemeData(
    brightness: Brightness.light,
  ).copyWith(
    colorScheme: lightColorScheme,
    extensions: <ThemeExtension<dynamic>>[],
    textTheme: customTextTheme(ThemeData.light().textTheme, lightColorScheme),
    scaffoldBackgroundColor: lightColorScheme.surface,
  );
}

ThemeData mainDarkTheme() {
  return ThemeData(
    brightness: Brightness.dark,
  ).copyWith(
    colorScheme: darkColorScheme,
    extensions: <ThemeExtension<dynamic>>[],
    textTheme: customTextTheme(
      ThemeData(
        fontFamily: 'text',
      ).textTheme.copyWith(),
      darkColorScheme,
    ),
    scaffoldBackgroundColor: darkColorScheme.background,
  );
}

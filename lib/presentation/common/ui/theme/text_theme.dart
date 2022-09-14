import 'package:flutter/material.dart';

TextTheme customTextTheme(TextTheme base, ColorScheme color) {
  return base.copyWith(
    headline5: base.headline5!.copyWith(
      fontWeight: FontWeight.w900,
    ),
    headline6: base.headline6!.copyWith(
      fontWeight: FontWeight.w600,
    ),
    subtitle1: base.subtitle1!.copyWith(
      fontSize: 20,
      color: color.secondary,
      fontWeight: FontWeight.w600,
    ),
    subtitle2: base.subtitle2!.copyWith(
      color: color.secondary,
      fontWeight: FontWeight.w400,
    ),
    bodyText1: base.bodyText1!.copyWith(),
  );
}
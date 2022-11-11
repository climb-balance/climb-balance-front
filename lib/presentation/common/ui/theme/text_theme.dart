import 'package:flutter/material.dart';

TextTheme customTextTheme(TextTheme base, ColorScheme color) {
  return base.copyWith(
    headline2: base.headline2!.copyWith(
      fontWeight: FontWeight.w900,
      fontSize: 40,
      color: color.onBackground,
    ),
    headline3: base.headline3!.copyWith(
      fontWeight: FontWeight.w400,
      fontSize: 36,
      color: color.onBackground,
    ),
    headline4: base.headline4!.copyWith(
      fontWeight: FontWeight.w400,
      fontSize: 32,
      color: color.onBackground,
    ),
    headline5: base.headline5!.copyWith(
      fontSize: 24,
      fontWeight: FontWeight.w700,
      color: color.onBackground,
    ),
    headline6: base.headline6!.copyWith(
      fontWeight: FontWeight.w500,
      fontSize: 20,
      color: color.onBackground,
    ),
    subtitle1: base.subtitle1!.copyWith(
      fontSize: 20,
      color: color.onBackground,
      fontWeight: FontWeight.w400,
    ),
    subtitle2: base.subtitle2!.copyWith(
      color: color.onBackground,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    bodyText1: base.bodyText1!.copyWith(
      fontWeight: FontWeight.w600,
      fontSize: 16,
      color: color.onBackground,
    ),
    bodyText2: base.bodyText1!.copyWith(
      fontWeight: FontWeight.w500,
      fontSize: 14,
      color: color.onBackground,
    ),
  );
}

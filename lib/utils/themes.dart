import 'package:flutter/material.dart';
import 'package:trippify/utils/colors.dart';
import 'package:trippify/utils/styles.dart';

ThemeData appTheme() {
  return ThemeData(
      primaryColor: primaryColor,
      indicatorColor: primaryColor,
      inputDecorationTheme: inputDecorationTheme(),
      elevatedButtonTheme: elevatedButtonThemeData(),
      appBarTheme: appBarTheme());
}

AppBarTheme appBarTheme() => const AppBarTheme();

ElevatedButtonThemeData elevatedButtonThemeData() {
  return ElevatedButtonThemeData(
    style: ButtonStyle(
      shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
      backgroundColor: WidgetStateProperty.all(primaryColor),
      foregroundColor: WidgetStateProperty.all(colorFFFFFFFF),
    ),
  );
}

InputDecorationTheme inputDecorationTheme() {
  return InputDecorationTheme(
    labelStyle: AppStyles.tsFS12CBCW500,
    floatingLabelStyle: AppStyles.tsFS12CPW500,
    focusColor: primaryColor,
    filled: true,
    fillColor: colorFFFFFFFF,
    border: OutlineInputBorder(
      borderSide: BorderSide(
        color: borderColor,
        width: 1,
      ),
      borderRadius: BorderRadius.circular(15),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: borderColor,
        width: 1,
      ),
      borderRadius: BorderRadius.circular(15),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: primaryColor,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(15),
    ),
  );
}

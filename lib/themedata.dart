import 'package:flutter/material.dart';

class AppTheme {
  // main four colors for now
  static final accentMain = Color.fromRGBO(131, 195, 163, 1);
  static final accentSecondary = Color.fromRGBO(4, 67, 171, 1);

  static final darkBackground = Color.fromRGBO(44, 44, 60, 1);
  static final lightBackground = Color.fromRGBO(255, 255, 255, 1);
  static final headerFontWeight = FontWeight.w600;
  static final headerFontSize = 30.0;

  static ThemeData maintheme() {
    return ThemeData(
        iconTheme: IconThemeData(
          color: accentMain,
        ),
        primaryColor: darkBackground,
        appBarTheme: AppBarTheme(
          backgroundColor: darkBackground,
          actionsIconTheme: IconThemeData(color: accentMain),
        ));
  }
}

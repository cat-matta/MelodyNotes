import 'package:flutter/material.dart';

class AppTheme {
  // main four colors for now
  static final accentMain = Color.fromRGBO(131, 195, 163, 1);
  static final accentSecondary = Color.fromRGBO(4, 67, 171, 1);

  static final darkBackground = Color.fromRGBO(44, 44, 60, 1);
  static final lightBackground = Color.fromRGBO(234, 234, 235, 1);

  static ThemeData maintheme() {
    return ThemeData(
        iconTheme: IconThemeData(color: accentMain),
        primaryColor: darkBackground,
        appBarTheme: AppBarTheme(
          backgroundColor: darkBackground,
          actionsIconTheme: IconThemeData(color: accentMain),
        ));
  }
}

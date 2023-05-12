import 'package:flutter/material.dart';

class MyTheme {
  static ThemeData get adminTheme {
    return ThemeData(
      primarySwatch: MyColors.myMaterialMainColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: MyColors.mainColor,
        elevation: 0,
      ),
      primaryColor: MyColors.mainColor,
      fontFamily: "Alexandria",
    );
  }
}

class MyColors {
  static const Color mainColor = Color(0xFF2D71B4);
  static const Color blackColor = Color(0xFF193C68);
  static const Color whiteColor = Color(0xFFB9E5F9);

  static MaterialColor myMaterialMainColor = const MaterialColor(
    0xFF2D71B4,
    {
      50: Color(0xFF2D71B4),
      100: Color(0xFF2D71B4),
      200: Color(0xFF2D71B4),
      300: Color(0xFF2D71B4),
      400: Color(0xFF2D71B4),
      500: Color(0xFF2D71B4),
      600: Color(0xFF2D71B4),
      700: Color(0xFF2D71B4),
      800: Color(0xFF2D71B4),
      900: Color(0xFF2D71B4),
    },
  );
}

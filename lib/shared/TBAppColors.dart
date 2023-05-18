import 'package:flutter/material.dart';
class Palette {
  static const MaterialColor kToDark = MaterialColor(
    0xff8532B8, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xffF5F5F5),//10%
      100: Color(0xffF6F6F6),//20%
      200: Color(0xf525252),//30%
      300: Color(0xffd4c4bc),//40%
      400: Color(0xffeacbb4),//50%
      500: Color(0xffffff96),//60%
      600: Color(0xffffef64),//70%
      700: Color(0xffe8d5f4),//80%
      800: Color(0xffb862eb),//90%
      900: Color(0xff8532B8),//100%
    },
  );
  static const Color appPrimaryDark = Color(0xff8532B8);
  static const Color appPrimaryAccent = Color(0xffb862eb);
  static const Color appPrimaryLight = Color(0xffe8d5f4);
  static const Color appSecondaryDark = Color(0xffffef64);
  static const Color appSecondaryLight = Color(0xffffff96);
}
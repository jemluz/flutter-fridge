import 'package:flutter/material.dart';

class AppColors {
  static const BLACK = Color.fromRGBO(0, 0, 0, 1);
  static const GRAY_n141 = Color.fromRGBO(141, 141, 141, 1);

  static const GREEN_n51 = Color.fromRGBO(51, 175, 170, 1);
  static const GREEN_n0 = Color.fromRGBO(0, 114, 110, 1);
  static const GREEN_n234 = Color.fromRGBO(225, 249, 244, 1);

  static const YELLOW_n119 = Color.fromRGBO(119, 115, 98, 1);
  static const YELLOW_n245 = Color.fromRGBO(234, 243, 237, 1);

  static const RED_n230 = Color.fromRGBO(230, 82, 82, 1);
  static const RED_n254 = Color.fromRGBO(254, 236, 236, 1);
}

ThemeData greenTheme(BuildContext context) {
  return ThemeData(
    primaryColor: AppColors.GREEN_n51,
    accentColor: AppColors.GREEN_n234,
    scaffoldBackgroundColor: Colors.white,
    iconTheme: IconThemeData(color: AppColors.GRAY_n141.withOpacity(.5)),
    fontFamily: 'DidactGothic',
    colorScheme: ColorScheme.light(
      primary: AppColors.GREEN_n51,
      secondary: AppColors.GREEN_n0,
      error: AppColors.RED_n230,
    ),
  );
}

ThemeData yellowTheme(BuildContext context) {
  return ThemeData(
    primaryColor: AppColors.YELLOW_n119,
    accentColor: AppColors.YELLOW_n245,
    scaffoldBackgroundColor: Colors.white,
    iconTheme: IconThemeData(color: AppColors.GRAY_n141.withOpacity(.5)),
    fontFamily: 'DidactGothic',
    colorScheme: ColorScheme.light(
      primary: AppColors.YELLOW_n119,
      secondary: AppColors.YELLOW_n245,
      error: AppColors.RED_n230,
    ),
  );
}
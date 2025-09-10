import 'package:almonazim/data/data%20source/locale/store_theme_mode.dart';
import 'package:flutter/material.dart';

bool isDark = StoreThemeMode.getThemeMode() == ThemeMode.dark;

class AppColor {
  // App theme colors

  static const Color primaryColor = Color.fromARGB(255, 245, 157, 68);

  // static const Color primaryColor = Color(0xFF0077B6);
  static const Color lightBackgroundColor = AppColor.lightGrey;
  // static const Color whiteBackgroundColor = Color(0xFFF5F5F5);
  static const Color dark = Color(0xFF2F2F2F);
  static const Color darkBackgroundColor = Color(0xFF212121);

  // static const Color brownColor = Colors.brown;
  // Text colors
  static Color textPrimary = isDark ? Colors.white : const Color(0xFF2D4F5B);
  static const Color textWhite = Colors.white;

  // Background colors
  static const Color light = Color(0xFFF6F6F6);
  static const Color darkText = Color(0xFF2D4F5B);

  static const Color primaryBackground = Color(0xFFF3F5FF);
  // Background Container colors
  static const Color lightContainer = Color(0xFFF6F6F6);
  static Color darkContainer = AppColor.white.withOpacity(0.1);

  // Button colors
  static const Color buttonPrimary = Color.fromARGB(255, 0, 137, 130);
  static const Color buttonSecondary = Color(0xFF6C757D);

  static const Color buttonDisabled = Color(0xFFC4C4C4);
  // Border colors
  static const Color borderPrimary = Color(0xFFD9D9D9);
  static const Color borderSecondary = Color(0xFFE6E6E6);

  // Failure and validation colors

  static const Color warning = Color(0xFFF57C00);
  static const Color info = Color(0xFF1976D2);

  //colors
  static Color green = isDark
      ? const Color.fromARGB(255, 138, 234, 141)
      : const Color(0xFF388E3C);
  static Color red = isDark
      ? const Color.fromARGB(255, 255, 136, 128)
      : const Color.fromRGBO(244, 67, 54, 1);

  static Color blue = isDark
      ? const Color.fromARGB(255, 130, 210, 250)
      : const Color.fromARGB(255, 70, 144, 209);

  //black and white
  //white when dark mode and black when light mode
  static Color whiteMainReverse =
      isDark ? AppColor.white : const Color(0xFF2D4F5B);
  static Color whiteBlackReverse = isDark ? AppColor.white : AppColor.black;
  //dark when dark mode and white when light mode
  static Color whiteBlackSame = isDark ? AppColor.black : AppColor.white;

  static Color whiteDarkSame = isDark ? AppColor.dark : AppColor.white;
  static Color backgroundWhiteBlackSame =
      isDark ? AppColor.darkBackgroundColor : AppColor.lightBackgroundColor;
  // Neutral Shades
  static const Color black = Color(0xFF232323);

  static const Color lightTextFieldFillColor = AppColor.white;

  static const Color darkTextFieldFillColor = AppColor.darkBackgroundColor;
  static Color textFieldFillColor = isDark
      ? AppColor.darkTextFieldFillColor
      : AppColor.lightTextFieldFillColor;

  static const Color darkerGrey = Color(0xFF4F4F4F);

  static const Color darkGrey = Color(0xFFD9D9D9);
  static const Color grey = Color(0xFFE0E0E0);
  static const Color softGrey = Color(0xFFF4F4F4);
  static const Color lightGrey = Color(0xFFF5F5F5);
  static const Color white = Color(0xFFFFFFFF);
  static const Color shimmerColor = Color.fromARGB(255, 132, 132, 132);

  static List<Color> reportColors = [
    const Color.fromARGB(255, 9, 158, 216),
    AppColor.buttonPrimary,
    const Color.fromARGB(255, 239, 152, 22),
    Colors.red,
    Colors.purple,
    Colors.cyan,
  ];
  static Map<int, Color> accountLevelColors = {
    0: AppColor.primaryColor,
    1: Colors.purple,
    2: Colors.blue,
    3: Colors.yellow,
    4: Colors.brown,
    // 5: AppColor.whiteBlackReverse,
    // 6: Colors.indigo,
  };

  AppColor._();
}

import 'package:almonazim/core/helper/pref_storage.dart';
import 'package:flutter/material.dart';

class StoreThemeMode {
  StoreThemeMode._();

  static Future<void> setThemeMode(ThemeMode themeMode) async {
    await PrefStorage.setBool("isDark", themeMode == ThemeMode.dark);
  }

  static ThemeMode getThemeMode() {
    bool? isDark = PrefStorage.getBool('isDark');
    if (isDark == true) {
      return ThemeMode.dark;
    } else if (isDark == false) {
      return ThemeMode.light;
    } else {
      return ThemeMode.system;
    }
  }
}

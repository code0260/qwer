import 'dart:io';

import 'package:almonazim/core/constant/app_routes.dart';
import 'package:almonazim/core/helper/overlay/floating_overlay_icons.dart';
import 'package:almonazim/core/helper/pref_storage.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/locale/sqflite/database_helper.dart';
import 'package:almonazim/data/data%20source/locale/store_show_overlay_icons.dart';
import 'package:almonazim/data/data%20source/locale/store_step.dart';
import 'package:almonazim/data/data%20source/locale/store_theme_mode.dart';
import 'package:almonazim/data/model/place%20models/places_model.dart';
import 'package:almonazim/data/model/user%20models/store_user_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> logout() async {
  ThemeMode themeMode = StoreThemeMode.getThemeMode();
  currencies.clear();
  categories.clear();
  productsByCategory.clear();
  employeesDepartments.clear();
  favoritesMap.clear();
  invoices.clear();
  productDiscount.clear();
  offers.clear();
  offersToShow.clear();
  placesModel = PlacesModel();
  units.clear();
  PrefStorage.clearPreferencesData();
  StoreStep.setStep("1");
  StoreThemeMode.setThemeMode(themeMode);
  FloatingOverlayIcons.removeFloatingWidget();
  await StoreShowOverlayIcons.setShowOverlayIcons(false);
  await DatabaseHelper.clearDatabase();
  if (!Platform.isWindows) {
    await FirebaseMessaging.instance
        .unsubscribeFromTopic("users${StoreUserModel.instance.usersId}");
  }
  Get.offAllNamed(AppRoute.loginScreen);
}

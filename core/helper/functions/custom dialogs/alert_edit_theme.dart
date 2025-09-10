import 'dart:io';

import 'package:almonazim/core/constant/app_color.dart';
import 'package:almonazim/core/shared/buttons/apply_button.dart';
import 'package:almonazim/core/shared/buttons/cancel_button.dart';
import 'package:almonazim/data/data%20source/locale/store_theme_mode.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restart_app/restart_app.dart';

void alertEditTheme() {
  showDialog(
    barrierDismissible: false,
    context: Get.context!,
    builder: (BuildContext context) {
      return PopScope(
        canPop: false,
        child: AlertDialog(
          title: const Row(
            children: [
              Text(
                "ملاحظة",
                textAlign: TextAlign.start,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Spacer(),
            ],
          ),
          content: Text(
            Platform.isWindows
                ? "الرجاء إعادة تشغيل التطبيق من أجل تطبيق الوضع الجديد"
                : "سيتم إعادة تشغيل التطبيق من أجل تطبيق الوضع الجديد",
            textAlign: TextAlign.start,
          ),
          actions: [
            const CancelButton(),
            ApplyButton(
              onPressed: () async {
                await StoreThemeMode.setThemeMode(
                    isDark ? ThemeMode.light : ThemeMode.dark);

                if (Platform.isAndroid || Platform.isIOS) {
                  Restart.restartApp();
                } else {
                  exit(0);
                }
              }, // User confirms exit
              title: "فهمت",
            ),
          ],
        ),
      );
    },
  ); // Return false if the dialog is dismissed
}

import 'package:almonazim/core/constant/app_routes.dart';
import 'package:almonazim/core/shared/buttons/apply_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

bool _isDialogOpen = false;
void showLoginAgainDialog(BuildContext context) {
  if (_isDialogOpen) return;
  _isDialogOpen = true;
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return PopScope(
          canPop: false,
          child: AlertDialog(
            title: const Text(
              "تسجيل الخروج",
            ),
            content: const Text(
                'لقد تم تسجيل خروجك من التطبيق \nالرجاء إعادة تسجيل الدخول'),
            actions: <Widget>[
              ApplyButton(
                  onPressed: () {
                    Get.back();
                    Get.toNamed(AppRoute.loginScreen);
                  },
                  title: 'تسجيل الدخول'),
            ],
          ));
    },
  );
}

import 'package:almonazim/core/constant/app_links.dart';
import 'package:almonazim/core/device/launch_url.dart';
import 'package:almonazim/core/shared/buttons/apply_button.dart';
import 'package:almonazim/core/shared/buttons/cancel_button.dart';
import 'package:almonazim/view/widget/auth/app_logo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<dynamic> showUserManualVideo(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) {
      return SizedBox(
        height: MediaQuery.of(context).size.height / 3,
        child: AlertDialog(
          title: const Text(
            'فيديو إنشاء حساب جديد!',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: InkWell(
            onTap: () {
              LaunchUrl.launchAnyUrl(AppLinks.introVideoTutorialLink);
            },
            child: AppLogo(),
          ),
          actions: [
            // const ShowAgainCheckBox(noteKey: ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CancelButton(
                  title: "تخطي",
                  onPressed: () {
                    Get.back();
                  },
                ),
                ApplyButton(
                    title: "مشاهدة",
                    onPressed: () {
                      LaunchUrl.launchAnyUrl(AppLinks.introVideoTutorialLink);
                    })
              ],
            )
          ],
        ),
      );
    },
  );
}

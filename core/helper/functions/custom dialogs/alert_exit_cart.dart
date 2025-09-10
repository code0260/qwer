import 'package:almonazim/core/shared/buttons/apply_button.dart';
import 'package:almonazim/core/shared/buttons/cancel_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<bool> alertExitCartScreen() async {
  return await showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return const AlertDialog(
            title: Row(
              children: [
                Text(
                  "⚠",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Text(
                    "تحذير",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Spacer(),
              ],
            ),
            content: Text(
              "هل أنت متأكد أنك تريد مغادرة صفحة السلة؟\nسيتم فقدان جميع بيانات السلة.",
              textAlign: TextAlign.start,
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CancelButton(),
                  ApplyButton(
                    title: "تأكيد",
                  ),
                ],
              ),
              // TextButton(
              //   onPressed: () => Get.back(result: false), // User cancels exit
              //   child: const Text("إلغاء"),
              // ),

              // TextButton(
              //   onPressed: () => Get.back(result: true), // User confirms exit
              //   child: const Text("مغادرة"),
              // ),
            ],
          );
        },
      ) ??
      false; // Return false if the dialog is dismissed
}

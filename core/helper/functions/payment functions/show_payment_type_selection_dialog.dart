import 'package:almonazim/core/constant/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Shows a dialog allowing the user to select a payment type: 'نقدي' (Cash) or 'على الحساب' (On Account).
///
/// Returns a [Future] that resolves to the selected payment type as a [String]
/// (either 'نقدي' or 'على الحساب') when the user makes a choice, or `null` if
/// the dialog is dismissed without a selection.
Future<String?> showPaymentTypeSelectionDialog(BuildContext context) async {
  return await showDialog<String>(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: const Text(
          'اختر طريقة الدفع',
          textAlign: TextAlign.right, // Align title to the right
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        content: Column(
          mainAxisSize:
              MainAxisSize.min, // Make column take minimum vertical space
          children: <Widget>[
            // Option 1: Cash Payment (نقدي)
            ListTile(
              leading:
                  Icon(Icons.money, color: AppColor.green), // Icon for cash
              title: const Text(
                'نقدي',
                textAlign: TextAlign.right, // Align text to the right
                style: TextStyle(fontSize: 16),
              ),
              onTap: () {
                Get.back(result: 'paid'); // Close dialog and return 'نقدي'
              },
            ),
            const Divider(), // Separator
            // Option 2: On Account Payment (على الحساب)
            ListTile(
              leading: const Icon(Icons.credit_card,
                  color: AppColor.primaryColor), // Icon for credit/account
              title: const Text(
                'على الحساب',
                textAlign: TextAlign.right, // Align text to the right
                style: TextStyle(fontSize: 16),
              ),
              onTap: () {
                Get.back(
                    result: 'unpaid'); // Close dialog and return 'على الحساب'
              },
            ),
          ],
        ),
      );
    },
  );
}

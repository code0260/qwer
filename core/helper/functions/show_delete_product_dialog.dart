import 'package:almonazim/core/helper/functions/custom%20dialogs/show_custom_dialog.dart';
import 'package:flutter/material.dart';

void showDeleteDialog(BuildContext context, void Function() onPressed) {
  showCustomActionDialog(
    context,
    "الحذف",
    "حذف هذا العنصر؟",
    onPressed: onPressed,
  );
}

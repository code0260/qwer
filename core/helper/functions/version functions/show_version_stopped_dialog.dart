import 'package:almonazim/view/widget/version/update_version_dialog.dart';
import 'package:flutter/material.dart';

bool _isDialogOpen = false;
void showVersionStoppedDialog(BuildContext context) {
  if (_isDialogOpen) return;
  _isDialogOpen = true;
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return const PopScope(canPop: false, child: UpdateVersionDialog());
    },
  );
}

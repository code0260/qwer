import 'package:almonazim/core/shared/buttons/apply_button.dart';
import 'package:almonazim/data/model/almonazim_data_model.dart';
import 'package:almonazim/view/widget/auth/demo%20account/finish_demo_account_dialog.dart';
import 'package:flutter/material.dart';

bool _isDialogOpen = false;
void showTrialEndDialog(BuildContext context) {
  if (_isDialogOpen) return;
  _isDialogOpen = true;
  showDialog(
    context: context,
    barrierDismissible: false, // prevent dismissing without action
    builder: (context) => AlertDialog(
      title: Text(
        AlmonazimDataModel.instance.freeTrialEndTitle ?? '',
        style: const TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      content: PopScope(
        canPop: false,
        child: Text(
          AlmonazimDataModel.instance.freeTrialEndContent ?? '',
          textAlign: TextAlign.center,
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        ApplyButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => const FinishDemoAccountDialog(),
            );
          },
          title: 'البدء بحساب حقيقي',
        ),
      ],
    ),
  );
}

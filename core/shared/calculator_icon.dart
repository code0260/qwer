import 'package:almonazim/core/constant/app_color.dart';
import 'package:almonazim/core/helper/functions/custom dialogs/show_calculator.dart';
import 'package:flutter/material.dart';

class CalculatorIcon extends StatelessWidget {
  const CalculatorIcon(
      {super.key, this.onCalculated, this.onCalculatorDialogOpened});
  final void Function(double)? onCalculated;
  final void Function()? onCalculatorDialogOpened;

  @override
  Widget build(BuildContext context) {
    bool isOpen = false;

    return FloatingActionButton.small(
        elevation: 0,
        backgroundColor: AppColor.green,
        onPressed: () async {
          if (!isOpen) {
            isOpen = true;
            onCalculatorDialogOpened?.call();
            double? value = await showCalculator(context);
            isOpen = false;
            if (onCalculated != null && value != null) {
              onCalculated!(value);
            }
          }
        },
        child: const Icon(Icons.calculate));
  }
}

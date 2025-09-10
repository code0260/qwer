import 'package:almonazim/core/shared/edit_number.dart';
import 'package:flutter/material.dart';

Future<double?> editNumberDialog(BuildContext context, String mainText,
    IconData iconData, String? defaultValue) {
  return showDialog<double>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          mainText,
          textAlign: TextAlign.center,
        ),
        content: EditNumber(
          mainText: mainText,
          iconData: iconData,
          defaultValue: defaultValue,
        ),
      );
    },
  );
}

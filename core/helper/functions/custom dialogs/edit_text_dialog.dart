import 'package:flutter/material.dart';
import 'package:almonazim/core/shared/edit_Text.dart';

Future<String?> editTextDialog(
    BuildContext context, String mainText, IconData iconData,
    {String? defaultValue}) {
  return showDialog<String>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          mainText,
          textAlign: TextAlign.center,
        ),
        content: EditText(
          mainText: mainText,
          iconData: iconData,
          defaultValue: defaultValue,
        ),
      );
    },
  );
}

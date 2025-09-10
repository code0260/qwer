import 'package:almonazim/core/shared/buttons/apply_button.dart';
import 'package:almonazim/core/shared/buttons/cancel_button.dart';
import 'package:almonazim/core/shared/dorp_down_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<String?> showDaySelectorDialog(BuildContext context,
    {String? initialValue}) {
  return showDialog<String?>(
    context: context,
    builder: (BuildContext context) {
      String? tempSelectedDay = initialValue;
      return AlertDialog(
        title: const Text('اختر يوماً'),
        content: ChooseDropDownButton(
          hint: 'اختر اليوم',
          items: List.generate(
            31,
            (index) {
              var i = (index + 1);
              return 'اليوم ${i.toString().length == 1 ? "0$i" : i}';
            },
          ),
          onChanged: (value) {
            tempSelectedDay = value.substring(6);
          },
        ),
        actions: <Widget>[
          const CancelButton(),
          ApplyButton(
            onPressed: () {
              Get.back(result: tempSelectedDay);
            },
          ),
        ],
      );
    },
  );
}

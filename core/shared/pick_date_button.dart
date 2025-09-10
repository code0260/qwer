import 'package:almonazim/core/constant/app_color.dart';
import 'package:almonazim/core/helper/functions/datetime%20functions/select_date.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PickDateButton extends StatefulWidget {
  final DateTime? initialDate;
  final void Function(DateTime) onGot;
  final String text;
  const PickDateButton({
    super.key,
    this.initialDate,
    required this.text,
    required this.onGot,
  });
  @override
  State<PickDateButton> createState() => _PickDateButtonState();
}

class _PickDateButtonState extends State<PickDateButton> {
  DateTime? dateTime;
  @override
  Widget build(BuildContext context) {
    dateTime ??= widget.initialDate;
    return Row(
      children: [
        Text(
          widget.text,
          style: TextStyle(
            color: AppColor.whiteMainReverse,
            fontWeight: FontWeight.w600,
          ),
        ),
        TextButton(
          child: dateTime == null
              ? const Text(
                  "اختر",
                  style: TextStyle(color: AppColor.primaryColor),
                )
              : Text(
                  DateFormat('yyyy/MM/dd', "en").format(dateTime!),
                  style: const TextStyle(color: AppColor.primaryColor),
                ),
          onPressed: () async {
            DateTime? picked = await selectDate(context, dateTime);
            if (picked != null) {
              setState(() {
                dateTime = picked;
                widget.onGot(picked);
              });
            }
          },
        ),
      ],
    );
  }
}

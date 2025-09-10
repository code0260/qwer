import 'package:almonazim/core/constant/app_color.dart';
import 'package:almonazim/core/helper/functions/datetime%20functions/select_date.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChooseDateField extends StatefulWidget {
  const ChooseDateField(
      {super.key,
      required this.text,
      required this.initialDate,
      required this.onDateChanged});
  final DateTime? initialDate;
  final String? text;
  final void Function(DateTime) onDateChanged;

  @override
  State<ChooseDateField> createState() => _ChooseDateFieldState();
}

class _ChooseDateFieldState extends State<ChooseDateField> {
  TextEditingController invoiceDataController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (widget.initialDate != null && invoiceDataController.text.isEmpty) {
      invoiceDataController.text =
          "تاريخ ${widget.text}:  ${DateFormat('yyyy/MM/dd', "en").format(widget.initialDate!)}";
    }
    return TextField(
      controller: invoiceDataController,
      readOnly: true,
      onTap: () async {
        DateTime? picked = await selectDate(context, widget.initialDate);
        if (picked != null) {
          setState(() {
            widget.onDateChanged(picked);
            invoiceDataController.text =
                'تاريخ ${widget.text}:  ${DateFormat('yyyy/MM/dd', "en").format(picked)}';
          });
        }
      },
      decoration: InputDecoration(
        hintText: 'اختر تاريخ ${widget.text}',
        suffixIcon: Icon(
          Icons.calendar_today,
          color: AppColor.whiteMainReverse,
        ),
        border: const OutlineInputBorder(), // إضافة حدود لحقل النص
      ),
    );
  }
}

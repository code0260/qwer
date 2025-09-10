import 'package:almonazim/core/constant/app_color.dart';
import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/core/helper/functions/invoice%20functions/translate_invoice_type.dart';
import 'package:flutter/material.dart';

class ChooseInvoicesType extends StatefulWidget {
  const ChooseInvoicesType(
      {super.key,
      this.defaultInvoicesType,
      required this.onChanged,
      required this.typesToChoose});
  final InvoiceType? defaultInvoicesType;
  final List<InvoiceType> typesToChoose;
  final void Function(InvoiceType) onChanged;
  @override
  State<ChooseInvoicesType> createState() => _ChooseInvoicesTypeState();
}

class _ChooseInvoicesTypeState extends State<ChooseInvoicesType> {
  InvoiceType? selectedInvoicesType;
  @override
  Widget build(BuildContext context) {
    if (selectedInvoicesType == null && widget.defaultInvoicesType != null) {
      selectedInvoicesType = widget.defaultInvoicesType;
    }
    return DropdownButtonFormField<InvoiceType>(
      dropdownColor: AppColor.whiteBlackSame,
      value: selectedInvoicesType,
      items: widget.typesToChoose.map((InvoiceType type) {
        return DropdownMenuItem<InvoiceType>(
          value: type,
          child: Text(translateToArInvoiceType(type)),
        );
      }).toList(),
      onChanged: (InvoiceType? value) {
        setState(() {
          selectedInvoicesType = value;
          if (value != null) {
            widget.onChanged(value);
          }
        });
      },
      decoration: const InputDecoration(labelText: 'نوع الفاتورة'),
    );
  }
}

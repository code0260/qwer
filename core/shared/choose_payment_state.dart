import 'package:almonazim/core/constant/app_color.dart';
import 'package:almonazim/core/helper/functions/payment%20functions/translate_payment_state.dart';
import 'package:flutter/material.dart';

class ChoosePaymentState extends StatefulWidget {
  const ChoosePaymentState(
      {super.key,
      required this.defaultPaymentState,
      this.paymentStates = const ["مدفوع", 'غير مدفوع', 'مدفوع جزئياً', "الكل"],
      required this.onChanged});
  final String? defaultPaymentState;
  final void Function(String) onChanged;
  final List<String> paymentStates;
  @override
  State<ChoosePaymentState> createState() => _ChoosePaymentStateState();
}

class _ChoosePaymentStateState extends State<ChoosePaymentState> {
  String? selectedPaymentState;
  @override
  Widget build(BuildContext context) {
    selectedPaymentState =
        translateToArPaymentState(widget.defaultPaymentState);
    return DropdownButtonFormField<String>(
      dropdownColor: AppColor.whiteBlackSame,
      value: selectedPaymentState,
      items: widget.paymentStates.map((String state) {
        return DropdownMenuItem<String>(
          value: state,
          child: Text(state),
        );
      }).toList(),
      onChanged: (String? value) {
        setState(() {
          selectedPaymentState = value ?? "الكل";
          if (value != null) {
            widget.onChanged(value);
          }
        });
      },
      decoration: const InputDecoration(labelText: 'حالة الدفع'),
    );
  }
}

import 'package:almonazim/core/shared/one_check_box.dart';
import 'package:flutter/material.dart';

class OneCheckBoxRow extends StatelessWidget {
  const OneCheckBoxRow(
      {super.key,
      required this.text,
      required this.onChanged,
      this.initial = false});
  final String text;
  final void Function(bool) onChanged;
  final bool initial;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(text),
        OneCheckBox(initial: initial, onChanged: onChanged)
      ],
    );
  }
}

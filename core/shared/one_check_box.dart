import 'package:flutter/material.dart';

class OneCheckBox extends StatefulWidget {
  const OneCheckBox({super.key, required this.onChanged, this.initial = false});
  final void Function(bool) onChanged;
  final bool initial;
  @override
  State<OneCheckBox> createState() => _OneCheckBoxState();
}

class _OneCheckBoxState extends State<OneCheckBox> {
  bool? currentValue;
  @override
  Widget build(BuildContext context) {
    currentValue ??= widget.initial;
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Checkbox(
        value: currentValue,
        onChanged: (value) {
          if (value != null) {
            setState(() {
              currentValue = value;
            });
            widget.onChanged(value);
          }
        },
      ),
    );
  }
}

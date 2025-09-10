import 'package:almonazim/core/constant/app_color.dart';
import 'package:flutter/material.dart';

class ChooseDropDownButton extends StatefulWidget {
  final String? defaultValue;
  final List<String> items;
  final String? hint;
  final bool hasAll;
  final bool readOnly;
  final void Function(String) onChanged;
  const ChooseDropDownButton(
      {super.key,
      required this.items,
      this.hint,
      this.readOnly = false,
      this.defaultValue,
      this.hasAll = true,
      required this.onChanged});
  @override
  State<ChooseDropDownButton> createState() => _ChooseDropDownButtonState();
}

class _ChooseDropDownButtonState extends State<ChooseDropDownButton> {
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    List<String> items = [];
    items.addAll(widget.items);
    if (!widget.hasAll) {
      items.remove('الكل');
    }
    if (widget.defaultValue != null && // -1
            selectedValue == null && // -2
            items.contains(widget.defaultValue) // -3
        ) {
      selectedValue = widget.defaultValue;
    }
    return DropdownButton<String>(
      value: selectedValue,
      iconEnabledColor: AppColor.whiteMainReverse,
      dropdownColor: AppColor.whiteDarkSame,
      borderRadius: BorderRadius.circular(15),
      hint: widget.hint == null ? null : Text(widget.hint!),
      items: items.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: widget.readOnly
          ? null
          : (String? value) {
              if (value != null) {
                setState(() {
                  selectedValue = value;
                  widget.onChanged(value);
                });
              }
            },
    );
  }
}

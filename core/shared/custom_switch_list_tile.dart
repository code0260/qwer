import 'package:almonazim/core/constant/app_color.dart';
import 'package:flutter/material.dart';

class CustomSwitchListTile extends StatefulWidget {
  const CustomSwitchListTile(
      {super.key,
      this.defaultValue = false,
      this.readOnly = false,
      required this.onChanged,
      required this.title});
  final void Function(bool) onChanged;
  final String title;
  final bool defaultValue;
  final bool readOnly;
  @override
  State<CustomSwitchListTile> createState() => _CustomSwitchListTileState();
}

class _CustomSwitchListTileState extends State<CustomSwitchListTile> {
  bool? currentValue; // Toggle for offline/online mode

  @override
  Widget build(BuildContext context) {
    currentValue ??= widget.defaultValue;
    return SwitchListTile.adaptive(
      activeColor: AppColor.primaryColor,
      title: Text(widget.title),
      value: currentValue!,
      onChanged: (value) {
        if (widget.readOnly) {
          widget.onChanged(value);
          return;
        }
        setState(() {
          currentValue = value;
          widget.onChanged(value);
        });
        // Save the preference or perform an action based on value
      },
    );
  }
}

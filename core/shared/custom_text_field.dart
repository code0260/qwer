import 'package:almonazim/core/constant/app_color.dart';
import 'package:almonazim/core/extension/string_extensions.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String? hintText;
  final bool autoFocus;
  final int? maxLines;
  final String? label;
  final bool readOnly;
  final Color focusedBorderColor;
  final Color cursorColor;
  final Color? iconColor;
  final int? maxLength;
  final IconData? iconData;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final void Function()? onPressedIcon;
  final bool obscureText;
  final Widget? suffix;
  final void Function(String)? onChanged;
  final void Function(bool)? onFocusChanged;
  final void Function(String?)? onSaved;
  final TextDirection? textDirection;
  final bool isPhoneNumber;
  const CustomTextField(
      {super.key,
      this.hintText,
      this.label,
      this.onFocusChanged,
      this.isPhoneNumber = false,
      this.iconData,
      this.maxLength,
      this.onChanged,
      this.maxLines,
      this.suffix,
      required this.controller,
      required this.validator,
      required this.keyboardType,
      this.obscureText = false,
      this.iconColor,
      this.onPressedIcon,
      this.textDirection,
      this.readOnly = false,
      this.focusedBorderColor = AppColor.primaryColor,
      this.cursorColor = AppColor.primaryColor,
      this.autoFocus = false,
      this.onSaved});
  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool? obscureText;
  final FocusNode _myFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: _myFocusNode,
      onChanged: (value) {
        String v = formatNumber(value);
        if (widget.onChanged != null) {
          widget.onChanged!(v);
        }
      },
      readOnly: widget.readOnly,
      maxLines: widget.maxLines,
      maxLength: widget.maxLength,
      autofocus: widget.autoFocus,
      onSaved: widget.onSaved,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: widget.validator,
      keyboardType: widget.keyboardType,
      controller: widget.controller,
      obscureText: obscureText!,
      cursorColor: widget.cursorColor,
      textDirection: widget.textDirection,
      decoration: InputDecoration(
          fillColor: AppColor.textFieldFillColor,
          filled: true,
          hintText: widget.hintText,
          hintStyle: TextStyle(
              fontSize: 12, color: AppColor.whiteMainReverse.withAlpha(200)),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          label: widget.label == null
              ? null
              : Container(
                  margin: const EdgeInsets.symmetric(horizontal: 9),
                  child: Text(
                    widget.label!,
                    // style: const TextStyle(color: AppColor.primaryColor),
                  )),
          suffix: widget.suffix,
          suffixIcon: widget.iconData == null
              ? null
              : IconButton(
                  onPressed: widget.onPressedIcon ??
                      (widget.iconData != Icons.visibility
                          ? null
                          : () {
                              setState(() {
                                obscureText = !obscureText!;
                              });
                            }),
                  icon: Icon(
                    widget.iconData,
                    color: widget.iconColor ?? AppColor.whiteMainReverse,
                  )),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide:
                  BorderSide(color: widget.focusedBorderColor, width: 2)),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 5)),
    );
  }

  String formatNumber(String value) {
    String v = value;
    if (widget.keyboardType == TextInputType.number &&
        widget.isPhoneNumber == false) {
      v = v.fromFormattedNumber().toFormattedNumber();
      widget.controller.text = v;
    }
    return v;
  }

  @override
  void initState() {
    super.initState();
    if (widget.onFocusChanged != null) {
      _myFocusNode.addListener(
        focusChangedLIstener,
      );
    }
    obscureText = obscureText ?? widget.obscureText;
    if (widget.controller.text.isNotEmpty) {
      formatNumber(widget.controller.text);
    }
    if (widget.autoFocus) {
      widget.controller.selection = TextSelection(
          baseOffset: 0, extentOffset: widget.controller.text.length);
    }
  }

  void focusChangedLIstener() {
    widget.onFocusChanged!(_myFocusNode.hasFocus);
  }

  @override
  void dispose() {
    if (widget.onFocusChanged != null) {
      _myFocusNode.removeListener(
        focusChangedLIstener,
      );
      _myFocusNode.dispose();
    }
    super.dispose();
  }
}

import 'package:almonazim/core/constant/app_color.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Color? color;
  final TextStyle? style;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry? padding;
  final bool isDisabled;
  final double? shadow;
  const CustomButton({
    super.key,
    required this.title,
    this.color = AppColor.primaryColor,
    required this.onPressed,
    this.padding,
    this.isDisabled = false,
    this.style,
    this.shadow,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 16),
          backgroundColor: color,
          // foregroundColor: const Color.fromARGB(255, 255, 255, 255),
          side: BorderSide.none,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          elevation: shadow ?? 0,
        ),
        onPressed: isDisabled ? null : onPressed,
        child: Text(title, style: style),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CardButton extends StatelessWidget {
  final void Function()? onTap;
  final Color? backgroundColor;
  final Color? textColor;
  final String buttonText;
  final double? textSize;
  const CardButton(
      {super.key,
      this.onTap,
      this.textColor,
      this.textSize,
      required this.buttonText,
      this.backgroundColor});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(25),
      child: Card(
        elevation: 0.2,
        color: backgroundColor,
        margin: const EdgeInsets.all(4.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 4),
          child: Text(
            buttonText,
            style: TextStyle(
                fontSize: textSize,
                color: textColor,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

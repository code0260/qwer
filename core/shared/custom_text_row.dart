import 'package:flutter/material.dart';

class CustomTextRow extends StatelessWidget {
  const CustomTextRow({
    super.key,
    required this.title,
    this.mainAxisAlignment = MainAxisAlignment.start,
    required this.value,
  });
  final String title;
  final String value;
  final MainAxisAlignment mainAxisAlignment;
//24169143628
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          value,
        ),
      ],
    );
  }
}

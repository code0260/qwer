import 'dart:math';

import 'package:flutter/material.dart';

class CustomDiscountClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final radius = size.width / 2;
    const numberOfPoints = 5; // Number of star points

    path.moveTo(centerX + radius * cos(0), centerY + radius * sin(0));

    for (double i = 0; i < 2 * pi; i += (2 * pi) / numberOfPoints) {
      path.lineTo(centerX + radius * cos(i), centerY + radius * sin(i));
    }

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

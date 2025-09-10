import 'dart:math';

import 'package:almonazim/core/extension/string_extensions.dart';

extension NumberExtensions on double {
  bool get hasFractionalDigits {
    // Define a regular expression pattern to match any digit that is not zero
    try {
      RegExp regex = RegExp(r'[1-9]');

      List<String> parts = toString().split('.');

      // Check if the split operation produces two parts (before and after the decimal point)
      if (parts.length == 2) {
        // Use allMatches to find all non-zero digits in the text
        Iterable<Match> matches = regex.allMatches(toString().split('.')[1]);
        return matches.isNotEmpty;
      } else {
        return false;
      }
    } on Exception catch (_) {
      return false;
    }

    // If no non-zero digits are found, the string contains only zeros
  }

  double get removeDigitsIfZero {
    List<String> parts = toString().split('.');
    if (parts.last.toDouble() != 0) {
      return parts.first.toDouble();
    } else {
      return this;
    }
  }

  double roundToNearest(int precision) {
    double factor = pow(10, precision.abs()).toDouble();
    num value = this;
    if (precision == 10) {
      return value.toDouble();
    }
    if (precision < 0) {
      // For negative precision, round to decimal places
      value = (this * factor).round() / factor;
    } else {
      // For positive precision, round to powers of 10
      value = ((this / factor).round() * factor);
    }
    return value.toDouble();
  }
}

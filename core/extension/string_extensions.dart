import 'package:almonazim/core/helper/functions/datetime%20functions/to_server_datetime.dart';

extension NumberExtensions on String {
  int toInt() {
    return int.parse(this);
  }

  String fromFormattedNumber() {
    return replaceAll(',', '');
  }

  String toFormattedNumber() {
    List<String> parts = toString().split('.');
    String integerPart = parts[0]; // Get the integer part
    String decimalPart = parts.length > 1 ? '.${parts[1]}' : '';
    // Add commas to the integer part
    final formatter = RegExp(r'(\d)(?=(\d{3})+(?!\d))');
    String formattedInteger =
        integerPart.replaceAllMapped(formatter, (match) => '${match[1]},');

    // Combine the formatted integer part with the decimal part
    return formattedInteger + decimalPart;
  }

  int? tryToInt() {
    return int.tryParse(this);
  }

  double toDouble() {
    String value = replaceAll(",", '');
    if (value.endsWith(".")) {
      value = "${value}0";
    }
    return double.parse(value);
  }

  bool get hasFractionalDigits {
    // Define a regular expression pattern to match any digit that is not zero
    try {
      RegExp regex = RegExp(r'[1-9]');
      List<String> parts = split('.');

      // Check if the split operation produces two parts (before and after the decimal point)
      if (parts.length == 2) {
        // Use allMatches to find all non-zero digits in the text
        Iterable<Match> matches = regex.allMatches(split('.')[1]);
        return matches.isNotEmpty;
      } else {
        return false;
      }
    } on Exception catch (_) {
      return false;
    }

    // If no non-zero digits are found, the string contains only zeros
  }

  String toStringWithNoDigitsIFZerosOnly(int numberDigits) {
    return toDouble().toStringAsFixed(hasFractionalDigits ? numberDigits : 0);
  }

  bool get isInt {
    var value = int.tryParse(this);
    if (value != null) {
      return true;
    } else {
      return false;
    }
  }

  String? toServerDateTime() {
    return toServerTime(this);
  }
}

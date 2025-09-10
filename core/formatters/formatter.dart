import 'package:almonazim/core/extension/double_extension.dart';
import 'package:almonazim/data.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Formatter {
  static String formatDate(DateTime? date) {
    date ??= DateTime.now();
    return DateFormat('dd-MMM-yyyy')
        .format(date); // Customize the date format as needed
  }

  static String formatAmount(num amount,
      {int? currencyId, bool showSymbol = true}) {
    return formatAmountWithCommas(amount,
        currencyId: currencyId, showSymbol: showSymbol);
  }

  static String formatAmountWithCommas(num amount,
      {int? currencyId, bool showSymbol = true}) {
    // Split the number into integer and decimal parts
    var currencyModel = currencies.firstWhereOrNull(
        (element) => element.businessCurrencyId == currencyId);
    int? currencyFactor = currencyModel?.businessCurrencyNearFactor;
    var baseCurrencyModel = currencies
        .firstWhereOrNull((element) => element.businessCurrencyIsBase == 1);
    int nearBaseFactor = baseCurrencyModel?.businessCurrencyNearFactor ?? -2;
    List<String> parts = amount
        .toDouble()
        .roundToNearest(currencyFactor ?? nearBaseFactor)
        .toString()
        .split('.');
    String integerPart = parts[0]; // Get the integer part
    String decimalPart = parts.length > 1 && parts[1] != '0'
        ? '.${parts[1]}'
        : ''; // Get the decimal part, if any

    // Add commas to the integer part
    final formatter = RegExp(r'(\d)(?=(\d{3})+(?!\d))');
    String formattedInteger =
        integerPart.replaceAllMapped(formatter, (match) => '${match[1]},');

    // Combine the formatted integer part with the decimal part
    if (showSymbol) {
      return "$formattedInteger$decimalPart ${currencyModel?.currenciesSymbol ?? baseCurrencyModel?.currenciesSymbol}";
    } else {
      return formattedInteger + decimalPart;
    }
  }

  static String formatNumberWithCommas(
    num amount,
  ) {
    List<String> parts = amount.toDouble().toString().split('.');
    String integerPart = parts[0]; // Get the integer part
    String decimalPart = parts.length > 1 && parts[1] != '0'
        ? '.${parts[1]}'
        : ''; // Get the decimal part, if any

    // Add commas to the integer part
    final formatter = RegExp(r'(\d)(?=(\d{3})+(?!\d))');
    String formattedInteger =
        integerPart.replaceAllMapped(formatter, (match) => '${match[1]},');

    // Combine the formatted integer part with the decimal part
    return formattedInteger + decimalPart;
  }

  static String formatCurrency(double amount) {
    return NumberFormat.currency(locale: 'en_US', symbol: '\$')
        .format(amount); // Customize the currency locale and symbol as needed
  }

  static String formatAmountAsShort(num amount) {
    if (amount >= 1000000000) {
      return "${(amount / 1000000000).roundToNearest(-2)}B";
    } else if (amount >= 1000000) {
      return "${(amount / 1000000).roundToNearest(-2)}M";
    } else if (amount >= 1000) {
      return "${((amount / 1000).roundToNearest(-2))}k";
    }
    return "$amount";
  }

  static String formatPhoneNumber(String phoneNumber) {
    // Assuming a 10-digit US phone number format: (123) 456-7890
    if (phoneNumber.length == 10) {
      return '(${phoneNumber.substring(0, 3)}) ${phoneNumber.substring(3, 6)} ${phoneNumber.substring(6)}';
    } else if (phoneNumber.length == 11) {
      return '(${phoneNumber.substring(0, 4)}) ${phoneNumber.substring(4, 7)} ${phoneNumber.substring(7)}';
    }
    // Add more custom phone number formatting logic for differentPrepaidExpense formats if needed.
    return phoneNumber;
  }

  // Not fully tested.
  static String internationalFormatPhoneNumber(String phoneNumber) {
    // Remove any non-digit characters from the phone number
    var digitsOnly = phoneNumber.replaceAll(RegExp(r'\D'), '');

    // Extract the country code from the digitsOnly
    String countryCode = '+${digitsOnly.substring(0, 2)}';
    digitsOnly = digitsOnly.substring(2);

    // Add the remaining digits with proper formatting
    final formattedNumber = StringBuffer();
    formattedNumber.write('($countryCode) ');

    int i = 0;
    while (i < digitsOnly.length) {
      int groupLength = 2;
      if (i == 0 && countryCode == '+1') {
        groupLength = 3;
      }

      int end = i + groupLength;
      formattedNumber.write(digitsOnly.substring(i, end));

      if (end < digitsOnly.length) {
        formattedNumber.write(' ');
      }
      i = end;
    }

    return formattedNumber.toString();
  }
}

/*
*
*
* */

// --------------------------------------------------------------------------
// Functions for translating strings to the enum.
// --------------------------------------------------------------------------

import 'package:almonazim/core/constant/app_enums.dart';

/// Translates an Arabic string to its corresponding PrinterConnectionType enum value.
/// Defaults to [PrinterConnectionType.usb] if the string is not matched.
PrinterConnectionType translateToEnumPrinterConnectionTypeFromString(
    String type) {
  switch (type) {
    case "بلوتوث Bluetooth":
      return PrinterConnectionType.bluetooth;
    case "كابل USB":
      return PrinterConnectionType.usb;
    default:
      return PrinterConnectionType.bluetooth;
  }
}

/// Translates an English string to its corresponding PrinterConnectionType enum value.
/// Defaults to [PrinterConnectionType.usb] if the string is not matched.
PrinterConnectionType translateToEnumPrinterConnectionTypeFromEnString(
    String type) {
  switch (type) {
    case "bluetooth":
      return PrinterConnectionType.bluetooth;
    case "usb":
      return PrinterConnectionType.usb;
    default:
      return PrinterConnectionType.bluetooth;
  }
}

// --------------------------------------------------------------------------
// Functions for translating the enum or strings to an Arabic string.
// --------------------------------------------------------------------------

/// Translates a PrinterConnectionType enum value to its corresponding Arabic string.
/// Defaults to "كابل USB" if the enum value is null or not matched.
String translateToArPrinterConnectionType(PrinterConnectionType? type) {
  switch (type) {
    case PrinterConnectionType.bluetooth:
      return "بلوتوث Bluetooth";
    case PrinterConnectionType.usb:
      return "كابل USB";
    default:
      return "بلوتوث Bluetooth";
  }
}

/// Translates an English string representation of a connection type to an Arabic string.
/// Defaults to "كابل USB" if the string is not matched.
String translateToArPrinterConnectionTypeFromString(String type) {
  switch (type) {
    case "bluetooth":
      return "بلوتوث Bluetooth";
    case "usb":
      return "كابل USB";
    default:
      return "بلوتوث Bluetooth";
  }
}

// --------------------------------------------------------------------------
// Functions for translating an Arabic string to an English string.
// --------------------------------------------------------------------------

/// Translates an Arabic string representation of a connection type to an English string.
/// Defaults to "usb" if the string is not matched.
String translateToEnPrinterConnectionTypeFromString(String type) {
  switch (type) {
    case "بلوتوث Bluetooth":
      return "bluetooth";
    case "كابل USB":
      return "usb";
    default:
      return "bluetooth";
  }
}

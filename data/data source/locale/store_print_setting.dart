import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/core/extension/string_extensions.dart';
import 'package:almonazim/core/helper/functions/print%20functions/translate_printer_connection_type.dart';
import 'package:almonazim/core/helper/pref_storage.dart';

class StorePrintSetting {
  StorePrintSetting._();
  //$ paper size
  static Future<void> setPaperSize(String paperSize) async {
    await PrefStorage.set("paperSize", paperSize);
  }

  static PrinterConnectionType getConnectionType() {
    String connectionType = PrefStorage.get('connectionType') ?? '';
    return translateToEnumPrinterConnectionTypeFromEnString(connectionType);
  }

//$ connection type
  static Future<void> setConnectionType(
      PrinterConnectionType connectionType) async {
    await PrefStorage.set("connectionType", connectionType.name);
  }

  static String getPaperSize() {
    String paperSize = PrefStorage.get('paperSize') ?? 'roll80';
    return paperSize;
  }

  //$ number of copies
  static Future<void> setNumberCopies(String numberCopies) async {
    await PrefStorage.set("numberCopies", numberCopies);
  }

  static int? getNumberCopies() {
    String? numberCopies = PrefStorage.get('numberCopies');
    return numberCopies?.toInt();
  }

  //$ default printer
  static Future<void> setDefaultPrinter(String defaultPrinter) async {
    await PrefStorage.set("defaultPrinter", defaultPrinter);
  }

  static String? getDefaultPrinter() {
    String? defaultPrinter = PrefStorage.get('defaultPrinter');
    return defaultPrinter;
  }
}

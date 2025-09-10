import 'package:almonazim/core/helper/functions/invoice%20functions/translate_invoice_type.dart';
import 'package:almonazim/core/helper/pref_storage.dart';

class StoreInvoiceNumber {
  StoreInvoiceNumber._();
  static Future<void> setLatestInvoiceNumber(
      String invoiceType, String invoiceNumber) async {
    await PrefStorage.set("invoiceNumber/$invoiceType", invoiceNumber);
  }

  static String? getLatestInvoiceNumber(String invoiceType) {
    String? invoiceNumber = PrefStorage.get('invoiceNumber/$invoiceType');
    return invoiceNumber;
  }

  static String getAfterLatestInvoiceNumber(String invoiceType) {
    // Retrieve the latest invoice number from storage
    String? latestInvoiceNumber = PrefStorage.get('invoiceNumber/$invoiceType');

    if (latestInvoiceNumber != null) {
      // Split the invoice number by '/' to isolate the numeric part
      List<String> parts = latestInvoiceNumber.split('/');

      if (parts.length == 2) {
        String prefix = parts[0]; // e.g., "شراء"
        int invoiceNum = int.tryParse(parts[1]) ?? 0; // e.g., 1234

        // Increment the numeric part by 1
        invoiceNum += 1;

        // Return the new invoice number in the same format
        return '$prefix/$invoiceNum';
      }
    }

    // Return null if the latest invoice number is not available or invalid
    return "${translateToArInvoiceTypeFromString(invoiceType)}/1";
  }
}

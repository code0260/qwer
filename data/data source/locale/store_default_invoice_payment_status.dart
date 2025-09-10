import 'package:almonazim/core/helper/pref_storage.dart';

class StoreDefaultInvoicePaymentStatus {
  StoreDefaultInvoicePaymentStatus._();
  static Future<void> setDefaultInvoicePaymentStatus(
      String defaultInvoicePaymentStatus) async {
    await PrefStorage.set(
        "defaultInvoicePaymentStatus", defaultInvoicePaymentStatus);
  }

  static String? getDefaultInvoicePaymentStatus() {
    String? defaultInvoicePaymentStatus =
        PrefStorage.get('defaultInvoicePaymentStatus');
    return defaultInvoicePaymentStatus;
  }
}

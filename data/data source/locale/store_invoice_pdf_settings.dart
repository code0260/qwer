import 'dart:convert';

import 'package:almonazim/core/helper/pref_storage.dart';
import 'package:almonazim/data/model/invoice%20models/invoice_pdf_settings_model.dart';

class StoreInvoicePdfSettings {
  StoreInvoicePdfSettings._();

  /// Stores the invoice PDF settings as a JSON string.
  static Future<void> setInvoicePdfSettings(
      InvoicePdfSettingsModel settings) async {
    String jsonData = jsonEncode(settings.toJson());
    await PrefStorage.set("invoicePdfSettings", jsonData);
  }

  /// Retrieves the invoice PDF settings as an [InvoicePdfSettingsModel].
  static InvoicePdfSettingsModel? getInvoicePdfSettings() {
    String? jsonData = PrefStorage.get("invoicePdfSettings");
    if (jsonData == null || jsonData.isEmpty) return null;
    Map<String, dynamic> map = jsonDecode(jsonData);
    return InvoicePdfSettingsModel.fromJson(map);
  }
}

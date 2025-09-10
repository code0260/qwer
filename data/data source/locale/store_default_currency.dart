import 'package:almonazim/core/extension/string_extensions.dart';
import 'package:almonazim/core/helper/pref_storage.dart';

class StoreDefaultCurrency {
  StoreDefaultCurrency._();

  static Future<void> setDefaultCurrency(
      String invoiceType, int defaultCurrency) async {
    await PrefStorage.set(
        "defaultCurrency/$invoiceType", defaultCurrency.toString());
  }

  static int? getDefaultCurrency(String invoiceType) {
    String? defaultCurrency = PrefStorage.get('defaultCurrency/$invoiceType');
    return defaultCurrency?.toInt();
  }
}

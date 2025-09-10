import 'package:almonazim/core/extension/string_extensions.dart';
import 'package:almonazim/core/helper/pref_storage.dart';

class StoreCountInvoice {
  StoreCountInvoice._();
  static Future<void> setCountInvoice(String countInvoice) async {
    await PrefStorage.set("countInvoice", countInvoice);
  }

  static int getCountInvoice() {
    String? countInvoice = PrefStorage.get('countInvoice');
    return countInvoice!.toInt();
  }
}

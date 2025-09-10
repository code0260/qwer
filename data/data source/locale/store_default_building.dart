import 'package:almonazim/core/extension/string_extensions.dart';
import 'package:almonazim/core/helper/pref_storage.dart';

class StoreDefaultBuilding {
  StoreDefaultBuilding._();
  static Future<void> setDefaultBuilding(
      String invoiceType, String defaultBuilding) async {
    await PrefStorage.set("defaultBuilding/$invoiceType", defaultBuilding);
  }

  static int? getDefaultBuilding(String invoiceType) {
    String? defaultBuilding = PrefStorage.get('defaultBuilding/$invoiceType');
    return defaultBuilding?.toInt();
  }
}

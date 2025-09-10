import 'package:almonazim/core/extension/string_extensions.dart';
import 'package:almonazim/core/helper/pref_storage.dart';

class StoreDefaultClient {
  StoreDefaultClient._();

  static Future<void> setDefaultClient(
      String clientType, int defaultClient) async {
    await PrefStorage.set(
        "defaultClient/$clientType", defaultClient.toString());
  }

  static int? getDefaultClient(String clientType) {
    String? defaultClient = PrefStorage.get('defaultClient/$clientType');
    return defaultClient?.toInt();
  }
}

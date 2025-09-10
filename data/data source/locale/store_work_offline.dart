import 'package:almonazim/core/helper/pref_storage.dart';

class StoreWorkOffline {
  StoreWorkOffline._();
  static Future<void> setWorkOffline(bool workOffline) async {
    await PrefStorage.setBool("workOffline", workOffline);
  }

  static bool getWorkOffline() {
    bool? workOffline = PrefStorage.getBool('workOffline');
    return workOffline ?? false;
  }
}

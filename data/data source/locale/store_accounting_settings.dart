import 'package:almonazim/core/helper/pref_storage.dart';

class StoreAccountingSettings {
  StoreAccountingSettings._();

  static Future<void> setDepreciationActivity(bool depreciationActivity) async {
    await PrefStorage.setBool("depreciationActivity", depreciationActivity);
  }

  static bool getDepreciationActivity() {
    bool? depreciationActivity = PrefStorage.getBool('depreciationActivity');
    return depreciationActivity ?? false;
  }

  static Future<void> setDoubtfulDebtActivity(bool doubtfulDebtActivity) async {
    await PrefStorage.setBool("doubtfulDebtActivity", doubtfulDebtActivity);
  }

  static bool getDoubtfulDebtActivity() {
    bool? doubtfulDebtActivity = PrefStorage.getBool('doubtfulDebtActivity');
    return doubtfulDebtActivity ?? false;
  }
}

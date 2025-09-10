import 'package:almonazim/core/helper/pref_storage.dart';

class StoreStep {
  StoreStep._();
  static Future<void> setStep(String step) async {
    await PrefStorage.set("step", step);
  }

  static String? getStep() {
    String? step = PrefStorage.get('step');
    return step;
  }
}

import 'dart:convert';

import 'package:almonazim/core/helper/pref_storage.dart';
import 'package:almonazim/data/model/almonazim_data_model.dart';

class StoreAlmonazimData {
  StoreAlmonazimData._();

  static Future<void> setAlmonazimData(AlmonazimDataModel almonazimData) async {
    await PrefStorage.set(
        "almonazimDataModel", jsonEncode(almonazimData.toJson()));
    AlmonazimDataModel.init();
  }

  static AlmonazimDataModel? getAlmonazimData() {
    String? jsonString = PrefStorage.get('almonazimDataModel');
    if (jsonString != null) {
      AlmonazimDataModel? almonazimData =
          AlmonazimDataModel.fromJson(jsonDecode(jsonString));
      return almonazimData;
    }
    return null;
  }
}

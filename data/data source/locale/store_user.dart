import 'dart:convert';

import 'package:almonazim/core/helper/pref_storage.dart';
import 'package:almonazim/data/model/user%20models/store_user_model.dart';

class StoreUser {
  StoreUser._();
  static Future<void> setUser(StoreUserModel user) async {
    await PrefStorage.set("userModel", jsonEncode(user.toJson()));
    StoreUserModel.init();
  }

  static StoreUserModel? getUser() {
    String? jsonString = PrefStorage.get('userModel');
    if (jsonString != null) {
      StoreUserModel? user = StoreUserModel.fromJson(jsonDecode(jsonString));
      return user;
    }
    return null;
  }
}

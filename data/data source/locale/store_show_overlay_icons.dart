import 'package:almonazim/core/helper/pref_storage.dart';

class StoreShowOverlayIcons {
  StoreShowOverlayIcons._();
  static Future<void> setShowOverlayIcons(bool showOverlayIcons) async {
    await PrefStorage.setBool("showOverlayIcons", showOverlayIcons);
  }

  static bool? getShowOverlayIcons() {
    bool? showOverlayIcons = PrefStorage.getBool('showOverlayIcons');
    return showOverlayIcons;
  }
}

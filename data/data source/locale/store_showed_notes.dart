import 'package:almonazim/core/helper/pref_storage.dart';

class StoreShowedNotes {
  StoreShowedNotes._();

  static Future<void> setAsShowedNote(String noteKey) async {
    await PrefStorage.set(noteKey, "1");
  }

  static Future<void> setAsNotShowedNote(String noteKey) async {
    await PrefStorage.set(noteKey, "0");
  }

  static bool isShowedNote(String noteKey) {
    String? note = PrefStorage.get(noteKey);
    if (note == "1") {
      return true;
    } else {
      return false;
    }
  }
//   static Future<bool> isShowedNote(String noteKey) async {
//   String? note = await PrefStorage.get(noteKey);
//   return note == "1";
// }
}

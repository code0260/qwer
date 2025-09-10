import 'package:almonazim/core/helper/pref_storage.dart';

class StoreInsertDateSteps {
  StoreInsertDateSteps._();

  static Future<void> addStep(String step) async {
    List<String> list = getDoneSteps() ?? [];
    list.add(step);
    await setDoneSteps(list);
  }

  static Future<void> removeStep(String step) async {
    List<String> list = getDoneSteps() ?? [];
    list.remove(step);
    await setDoneSteps(list);
  }

  static List<String>? getDoneSteps() {
    List<String>? step = PrefStorage.getStringList('done_insert_steps');
    return step;
  }

  static Future<void> setDoneSteps(List<String> steps) async {
    await PrefStorage.setStringList("done_insert_steps", steps);
  }

  static bool isDoneStep(String step) {
    List<String> list = getDoneSteps() ?? [];
    return list.contains(step);
  }
}

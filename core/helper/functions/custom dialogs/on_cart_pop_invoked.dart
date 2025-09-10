import 'package:almonazim/core/helper/functions/custom%20dialogs/alert_exit_cart.dart';
import 'package:get/get.dart';

void onCartPopInvoked(bool didPop, List<dynamic> list) async {
  if (didPop) {
    return; // If the pop was already handled, do nothing
  }
  if (list.isEmpty) {
    Get.back();
  } else {
    bool shouldExit = await alertExitCartScreen();
    if (shouldExit) {
      Get.back(); // Exit the screen
    }
  }
}

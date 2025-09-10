import 'package:get/get.dart';

void closeLoadingDialog() {
  if (Get.isDialogOpen ?? false) {
    Get.close(1);
  }
}

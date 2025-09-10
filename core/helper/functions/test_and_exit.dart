import "package:get/get.dart";

void testAndExit(int milliseconds) {
  Future.delayed(
    Duration(milliseconds: milliseconds),
    () {
      Get.back();
    },
  );
}

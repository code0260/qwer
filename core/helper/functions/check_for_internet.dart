import 'package:almonazim/core/device/device_utility.dart';
import 'package:almonazim/core/helper/functions/currency%20functions/get_all_currencies.dart';
import 'package:almonazim/core/helper/functions/custom%20dialogs/alert_dialog.dart';
import 'package:almonazim/core/helper/functions/custom%20dialogs/alert_loading.dart';
import 'package:almonazim/core/helper/functions/custom%20dialogs/close_loading_dialog.dart';
import 'package:almonazim/core/helper/functions/unit%20functions/get_all_units.dart';
import 'package:almonazim/data/data%20source/locale/store_step.dart';
import 'package:get/get.dart';

Future<void> checkInternet() async {
  if (!await AppDevice.checkInternetFunction()) {
    closeLoadingDialog();
    alertDialog(
      context: Get.context,
      title: 'حالة الانترنت',
      content: "لا يوجد اتصال بالانترنت \n الرجاء المحاولة مجدداً",
      confirmText: "إعادة المحاولة",
      showCancel: false,
      isDismissible: false,
      onPressed: () async {
        Get.back();
        alertLoading();
        checkInternet();
      },
    );
  } else {
    closeLoadingDialog();
    if (StoreStep.getStep() == "2" || StoreStep.getStep() == "3") {
      await getAllUnits();
      await getAllCurrencies();
      // getAllOffers();
    }
  }
}

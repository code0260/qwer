import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/data/data%20source/locale/store_print_setting.dart';
import 'package:almonazim/view/widget/bluetooth/bluetooth_devices_dialog.dart';
import 'package:almonazim/view/widget/bluetooth/usb_devices_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<String?> chooseDeviceDialog() async {
  return await showDialog<String?>(
      context: Get.context!,
      builder: (BuildContext context) {
        if (StorePrintSetting.getConnectionType() ==
            PrinterConnectionType.bluetooth) {
          return const BluetoothDevicesDialog();
        } else {
          return const USBDevicesDialog();
        }
      });
}

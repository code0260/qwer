import 'package:almonazim/core/helper/functions/notification%20functions/firebase_functions.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> requestPermissions() async {
  if (await Permission.camera.isDenied) {
    await Permission.camera.request();
  }
  if (await Permission.bluetoothScan.isDenied) {
    await Permission.bluetoothScan.request();
  }
  if (await Permission.bluetooth.isDenied) {
    await Permission.bluetooth.request();
  }
  if (await Permission.bluetoothConnect.isDenied) {
    await Permission.bluetoothConnect.request();
  }

  if (await Permission.manageExternalStorage.isDenied) {
    await Permission.manageExternalStorage.request();
  }
  notificationPermission();
}

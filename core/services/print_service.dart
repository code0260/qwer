import 'dart:io';
import 'dart:ui' as ui_package;

import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data/data%20source/locale/store_print_setting.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as image_package;
import 'package:print_usb/model/usb_device.dart';
import 'package:print_usb/print_usb.dart';
// import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';
import 'package:printing/printing.dart';

class PrinterService {
  final BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;
  List<BluetoothDevice> androidIosDevices = [];
  // List<BluetoothInfo> windowsDevices = [];
  List<UsbDevice> usbDevices = [];

  Future<void> printInvoice(File pdfFile, String deviceName) async {
    List<int> bytes = await pdfToBytes(pdfFile);
    if (StorePrintSetting.getConnectionType() == PrinterConnectionType.usb) {
      await printUSB(bytes, deviceName);
      return;
    }
    // if (Platform.isWindows) {
    //   await printWindowsInvoice(bytes);
    // } else {
    await printAndroidIosInvoice(bytes);
    // }
  }

  // Future<void> pdfTest() async {
  //   File pdfFile = File("C:/Users/Housin/Documents/الصوان.pdf");
  //   Uint8List pdfData = await pdfFile.readAsBytes();
  //   await for (var page in Printing.raster(
  //     pdfData,
  //     pages: [0], // Render the first page
  //     dpi: 20,
  //   )) {
  //     ui_package.Image imageUi = await page.toImage();
  //     ByteData? data =
  //         await imageUi.toByteData(format: ui_package.ImageByteFormat.png);
  //     final Uint8List imageBytes = data!.buffer.asUint8List();
  //     image_package.Image? imagePackage = image_package.decodeImage(imageBytes);
  //     // image_package.Image blackWhiteImage =
  //     //     image_package.grayscale(imagePackage!);
  //     // const threshold = 0.8; // Adjust this value as needed
  //     // final blackAndWhiteImage = image_package
  //     //     .luminanceThreshold(blackWhiteImage, threshold: threshold);
  //     List<int> bytes = await preparePrintBytes(imagePackage!);
  //     await PrintBluetoothThermal.writeBytes(bytes);
  //   }
  // }

  Future<List<String>> getBluetoothPrinter() async {
    // if (Platform.isWindows) {
    // return await getWindowsBluetoothDevices();
    // } else {
    return await getAndroidIosBluetoothDevices();
    // }
  }

  Future<void> connectBluetoothPrinter(String deviceName) async {
    if (StorePrintSetting.getConnectionType() == PrinterConnectionType.usb) {
      await connectUSBPrinter(deviceName);
      return;
    }

    if (Platform.isWindows) {
      // await connectWindowsBluetooth(deviceName);
    } else {
      await connectAndroidIosBluetooth(deviceName);
    }
  }

  Future<void> disconnectBluetoothPrinter() async {
    if (StorePrintSetting.getConnectionType() == PrinterConnectionType.usb) {
      await disconnectUSBPrinter();
      return;
    }

    // if (Platform.isWindows) {
    //   await disconnectWindowsBluetooth();
    // } else {
    await disconnectAndroidIosBluetooth();
    // }
  }

  // Android
  Future<void> printAndroidIosInvoice(List<int> bytes) async {
    if (await bluetooth.isConnected ?? false) {
      bluetooth.writeBytes(Uint8List.fromList(bytes));
      // bluetooth.printNewLine();
      // bluetooth.printCustom("Invoice", 3, 1); // Title
      // bluetooth.printNewLine();
      // bluetooth.printCustom(invoiceData, 1, 0); // Body
      // bluetooth.printNewLine();
      // bluetooth.printCustom("Thank you!", 2, 1);
      // bluetooth.printNewLine();
      // bluetooth.paperCut();
    }
  }

  Future<void> connectAndroidIosBluetooth(String deviceName) async {
    if (androidIosDevices.isEmpty) {
      await getAndroidIosBluetoothDevices();
    }
    if (androidIosDevices.isNotEmpty) {
      BluetoothDevice printer = androidIosDevices.firstWhere(
        (element) => element.name == deviceName,
      );
      await bluetooth.connect(printer);
    } else {
      throw PrintFailure('لم يتم العثور على الطابعة, تأكد من البلوتوث');
    }
  }

  Future<void> disconnectAndroidIosBluetooth() async {
    if (await bluetooth.isConnected ?? false) {
      await bluetooth.disconnect();
    }
  }

  Future<List<String>> getAndroidIosBluetoothDevices() async {
    List<BluetoothDevice> devices = await bluetooth.getBondedDevices();
    androidIosDevices = devices;
    return List.generate(
      devices.length,
      (index) => devices[index].name!,
    );
  }

  // Future<void> printWindowsInvoice(bytes) async {
  //   if (await PrintBluetoothThermal.connectionStatus) {
  //     await PrintBluetoothThermal.writeBytes(bytes);
  //   }
  // }

  Future<List<int>> pdfToBytes(File pdfFile) async {
    List<int> pdfBytes = [];
    Uint8List pdfData = await pdfFile.readAsBytes();
    await for (var page in Printing.raster(
      pdfData,
      // pages: [0], // Render the first page
      dpi: 195,
    )) {
      ui_package.Image imageUi = await page.toImage();
      ByteData? data =
          await imageUi.toByteData(format: ui_package.ImageByteFormat.png);
      final Uint8List imageBytes = data!.buffer.asUint8List();
      image_package.Image? imagePackage = image_package.decodeImage(imageBytes);
      image_package.Image blackWhiteImage =
          image_package.grayscale(imagePackage!);
      const threshold = 0.8; // Adjust this value as needed
      final blackAndWhiteImage = image_package
          .luminanceThreshold(blackWhiteImage, threshold: threshold);
      List<int> bytes = await preparePrintBytes(blackAndWhiteImage);
      pdfBytes.addAll(bytes);
    }
    return pdfBytes;
  }

  Future<List<int>> preparePrintBytes(
      image_package.Image blackAndWhiteImage) async {
    List<int> bytes = [];
    // Using default profile
    final profile = await CapabilityProfile.load();
    PaperSize paperSize = StorePrintSetting.getPaperSize() == '80mm'
        ? PaperSize.mm80
        : PaperSize.mm58;
    final generator = Generator(paperSize, profile);
    bytes += generator.reset();
    //$ dealing with copies:
    int numberOfCopies = StorePrintSetting.getNumberCopies() ?? 1;
    int printedCopies = 0;
    while (printedCopies < numberOfCopies) {
      bytes += generator.image(blackAndWhiteImage);
      // no need for feed as there is place in the pdf file itself
      // bytes += generator.feed(1);
      bytes += generator.cut();
      printedCopies += 1;
    }
    return bytes;
  }

  // Future<void> connectWindowsBluetooth(String deviceName) async {
  //   if (windowsDevices.isEmpty) {
  //     await getWindowsBluetoothDevices();
  //   }
  //   if (windowsDevices.isNotEmpty) {
  //     String? selectedMac = windowsDevices
  //         .firstWhereOrNull(
  //           (element) => element.name == deviceName,
  //         )
  //         ?.macAdress;
  //     if (selectedMac != null) {
  //       await PrintBluetoothThermal.connect(macPrinterAddress: selectedMac);
  //     }
  //   } else {
  //     throw PrintFailure('لم يتم العثور على الطابعة, تأكد من البلوتوث');
  //   }
  // }

  // Future<void> disconnectWindowsBluetooth() async {
  //   if (await PrintBluetoothThermal.connectionStatus) {
  //     await PrintBluetoothThermal.disconnect;
  //   }
  // }

  // Future<List<String>> getWindowsBluetoothDevices() async {
  //   final List<BluetoothInfo> listResult =
  //       await PrintBluetoothThermal.pairedBluetooths;
  //   windowsDevices = listResult;
  //   return List.generate(
  //     listResult.length,
  //     (index) => listResult[index].name,
  //   );
  // }

  Future<void> connectUSBPrinter(String deviceName) async {
    if (Platform.isWindows) {
      bool connected = await PrintUsb.connect(
          name: usbDevices
              .firstWhere((element) => element.name == deviceName)
              .name);
      if (connected == false) {
        throw Exception('لم يتمكن من الاتصال ب $deviceName');
      }
    }
  }

  Future<void> disconnectUSBPrinter() async {
    if (Platform.isWindows) {
      // await PrintUsb.(
      //     name: usbDevices
      //         .firstWhere((element) => element.name == deviceName)
      //         .name);
    }
  }

  Future<List<String>> getUSBPrinter() async {
    if (Platform.isWindows) {
      List<UsbDevice> devices = await PrintUsb.getList();
      usbDevices.addAll(devices);
      return devices.map((e) => e.name).toList();
    } else {
      throw Exception('غير مدعوم');
    }
  }

  Future<void> printUSB(List<int> data, String deviceName) async {
    await PrintUsb.printBytes(
        bytes: data,
        device: usbDevices.firstWhere((element) => element.name == deviceName));
  }
}

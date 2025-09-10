import 'dart:io';

import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/core/helper/functions/init_get_it.dart';
import 'package:almonazim/core/helper/printing/print_barcode.dart';
import 'package:almonazim/core/services/print_service.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:equatable/equatable.dart';

part 'print_barcode_state.dart';

class PrintBarcodeCubit extends SafeCubit<PrintBarcodeState> {
  PrintBarcodeCubit() : super(PrintBarcodeInitial());

  String? barcode;

  Future<void> printBarcode(String deviceName) async {
    try {
      emit(PrintBarcodeLoading());
      await Future.delayed(const Duration(seconds: 2));
      final File simplePdf = await PrintBarcode.generateBarcode(barcode!);
      // await PdfGenerator.openPdf(simplePdf);
      // await getIt.get<PrinterService>().pdfTest(simplePdf);

      await getIt.get<PrinterService>().connectBluetoothPrinter(deviceName);
      await getIt.get<PrinterService>().printInvoice(simplePdf, deviceName);
      await getIt.get<PrinterService>().disconnectBluetoothPrinter();
      emit(PrintBarcodeSuccess());
    } catch (e) {
      await getIt.get<PrinterService>().disconnectBluetoothPrinter();
      if (e is PrintFailure) {
        emit(PrintBarcodeFailure(errorMessage: (e).errMessage));
      } else {
        emit(PrintBarcodeFailure(errorMessage: e.toString()));
      }
    }
  }

  void chooseBarcode(String thisBarcode) {
    barcode = thisBarcode;
    emit(PrintBarcodeChoose(barcode: thisBarcode));
  }
}

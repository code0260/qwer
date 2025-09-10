import 'dart:io';

import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/core/helper/functions/init_get_it.dart';
import 'package:almonazim/core/helper/printing/invoice%20pdf/invoice_pdf.dart';
import 'package:almonazim/core/services/print_service.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/model/invoice%20models/get_invoices_items_model.dart';
import 'package:equatable/equatable.dart';

part 'print_invoice_state.dart';

class PrintInvoiceCubit extends SafeCubit<PrintInvoiceState> {
  PrintInvoiceCubit() : super(PrintInvoiceInitial());
  Future<void> printInvoice(
      GetInvoicesItemsModel invoicesItems, String deviceName) async {
    try {
      emit(PrintInvoiceLoading());
      final File simplePdf =
          await InvoicePdf.generateInvoice(invoicesItems, immediatePrint: true);
      // await PdfGenerator.openPdf(simplePdf);
      // await getIt.get<PrinterService>().pdfTest(simplePdf);

      await getIt.get<PrinterService>().connectBluetoothPrinter(deviceName);
      await getIt.get<PrinterService>().printInvoice(simplePdf, deviceName);
      await getIt.get<PrinterService>().disconnectBluetoothPrinter();
      emit(PrintInvoiceSuccess());
    } catch (e) {
      await getIt.get<PrinterService>().disconnectBluetoothPrinter();
      if (e is PrintFailure) {
        emit(PrintInvoiceFailure(errorMessage: (e).errMessage));
      } else {
        emit(PrintInvoiceFailure(errorMessage: e.toString()));
      }
    }
  }
}

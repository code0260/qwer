import 'dart:io';

import 'package:almonazim/core/helper/printing/invoice%20pdf/invoice_pdf.dart';
import 'package:almonazim/core/helper/printing/pdf_generator.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/model/invoice%20models/get_invoices_items_model.dart';
import 'package:equatable/equatable.dart';

part 'pdf_invoice_state.dart';

class PdfInvoiceCubit extends SafeCubit<PdfInvoiceState> {
  PdfInvoiceCubit() : super(PdfInvoiceInitial());
  Future<void> openPdfInvoice(GetInvoicesItemsModel invoicesItems) async {
    try {
      emit(PdfInvoiceLoading());
      final File simplePdf = await InvoicePdf.generateInvoice(invoicesItems);
      await PdfGenerator.openPdf(simplePdf);
      emit(PdfInvoiceSuccess());
    } on Exception catch (e) {
      emit(PdfInvoiceFailure(errorMessage: e.toString()));
    }
  }

  Future<void> sharePdfInvoice(GetInvoicesItemsModel invoicesItems) async {
    try {
      emit(PdfInvoiceLoading());
      final File simplePdf = await InvoicePdf.generateInvoice(invoicesItems);
      await PdfGenerator.sharePdfFile(simplePdf);
      emit(PdfInvoiceSuccess());
    } on Exception catch (e) {
      emit(PdfInvoiceFailure(errorMessage: e.toString()));
    }
  }
}

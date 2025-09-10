import 'dart:io';

import 'package:almonazim/core/helper/export/export%20balance%20sheet/export_balance_sheet.dart';
import 'package:almonazim/core/helper/printing/pdf_generator.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/model/account%20models/account_model.dart';
import 'package:equatable/equatable.dart';

part 'balance_sheet_pdf_state.dart';

class BalanceSheetPdfCubit extends SafeCubit<BalanceSheetPdfState> {
  BalanceSheetPdfCubit() : super(BalanceSheetPdfInitial());

  Future<void> openBalanceSheetPdf(List<AccountModel> lines) async {
    try {
      emit(BalanceSheetPdfLoading());
      final File simplePdf = await ExportBalanceSheet.generatePdf(lines);
      await PdfGenerator.openPdf(simplePdf);
      emit(BalanceSheetPdfSuccess());
    } on Exception catch (e) {
      emit(BalanceSheetPdfFailure(errorMessage: e.toString()));
    }
  }

  Future<void> shareBalanceSheetPdf(List<AccountModel> lines) async {
    try {
      emit(BalanceSheetPdfLoading());
      final File simplePdf = await ExportBalanceSheet.generatePdf(lines);
      await PdfGenerator.openPdf(simplePdf);
      emit(BalanceSheetPdfSuccess());
    } on Exception catch (e) {
      emit(BalanceSheetPdfFailure(errorMessage: e.toString()));
    }
  }

  Future<void> createBalanceSheetPdf(List<AccountModel> lines) async {
    try {
      emit(BalanceSheetPdfLoading());
      final File simplePdf = await ExportBalanceSheet.generatePdf(lines);
      emit(BalanceSheetPdfSuccess(path: simplePdf.path));
    } on Exception catch (e) {
      emit(BalanceSheetPdfFailure(errorMessage: e.toString()));
    }
  }
}

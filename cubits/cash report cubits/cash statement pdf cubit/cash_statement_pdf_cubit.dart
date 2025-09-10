import 'dart:io';

import 'package:almonazim/core/helper/export/export%20cash%20statement/export_cash_statement.dart';
import 'package:almonazim/core/helper/printing/pdf_generator.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/model/report%20models/cash%20report%20models/cash_account_statement_model.dart';
import 'package:equatable/equatable.dart';

part 'cash_statement_pdf_state.dart';

class CashStatementPdfCubit extends SafeCubit<CashStatementPdfState> {
  CashStatementPdfCubit() : super(CashStatementPdfInitial());

  Future<void> openCashStatementPdf(CashAccountStatementModel accountStatement,
      String startDate, String endDate) async {
    try {
      emit(CashStatementPdfLoading());
      final File simplePdf = await ExportCashStatement.generatePdf(
          accountStatement, startDate, endDate);
      await PdfGenerator.openPdf(simplePdf);
      emit(CashStatementPdfSuccess());
    } on Exception catch (e) {
      emit(CashStatementPdfFailure(errorMessage: e.toString()));
    }
  }

  Future<void> shareCashStatementPdf(CashAccountStatementModel accountStatement,
      String startDate, String endDate) async {
    try {
      emit(CashStatementPdfLoading());
      final File simplePdf = await ExportCashStatement.generatePdf(
          accountStatement, startDate, endDate);
      await PdfGenerator.openPdf(simplePdf);
      emit(CashStatementPdfSuccess());
    } on Exception catch (e) {
      emit(CashStatementPdfFailure(errorMessage: e.toString()));
    }
  }
}

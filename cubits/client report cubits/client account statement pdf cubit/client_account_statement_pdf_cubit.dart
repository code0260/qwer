import 'dart:io';

import 'package:almonazim/core/helper/export/export%20client%20account%20statement/export_client_account_statement.dart';
import 'package:almonazim/core/helper/printing/pdf_generator.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/model/report%20models/client%20report%20models/client_account_statement_model.dart';
import 'package:equatable/equatable.dart';

part 'client_account_statement_pdf_state.dart';

class ClientAccountStatementPdfCubit
    extends SafeCubit<ClientAccountStatementPdfState> {
  ClientAccountStatementPdfCubit() : super(ClientAccountStatementPdfInitial());

  Future<void> openClientAccountStatementPdf(
      ClientAccountStatementModel accountStatement,
      String startDate,
      String endDate) async {
    try {
      emit(ClientAccountStatementPdfLoading());
      final File simplePdf = await ExportClientAccountStatement.generatePdf(
          accountStatement, startDate, endDate);
      await PdfGenerator.openPdf(simplePdf);
      emit(ClientAccountStatementPdfSuccess());
    } on Exception catch (e) {
      emit(ClientAccountStatementPdfFailure(errorMessage: e.toString()));
    }
  }

  Future<void> shareClientAccountStatementPdf(
      ClientAccountStatementModel accountStatement,
      String startDate,
      String endDate) async {
    try {
      emit(ClientAccountStatementPdfLoading());
      final File simplePdf = await ExportClientAccountStatement.generatePdf(
          accountStatement, startDate, endDate);
      await PdfGenerator.openPdf(simplePdf);
      emit(ClientAccountStatementPdfSuccess());
    } on Exception catch (e) {
      emit(ClientAccountStatementPdfFailure(errorMessage: e.toString()));
    }
  }
}

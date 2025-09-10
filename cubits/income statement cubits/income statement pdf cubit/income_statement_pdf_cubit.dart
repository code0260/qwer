import 'dart:io';

import 'package:almonazim/core/helper/export/export%20income%20statement/export_income_statement.dart';
import 'package:almonazim/core/helper/printing/pdf_generator.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/model/report%20models/income%20statement%20report%20models/income_statement_line_model.dart';
import 'package:equatable/equatable.dart';

part 'income_statement_pdf_state.dart';

class IncomeStatementPdfCubit extends SafeCubit<IncomeStatementPdfState> {
  IncomeStatementPdfCubit() : super(IncomeStatementPdfInitial());

  Future<void> openIncomeStatementPdf(List<IncomeStatementLineModel> lines,
      String startDate, String endDate) async {
    try {
      emit(IncomeStatementPdfLoading());
      final File simplePdf =
          await ExportIncomeStatement.generatePdf(lines, startDate, endDate);
      await PdfGenerator.openPdf(simplePdf);
      emit(IncomeStatementPdfSuccess());
    } on Exception catch (e) {
      emit(IncomeStatementPdfFailure(errorMessage: e.toString()));
    }
  }

  Future<void> shareIncomeStatementPdf(List<IncomeStatementLineModel> lines,
      String startDate, String endDate) async {
    try {
      emit(IncomeStatementPdfLoading());
      final File simplePdf =
          await ExportIncomeStatement.generatePdf(lines, startDate, endDate);
      await PdfGenerator.openPdf(simplePdf);
      emit(IncomeStatementPdfSuccess());
    } on Exception catch (e) {
      emit(IncomeStatementPdfFailure(errorMessage: e.toString()));
    }
  }

  Future<void> createIncomeStatementPdf(List<IncomeStatementLineModel> lines,
      String startDate, String endDate) async {
    try {
      emit(IncomeStatementPdfLoading());
      final File simplePdf =
          await ExportIncomeStatement.generatePdf(lines, startDate, endDate);
      emit(IncomeStatementPdfSuccess(path: simplePdf.path));
    } on Exception catch (e) {
      emit(IncomeStatementPdfFailure(errorMessage: e.toString()));
    }
  }
}

part of 'income_statement_pdf_cubit.dart';

sealed class IncomeStatementPdfState extends Equatable {
  const IncomeStatementPdfState();

  @override
  List<Object> get props => [];
}

final class IncomeStatementPdfInitial extends IncomeStatementPdfState {}

class IncomeStatementPdfLoading extends IncomeStatementPdfState {}

class IncomeStatementPdfFailure extends IncomeStatementPdfState {
  final String errorMessage;

  const IncomeStatementPdfFailure({required this.errorMessage});
}

class IncomeStatementPdfSuccess extends IncomeStatementPdfState {
  final String? path;

  const IncomeStatementPdfSuccess({this.path});
}

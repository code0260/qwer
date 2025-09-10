part of 'cash_statement_pdf_cubit.dart';

sealed class CashStatementPdfState extends Equatable {
  const CashStatementPdfState();

  @override
  List<Object> get props => [];
}

final class CashStatementPdfInitial extends CashStatementPdfState {}

class CashStatementPdfLoading extends CashStatementPdfState {}

class CashStatementPdfFailure extends CashStatementPdfState {
  final String errorMessage;

  const CashStatementPdfFailure({required this.errorMessage});
}

class CashStatementPdfSuccess extends CashStatementPdfState {}

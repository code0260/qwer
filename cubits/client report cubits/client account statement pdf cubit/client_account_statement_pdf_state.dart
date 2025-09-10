part of 'client_account_statement_pdf_cubit.dart';

sealed class ClientAccountStatementPdfState extends Equatable {
  const ClientAccountStatementPdfState();

  @override
  List<Object> get props => [];
}

final class ClientAccountStatementPdfInitial
    extends ClientAccountStatementPdfState {}

class ClientAccountStatementPdfLoading extends ClientAccountStatementPdfState {}

class ClientAccountStatementPdfFailure extends ClientAccountStatementPdfState {
  final String errorMessage;

  const ClientAccountStatementPdfFailure({required this.errorMessage});
}

class ClientAccountStatementPdfSuccess extends ClientAccountStatementPdfState {}

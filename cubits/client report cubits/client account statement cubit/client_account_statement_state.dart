part of 'client_account_statement_cubit.dart';

sealed class ClientAccountStatementState extends Equatable {
  const ClientAccountStatementState();

  @override
  List<Object> get props => [];
}

final class ClientAccountStatementInitial extends ClientAccountStatementState {}

class ClientAccountStatementLoading extends ClientAccountStatementState {}

class ClientAccountStatementFailure extends ClientAccountStatementState {
  final String errorMessage;

  const ClientAccountStatementFailure(this.errorMessage);
}

class ClientAccountStatementSuccess extends ClientAccountStatementState {
  final ClientAccountStatementModel statementModel;

  const ClientAccountStatementSuccess({required this.statementModel});
}

part of 'cash_account_statement_cubit.dart';

sealed class CashAccountStatementState extends Equatable {
  const CashAccountStatementState();

  @override
  List<Object> get props => [];
}

final class CashAccountStatementInitial extends CashAccountStatementState {}

class CashAccountStatementLoading extends CashAccountStatementState {}

class CashAccountStatementFailure extends CashAccountStatementState {
  final String errorMessage;

  const CashAccountStatementFailure(this.errorMessage);
}

class CashAccountStatementSuccess extends CashAccountStatementState {
  final CashAccountStatementModel statementModel;

  const CashAccountStatementSuccess({required this.statementModel});
}

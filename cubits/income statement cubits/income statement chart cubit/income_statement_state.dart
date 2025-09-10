part of 'income_statement_cubit.dart';

sealed class IncomeStatementState extends Equatable {
  const IncomeStatementState();

  @override
  List<Object> get props => [];
}

final class IncomeStatementInitial extends IncomeStatementState {}

class IncomeStatementLoading extends IncomeStatementState {}

class IncomeStatementFailure extends IncomeStatementState {
  final String errorMessage;

  const IncomeStatementFailure(this.errorMessage);
}

class IncomeStatementSuccess extends IncomeStatementState {
  final List<IncomeStatementLineModel> lines;

  const IncomeStatementSuccess({required this.lines});
}

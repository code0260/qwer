part of 'balance_sheet_cubit.dart';

sealed class BalanceSheetState extends Equatable {
  const BalanceSheetState();

  @override
  List<Object> get props => [];
}

final class BalanceSheetInitial extends BalanceSheetState {}

class BalanceSheetLoading extends BalanceSheetState {}

class BalanceSheetFailure extends BalanceSheetState {
  final String errorMessage;

  const BalanceSheetFailure(this.errorMessage);
}

class BalanceSheetSuccess extends BalanceSheetState {
  final List<AccountModel> lines;

  const BalanceSheetSuccess({required this.lines});
}

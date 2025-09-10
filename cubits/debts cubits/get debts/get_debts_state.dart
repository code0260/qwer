part of 'get_debts_cubit.dart';

sealed class GetDebtsState extends Equatable {
  const GetDebtsState();

  @override
  List<Object> get props => [];
}

final class GetDebtsInitial extends GetDebtsState {}

class GetDebtsLoading extends GetDebtsState {}

class GetDebtsFailure extends GetDebtsState {
  final String errorMessage;

  const GetDebtsFailure(this.errorMessage);
}

class GetDebtsSuccess extends GetDebtsState {
  final List<DebtModel> debts;
  const GetDebtsSuccess({
    required this.debts,
  });
}

part of 'get_trial_balance_cubit.dart';

sealed class GetTrialBalanceState extends Equatable {
  const GetTrialBalanceState();

  @override
  List<Object> get props => [];
}

final class GetTrialBalanceInitial extends GetTrialBalanceState {}

class GetTrialBalanceLoading extends GetTrialBalanceState {}

class GetTrialBalanceFailure extends GetTrialBalanceState {
  final String errorMessage;

  const GetTrialBalanceFailure(this.errorMessage);
}

class GetTrialBalanceSuccess extends GetTrialBalanceState {
  final double amount;
  const GetTrialBalanceSuccess({
    required this.amount,
  });
  @override
  // TODO: implement props
  List<Object> get props => [amount];
}

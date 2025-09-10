part of 'get_withdrawals_cubit.dart';

sealed class GetWithdrawalsState extends Equatable {
  const GetWithdrawalsState();

  @override
  List<Object> get props => [];
}

final class GetWithdrawalsInitial extends GetWithdrawalsState {}

class GetWithdrawalsLoading extends GetWithdrawalsState {}

class GetWithdrawalsFailure extends GetWithdrawalsState {
  final String errorMessage;

  const GetWithdrawalsFailure(this.errorMessage);
}

class GetWithdrawalsSuccess extends GetWithdrawalsState {
  final List<WithdrawalModel> withdrawals;
  const GetWithdrawalsSuccess({
    required this.withdrawals,
  });
}

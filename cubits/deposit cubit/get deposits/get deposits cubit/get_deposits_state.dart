part of 'get_deposits_cubit.dart';

sealed class GetDepositsState extends Equatable {
  const GetDepositsState();

  @override
  List<Object> get props => [];
}

final class GetDepositsInitial extends GetDepositsState {}

class GetDepositsLoading extends GetDepositsState {}

class GetDepositsFailure extends GetDepositsState {
  final String errorMessage;

  const GetDepositsFailure(this.errorMessage);
}

class GetDepositsSuccess extends GetDepositsState {
  final List<DepositModel> deposits;
  const GetDepositsSuccess({
    required this.deposits,
  });
}

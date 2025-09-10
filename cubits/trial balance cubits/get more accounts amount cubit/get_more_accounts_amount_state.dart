part of 'get_more_accounts_amount_cubit.dart';

sealed class GetMoreAccountsAmountState extends Equatable {
  const GetMoreAccountsAmountState();

  @override
  List<Object> get props => [];
}

final class GetMoreAccountsAmountInitial extends GetMoreAccountsAmountState {}

class GetMoreAccountsAmountLoading extends GetMoreAccountsAmountState {}

class GetMoreAccountsAmountFailure extends GetMoreAccountsAmountState {
  final String errorMessage;

  const GetMoreAccountsAmountFailure(this.errorMessage);
}

class GetMoreAccountsAmountSuccess extends GetMoreAccountsAmountState {
  final List<TrialBalanceModel> accounts;
  const GetMoreAccountsAmountSuccess({
    required this.accounts,
  });
  @override
  // TODO: implement props
  List<Object> get props => [accounts];
}

part of 'add_withdrawal_cubit.dart';

sealed class AddWithdrawalState extends Equatable {
  const AddWithdrawalState();

  @override
  List<Object> get props => [];
}

final class AddWithdrawalInitial extends AddWithdrawalState {}

class AddWithdrawalLoading extends AddWithdrawalState {}

class AddWithdrawalFailure extends AddWithdrawalState {
  final String errorMessage;

  const AddWithdrawalFailure(this.errorMessage);
}

class AddWithdrawalSuccess extends AddWithdrawalState {
  const AddWithdrawalSuccess();
}

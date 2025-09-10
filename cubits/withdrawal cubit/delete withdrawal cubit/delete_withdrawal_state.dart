part of 'delete_withdrawal_cubit.dart';

sealed class DeleteWithdrawalState extends Equatable {
  const DeleteWithdrawalState();

  @override
  List<Object> get props => [];
}

final class DeleteWithdrawalInitial extends DeleteWithdrawalState {}

class DeleteWithdrawalLoading extends DeleteWithdrawalState {}

class DeleteWithdrawalFailure extends DeleteWithdrawalState {
  final String errorMessage;

  const DeleteWithdrawalFailure(this.errorMessage);
}

class DeleteWithdrawalSuccess extends DeleteWithdrawalState {
  const DeleteWithdrawalSuccess();
}

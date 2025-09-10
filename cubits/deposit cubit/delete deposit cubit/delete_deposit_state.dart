part of 'delete_deposit_cubit.dart';

sealed class DeleteDepositState extends Equatable {
  const DeleteDepositState();

  @override
  List<Object> get props => [];
}

final class DeleteDepositInitial extends DeleteDepositState {}

class DeleteDepositLoading extends DeleteDepositState {}

class DeleteDepositFailure extends DeleteDepositState {
  final String errorMessage;

  const DeleteDepositFailure(this.errorMessage);
}

class DeleteDepositSuccess extends DeleteDepositState {
  const DeleteDepositSuccess();
}

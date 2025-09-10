part of 'add_deposit_cubit.dart';

sealed class AddDepositState extends Equatable {
  const AddDepositState();

  @override
  List<Object> get props => [];
}

final class AddDepositInitial extends AddDepositState {}

class AddDepositLoading extends AddDepositState {}

class AddDepositFailure extends AddDepositState {
  final String errorMessage;

  const AddDepositFailure(this.errorMessage);
}

class AddDepositSuccess extends AddDepositState {
  const AddDepositSuccess();
}

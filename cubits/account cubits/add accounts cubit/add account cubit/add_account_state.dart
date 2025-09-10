part of 'add_account_cubit.dart';

sealed class AddAccountState extends Equatable {
  const AddAccountState();

  @override
  List<Object> get props => [];
}

final class AddAccountInitial extends AddAccountState {}

class AddAccountLoading extends AddAccountState {}

class AddAccountFailure extends AddAccountState {
  final String errorMessage;

  const AddAccountFailure(this.errorMessage);
}

class AddAccountSuccess extends AddAccountState {
  const AddAccountSuccess();
}

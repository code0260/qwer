part of 'edit_account_cubit.dart';

sealed class EditAccountState extends Equatable {
  const EditAccountState();

  @override
  List<Object> get props => [];
}

final class EditAccountInitial extends EditAccountState {}

class EditAccountLoading extends EditAccountState {}

class EditAccountFailure extends EditAccountState {
  final String errorMessage;

  const EditAccountFailure(this.errorMessage);
}

class EditAccountSuccess extends EditAccountState {
  const EditAccountSuccess();
}

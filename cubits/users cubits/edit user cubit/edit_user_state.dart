part of 'edit_user_cubit.dart';

sealed class EditUserState extends Equatable {
  const EditUserState();

  @override
  List<Object> get props => [];
}

final class EditUserInitial extends EditUserState {}

class EditUserLoading extends EditUserState {}

class EditUserFailure extends EditUserState {
  final String errorMessage;

  const EditUserFailure(this.errorMessage);
}

class EditUserSuccess extends EditUserState {
  const EditUserSuccess();
}

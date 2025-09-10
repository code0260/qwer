part of 'add_user_cubit.dart';

sealed class AddUserState extends Equatable {
  const AddUserState();

  @override
  List<Object> get props => [];
}

final class AddUserInitial extends AddUserState {}

class AddUserLoading extends AddUserState {}

class AddUserFailure extends AddUserState {
  final String errorMessage;

  const AddUserFailure(this.errorMessage);
}

class AddUserSuccess extends AddUserState {
  const AddUserSuccess();
}

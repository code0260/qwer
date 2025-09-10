part of 'logout_user_cubit.dart';

sealed class LogoutUserState extends Equatable {
  const LogoutUserState();

  @override
  List<Object> get props => [];
}

final class LogoutUserInitial extends LogoutUserState {}

class LogoutUserLoading extends LogoutUserState {}

class LogoutUserFailure extends LogoutUserState {
  final String errorMessage;

  const LogoutUserFailure(this.errorMessage);
}

class LogoutUserSuccess extends LogoutUserState {}

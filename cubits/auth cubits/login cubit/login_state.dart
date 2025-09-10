part of 'login_cubit.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginFailure extends LoginState {
  final String errorMessage;

  const LoginFailure(this.errorMessage);
}

class LoginSuccess extends LoginState {
  const LoginSuccess();
}

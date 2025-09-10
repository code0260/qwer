part of 'get_users_cubit.dart';

sealed class GetUsersState extends Equatable {
  const GetUsersState();

  @override
  List<Object> get props => [];
}

final class GetUsersInitial extends GetUsersState {}

class GetUsersLoading extends GetUsersState {}

class GetUsersFailure extends GetUsersState {
  final String errorMessage;

  const GetUsersFailure(this.errorMessage);
}

class GetUsersSuccess extends GetUsersState {
  final List<UserModel> users;
  const GetUsersSuccess({
    required this.users,
  });
  @override
  // TODO: implement props
  List<Object> get props => [users];
}

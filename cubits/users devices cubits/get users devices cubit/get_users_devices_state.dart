part of 'get_users_devices_cubit.dart';

sealed class GetUsersDevicesState extends Equatable {
  const GetUsersDevicesState();

  @override
  List<Object> get props => [];
}

final class GetUsersDevicesInitial extends GetUsersDevicesState {}

class GetUsersDevicesLoading extends GetUsersDevicesState {}

class GetUsersDevicesFailure extends GetUsersDevicesState {
  final String errorMessage;

  const GetUsersDevicesFailure(this.errorMessage);
}

class GetUsersDevicesSuccess extends GetUsersDevicesState {
  final List<UserDeviceModel> users;
  const GetUsersDevicesSuccess({
    required this.users,
  });
  @override
  // TODO: implement props
  List<Object> get props => [users];
}

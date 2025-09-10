part of 'get_notifications_cubit.dart';

sealed class GetNotificationsState extends Equatable {
  const GetNotificationsState();

  @override
  List<Object> get props => [];
}

final class GetNotificationsInitial extends GetNotificationsState {}

class GetNotificationsLoading extends GetNotificationsState {}

class GetNotificationsFailure extends GetNotificationsState {
  final String errorMessage;

  const GetNotificationsFailure(this.errorMessage);
}

class GetNotificationsSuccess extends GetNotificationsState {
  final List<NotificationModel> notifications;
  const GetNotificationsSuccess({
    required this.notifications,
  });
  @override
  // TODO: implement props
  List<Object> get props => [notifications];
}

part of 'get_rooms_cubit.dart';

sealed class GetRoomsState {
  const GetRoomsState();
}

final class GetRoomsInitial extends GetRoomsState {}

class GetRoomsLoading extends GetRoomsState {}

class GetRoomsFailure extends GetRoomsState {
  final String errorMessage;

  const GetRoomsFailure(this.errorMessage);
}

class GetRoomsSuccess extends GetRoomsState {
  final List<RoomModel> rooms;
  GetRoomsSuccess({required this.rooms});
}

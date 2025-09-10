part of 'get_floors_cubit.dart';

sealed class GetFloorsState {
  const GetFloorsState();
}

final class GetFloorsInitial extends GetFloorsState {}

class GetFloorsLoading extends GetFloorsState {}

class GetFloorsFailure extends GetFloorsState {
  final String errorMessage;

  const GetFloorsFailure(this.errorMessage);
}

class GetFloorsSuccess extends GetFloorsState {
  final List<FloorModel> floors;
  GetFloorsSuccess({required this.floors});
}

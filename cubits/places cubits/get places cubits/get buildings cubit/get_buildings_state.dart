part of 'get_buildings_cubit.dart';

sealed class GetBuildingsState {
  const GetBuildingsState();
}

final class GetBuildingsInitial extends GetBuildingsState {}

class GetBuildingsLoading extends GetBuildingsState {}

class GetBuildingsFailure extends GetBuildingsState {
  final String errorMessage;

  const GetBuildingsFailure(this.errorMessage);
}

class GetBuildingSuccess extends GetBuildingsState {
  final List<BuildingModel> buildings;
  GetBuildingSuccess({required this.buildings});
}

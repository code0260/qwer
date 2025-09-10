part of 'get_building_place_cubit.dart';

sealed class GetBuildingPlaceState {
  const GetBuildingPlaceState();
}

final class GetBuildingPlaceInitial extends GetBuildingPlaceState {}

class GetBuildingPlaceLoading extends GetBuildingPlaceState {}

class GetBuildingPlaceFailure extends GetBuildingPlaceState {
  final String errorMessage;

  const GetBuildingPlaceFailure(this.errorMessage);
}

class GetBuildingPlaceSuccess extends GetBuildingPlaceState {}

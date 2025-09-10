part of 'add_place_cubit.dart';

sealed class AddPlaceState extends Equatable {
  const AddPlaceState();

  @override
  List<Object> get props => [];
}

final class AddPlaceInitial extends AddPlaceState {}

class AddPlaceLoading extends AddPlaceState {}

class AddPlaceFailure extends AddPlaceState {
  final String errorMessage;

  const AddPlaceFailure(this.errorMessage);
}

class AddPlaceSuccess extends AddPlaceState {}

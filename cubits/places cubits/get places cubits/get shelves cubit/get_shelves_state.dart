part of 'get_shelves_cubit.dart';

sealed class GetShelvesState {
  const GetShelvesState();
}

final class GetShelvesInitial extends GetShelvesState {}

class GetShelvesLoading extends GetShelvesState {}

class GetShelvesFailure extends GetShelvesState {
  final String errorMessage;

  const GetShelvesFailure(this.errorMessage);
}

class GetShelvesSuccess extends GetShelvesState {
  final List<ShelveModel> shelves;
  GetShelvesSuccess({required this.shelves});
}

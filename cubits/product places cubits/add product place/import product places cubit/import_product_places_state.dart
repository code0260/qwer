part of 'import_product_places_cubit.dart';

sealed class ImportProductPlacesState extends Equatable {
  const ImportProductPlacesState();

  @override
  List<Object> get props => [];
}

final class ImportProductPlacesInitial extends ImportProductPlacesState {}

class ImportProductPlacesLoading extends ImportProductPlacesState {}

class ImportProductPlacesFailure extends ImportProductPlacesState {
  final String errorMessage;

  const ImportProductPlacesFailure({required this.errorMessage});
}

class ImportProductPlacesSuccess extends ImportProductPlacesState {}

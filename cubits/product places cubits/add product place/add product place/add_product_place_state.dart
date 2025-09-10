part of 'add_product_place_cubit.dart';

sealed class AddProductPlaceState extends Equatable {
  const AddProductPlaceState();

  @override
  List<Object> get props => [];
}

final class AddProductPlaceInitial extends AddProductPlaceState {}

class AddProductPlaceLoading extends AddProductPlaceState {}

class AddProductPlaceFailure extends AddProductPlaceState {
  final String errorMessage;

  const AddProductPlaceFailure(this.errorMessage);
}

class AddProductPlaceSuccess extends AddProductPlaceState {
  const AddProductPlaceSuccess();
}

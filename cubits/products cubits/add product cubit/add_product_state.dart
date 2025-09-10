part of 'add_product_cubit.dart';

sealed class AddProductState extends Equatable {
  const AddProductState();

  @override
  List<Object> get props => [];
}

final class AddProductInitial extends AddProductState {}

class AddProductLoading extends AddProductState {}

class AddProductFailure extends AddProductState {
  final String errorMessage;

  const AddProductFailure(this.errorMessage);
}

class AddProductSuccess extends AddProductState {
  const AddProductSuccess();
}

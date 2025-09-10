part of 'edit_product_cubit.dart';

sealed class EditProductState extends Equatable {
  const EditProductState();

  @override
  List<Object> get props => [];
}

final class EditProductInitial extends EditProductState {}

class EditProductLoading extends EditProductState {}

class EditProductFailure extends EditProductState {
  final String errorMessage;

  const EditProductFailure({required this.errorMessage});
}

class EditProductSuccess extends EditProductState {
  const EditProductSuccess();
}

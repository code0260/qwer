part of 'edit_product_count_cubit.dart';

sealed class EditProductCountState extends Equatable {
  const EditProductCountState();

  @override
  List<Object> get props => [];
}

final class EditProductCountInitial extends EditProductCountState {}

class EditProductCountLoading extends EditProductCountState {}

class EditProductCountFailure extends EditProductCountState {
  final String errorMessage;

  const EditProductCountFailure(this.errorMessage);
}

class EditProductCountSuccess extends EditProductCountState {
  const EditProductCountSuccess();
}

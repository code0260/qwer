part of 'move_product_cubit.dart';

sealed class MoveProductState extends Equatable {
  const MoveProductState();

  @override
  List<Object> get props => [];
}

final class MoveProductInitial extends MoveProductState {}

class MoveProductLoading extends MoveProductState {}

class MoveProductFailure extends MoveProductState {
  final String errorMessage;

  const MoveProductFailure(this.errorMessage);
}

class MoveProductSuccess extends MoveProductState {}

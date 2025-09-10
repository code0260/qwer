part of 'view_rbcni_cart_cubit.dart';

sealed class ViewRBCNICartState extends Equatable {
  const ViewRBCNICartState();

  @override
  List<Object> get props => [];
}

final class ViewRBCNICartInitial extends ViewRBCNICartState {}

final class ViewRBCNICartLoading extends ViewRBCNICartState {}

final class ViewRBCNICartFailure extends ViewRBCNICartState {
  final String errorMessage;

  const ViewRBCNICartFailure({required this.errorMessage});
}

class ViewRBCNICartSuccess extends ViewRBCNICartState {
  final List<BuyItemModel> items;
  final int itemsLength; // this is used to make the two instances not equal
  const ViewRBCNICartSuccess({required this.items, required this.itemsLength});
  @override
  List<Object> get props => [itemsLength];
}

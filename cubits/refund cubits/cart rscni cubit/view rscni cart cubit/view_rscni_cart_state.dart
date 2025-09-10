part of 'view_rscni_cart_cubit.dart';

sealed class ViewRSCNICartState extends Equatable {
  const ViewRSCNICartState();

  @override
  List<Object> get props => [];
}

final class ViewRSCNICartInitial extends ViewRSCNICartState {}

final class ViewRSCNICartLoading extends ViewRSCNICartState {}

final class ViewRSCNICartFailure extends ViewRSCNICartState {
  final String errorMessage;

  const ViewRSCNICartFailure({required this.errorMessage});
}

class ViewRSCNICartSuccess extends ViewRSCNICartState {
  final List<SellItemModel> items;
  final int itemsLength; // this is used to make the two instances not equal
  const ViewRSCNICartSuccess({required this.items, required this.itemsLength});
  @override
  List<Object> get props => [itemsLength];
}

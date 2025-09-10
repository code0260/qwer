part of 'view_buy_edit_cart_cubit.dart';

sealed class ViewBuyEditCartState extends Equatable {
  const ViewBuyEditCartState();

  @override
  List<Object> get props => [];
}

final class ViewBuyEditCartInitial extends ViewBuyEditCartState {}

final class ViewBuyEditCartLoading extends ViewBuyEditCartState {}

final class ViewBuyEditCartFailure extends ViewBuyEditCartState {
  final String errorMessage;

  const ViewBuyEditCartFailure({required this.errorMessage});
}

class ViewBuyEditCartSuccess extends ViewBuyEditCartState {
  final List<BuyItemModel> items;
  final int itemsLength; // this is used to make the two instances not equal
  const ViewBuyEditCartSuccess(
      {required this.items, required this.itemsLength});
  @override
  List<Object> get props => [itemsLength];
}

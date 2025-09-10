part of 'view_buy_cart_cubit.dart';

sealed class ViewBuyCartState extends Equatable {
  const ViewBuyCartState();

  @override
  List<Object> get props => [];
}

final class ViewBuyCartInitial extends ViewBuyCartState {}

class ViewBuyCartSuccess extends ViewBuyCartState {
  final List<BuyItemModel> items;
  final int itemsLength; // this is used to make the two instances not equal
  const ViewBuyCartSuccess({required this.items, required this.itemsLength});
  @override
  List<Object> get props => [itemsLength];
}

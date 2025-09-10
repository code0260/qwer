part of 'view_sell_cart_cubit.dart';

sealed class ViewSellCartState extends Equatable {
  const ViewSellCartState();

  @override
  List<Object> get props => [];
}

final class ViewSellCartInitial extends ViewSellCartState {}

class ViewSellCartSuccess extends ViewSellCartState {
  final List<SellItemModel> items;
  final int itemsLength; // this is used to make the two instances not equal
  const ViewSellCartSuccess({required this.items, required this.itemsLength});
  @override
  List<Object> get props => [itemsLength];
}

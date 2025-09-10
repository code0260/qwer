part of 'view_sell_edit_cart_cubit.dart';

sealed class ViewSellEditCartState extends Equatable {
  const ViewSellEditCartState();

  @override
  List<Object> get props => [];
}

final class ViewSellEditCartInitial extends ViewSellEditCartState {}

final class ViewSellEditCartLoading extends ViewSellEditCartState {}

final class ViewSellEditCartFailure extends ViewSellEditCartState {
  final String errorMessage;

  const ViewSellEditCartFailure({required this.errorMessage});
}

class ViewSellEditCartSuccess extends ViewSellEditCartState {
  final List<SellItemModel> items;
  final int itemsLength; // this is used to make the two instances not equal
  const ViewSellEditCartSuccess(
      {required this.items, required this.itemsLength});
  @override
  List<Object> get props => [itemsLength];
}

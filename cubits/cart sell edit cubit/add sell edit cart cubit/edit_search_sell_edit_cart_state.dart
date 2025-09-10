part of 'edit_search_sell_edit_cart_cubit.dart';

sealed class EditSearchSellEditCartState extends Equatable {
  const EditSearchSellEditCartState();

  @override
  List<Object> get props => [];
}

final class EditSearchSellEditCart extends EditSearchSellEditCartState {
  final int id;
  final bool isAdd;
  const EditSearchSellEditCart({required this.isAdd, required this.id});
  @override
  List<Object> get props => [id, isAdd];
}

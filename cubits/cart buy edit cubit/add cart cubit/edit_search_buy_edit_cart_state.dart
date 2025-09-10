part of 'edit_search_buy_edit_cart_cubit.dart';

sealed class EditSearchBuyEditCartState extends Equatable {
  const EditSearchBuyEditCartState();

  @override
  List<Object> get props => [];
}

final class EditSearchBuyEditCart extends EditSearchBuyEditCartState {
  final int id;
  final bool isAdd;
  const EditSearchBuyEditCart({required this.isAdd, required this.id});
  @override
  List<Object> get props => [id, isAdd];
}

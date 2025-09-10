part of 'edit_search_buy_cart_cubit.dart';

sealed class EditSearchBuyCartState extends Equatable {
  const EditSearchBuyCartState();

  @override
  List<Object> get props => [];
}

final class EditSearchBuyCart extends EditSearchBuyCartState {
  final int id;
  final bool isAdd;
  const EditSearchBuyCart({required this.isAdd, required this.id});
  @override
  List<Object> get props => [id, isAdd];
}

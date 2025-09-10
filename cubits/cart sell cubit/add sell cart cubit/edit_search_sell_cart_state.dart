part of 'edit_search_sell_cart_cubit.dart';

sealed class EditSearchSellCartState extends Equatable {
  const EditSearchSellCartState();

  @override
  List<Object> get props => [];
}

final class EditSearchSellCart extends EditSearchSellCartState {
  final int id;
  final bool isAdd;
  const EditSearchSellCart({required this.isAdd, required this.id});
  @override
  List<Object> get props => [id, isAdd];
}

part of 'edit_sell_product_place_cubit.dart';

sealed class EditSellProductPlaceState extends Equatable {
  const EditSellProductPlaceState();

  @override
  List<Object> get props => [];
}

final class EditSellProductPlaceItem extends EditSellProductPlaceState {
  final int id;
  final bool isAdd;
  const EditSellProductPlaceItem({required this.isAdd, required this.id});
  @override
  List<Object> get props => [id, isAdd];
}

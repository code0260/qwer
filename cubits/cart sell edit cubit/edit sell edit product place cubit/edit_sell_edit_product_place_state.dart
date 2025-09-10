part of 'edit_sell_edit_product_place_cubit.dart';

sealed class EditSellEditProductPlaceState extends Equatable {
  const EditSellEditProductPlaceState();

  @override
  List<Object> get props => [];
}

final class EditSellEditProductPlaceItem extends EditSellEditProductPlaceState {
  final int id;
  final bool isAdd;
  const EditSellEditProductPlaceItem({required this.isAdd, required this.id});
  @override
  List<Object> get props => [id, isAdd];
}

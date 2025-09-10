part of 'edit_rscni_product_place_cubit.dart';

sealed class EditRSCNIProductPlaceState extends Equatable {
  const EditRSCNIProductPlaceState();

  @override
  List<Object> get props => [];
}

final class EditRSCNIProductPlaceItem extends EditRSCNIProductPlaceState {
  final int id;
  final bool isAdd;
  const EditRSCNIProductPlaceItem({required this.isAdd, required this.id});
  @override
  List<Object> get props => [id, isAdd];
}

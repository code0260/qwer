part of 'edit_search_rbcni_cart_cubit.dart';

sealed class EditSearchRBCNICartState extends Equatable {
  const EditSearchRBCNICartState();

  @override
  List<Object> get props => [];
}

final class EditSearchRBCNICart extends EditSearchRBCNICartState {
  final int id;
  final bool isAdd;
  const EditSearchRBCNICart({required this.isAdd, required this.id});
  @override
  List<Object> get props => [id, isAdd];
}

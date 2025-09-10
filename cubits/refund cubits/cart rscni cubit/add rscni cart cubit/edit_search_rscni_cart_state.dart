part of 'edit_search_rscni_cart_cubit.dart';

sealed class EditSearchRSCNICartState extends Equatable {
  const EditSearchRSCNICartState();

  @override
  List<Object> get props => [];
}

final class EditSearchRSCNICart extends EditSearchRSCNICartState {
  final int id;
  final bool isAdd;
  const EditSearchRSCNICart({required this.isAdd, required this.id});
  @override
  List<Object> get props => [id, isAdd];
}

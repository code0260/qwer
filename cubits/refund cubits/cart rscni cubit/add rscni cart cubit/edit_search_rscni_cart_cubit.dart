import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/model/cart%20models/sell_item_model.dart';
import 'package:equatable/equatable.dart';

part 'edit_search_rscni_cart_state.dart';

class EditSearchRSCNICartCubit extends SafeCubit<EditSearchRSCNICartState> {
  EditSearchRSCNICartCubit()
      : super(const EditSearchRSCNICart(id: -10, isAdd: false));
  void addProduct(int productsId) {
    SellItemModel sellItemModel = searchRSCNIData.firstWhere(
      (item) => item.getProductModel.productModel.productsId == productsId,
    );
    rSCNISearch.add(sellItemModel);
    emit(EditSearchRSCNICart(id: productsId, isAdd: true));
  }

  void deleteProduct(int productsId) {
    rSCNISearch.removeWhere(
      (item) => item.getProductModel.productModel.productsId == productsId,
    );
    emit(EditSearchRSCNICart(id: productsId, isAdd: false));
  }

  void editProduct(int productsId) {
    rSCNISearch.any(
      (item) => item.getProductModel.productModel.productsId == productsId,
    )
        ? deleteProduct(productsId)
        : addProduct(productsId);
  }

  @override
  Future<void> close() {
    rSCNISearch.clear();
    searchRSCNIData.clear();
    return super.close();
  }
}

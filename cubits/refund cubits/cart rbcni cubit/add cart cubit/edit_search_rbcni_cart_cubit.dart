import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/model/cart%20models/buy_item_model.dart';
import 'package:equatable/equatable.dart';

part 'edit_search_rbcni_cart_state.dart';

class EditSearchRBCNICartCubit extends SafeCubit<EditSearchRBCNICartState> {
  EditSearchRBCNICartCubit()
      : super(const EditSearchRBCNICart(id: -10, isAdd: false));
  void addProduct(int productsId) {
    BuyItemModel buyItemModel = searchRBCNIData.firstWhere(
      (item) => item.productModel.productsId == productsId,
    );
    rBCNISearch.add(buyItemModel);
    emit(EditSearchRBCNICart(id: productsId, isAdd: true));
  }

  void deleteProduct(int productsId) {
    rBCNISearch.removeWhere(
      (item) => item.productModel.productsId == productsId,
    );
    emit(EditSearchRBCNICart(id: productsId, isAdd: false));
  }

  void editProduct(int productsId) {
    rBCNISearch.any(
      (item) => item.productModel.productsId == productsId,
    )
        ? deleteProduct(productsId)
        : addProduct(productsId);
  }

  @override
  Future<void> close() {
    rBCNISearch.clear();
    searchRBCNIData.clear();
    return super.close();
  }
}

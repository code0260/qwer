import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/model/cart%20models/sell_item_model.dart';
import 'package:equatable/equatable.dart';

part 'edit_search_sell_cart_state.dart';

class EditSearchSellCartCubit extends SafeCubit<EditSearchSellCartState> {
  EditSearchSellCartCubit()
      : super(const EditSearchSellCart(id: -10, isAdd: false));
  void addProduct(int productsId) {
    SellItemModel sellItemModel = searchSellData.firstWhere(
      (item) => item.getProductModel.productModel.productsId == productsId,
    );
    cartSellSearch.add(sellItemModel);
    emit(EditSearchSellCart(id: productsId, isAdd: true));
  }

  void deleteProduct(int productsId) {
    cartSellSearch.removeWhere(
      (item) => item.getProductModel.productModel.productsId == productsId,
    );
    emit(EditSearchSellCart(id: productsId, isAdd: false));
  }

  void editProduct(int productsId) {
    cartSellSearch.any(
      (item) => item.getProductModel.productModel.productsId == productsId,
    )
        ? deleteProduct(productsId)
        : addProduct(productsId);
  }

  @override
  Future<void> close() {
    cartSellEditSearch.clear();
    searchSellEditData.clear();
    return super.close();
  }
}

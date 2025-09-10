import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/model/cart%20models/buy_item_model.dart';
import 'package:equatable/equatable.dart';

part 'edit_search_buy_cart_state.dart';

class EditSearchBuyCartCubit extends SafeCubit<EditSearchBuyCartState> {
  EditSearchBuyCartCubit()
      : super(const EditSearchBuyCart(id: -10, isAdd: false));
  void addProduct(int productsId) {
    BuyItemModel buyItemModel = searchBuyData.firstWhere(
      (item) => item.productModel.productsId == productsId,
    );
    cartBuySearch.add(buyItemModel);
    emit(EditSearchBuyCart(id: productsId, isAdd: true));
  }

  void deleteProduct(int productsId) {
    cartBuySearch.removeWhere(
      (item) => item.productModel.productsId == productsId,
    );
    emit(EditSearchBuyCart(id: productsId, isAdd: false));
  }

  void editProduct(int productsId) {
    cartBuySearch.any(
      (item) => item.productModel.productsId == productsId,
    )
        ? deleteProduct(productsId)
        : addProduct(productsId);
  }

  @override
  Future<void> close() {
    cartBuySearch.clear();
    searchBuyData.clear();
    return super.close();
  }
}

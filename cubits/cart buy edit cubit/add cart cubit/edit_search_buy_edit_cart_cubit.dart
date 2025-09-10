import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/model/cart%20models/buy_item_model.dart';
import 'package:equatable/equatable.dart';

part 'edit_search_buy_edit_cart_state.dart';

class EditSearchBuyEditCartCubit extends SafeCubit<EditSearchBuyEditCartState> {
  EditSearchBuyEditCartCubit()
      : super(const EditSearchBuyEditCart(id: -10, isAdd: false));
  void addProduct(int productsId) {
    BuyItemModel buyItemModel = searchBuyEditData.firstWhere(
      (item) => item.productModel.productsId == productsId,
    );
    cartBuyEditSearch.add(buyItemModel);
    emit(EditSearchBuyEditCart(id: productsId, isAdd: true));
  }

  void deleteProduct(int productsId) {
    cartBuyEditSearch.removeWhere(
      (item) => item.productModel.productsId == productsId,
    );
    emit(EditSearchBuyEditCart(id: productsId, isAdd: false));
  }

  void editProduct(int productsId) {
    cartBuyEditSearch.any(
      (item) => item.productModel.productsId == productsId,
    )
        ? deleteProduct(productsId)
        : addProduct(productsId);
  }

  @override
  Future<void> close() {
    cartBuyEditSearch.clear();
    searchBuyEditData.clear();
    return super.close();
  }
}

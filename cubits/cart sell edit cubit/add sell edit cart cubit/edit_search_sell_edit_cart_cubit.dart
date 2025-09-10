import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/model/cart%20models/sell_item_model.dart';
import 'package:equatable/equatable.dart';

part 'edit_search_sell_edit_cart_state.dart';

class EditSearchSellEditCartCubit
    extends SafeCubit<EditSearchSellEditCartState> {
  EditSearchSellEditCartCubit()
      : super(const EditSearchSellEditCart(id: -10, isAdd: false));
  void addProduct(int productsId) {
    SellItemModel sellItemModel = searchSellEditData.firstWhere(
      (item) => item.getProductModel.productModel.productsId == productsId,
    );
    cartSellEditSearch.add(sellItemModel);
    emit(EditSearchSellEditCart(id: productsId, isAdd: true));
  }

  void deleteProduct(int productsId) {
    cartSellEditSearch.removeWhere(
      (item) => item.getProductModel.productModel.productsId == productsId,
    );
    emit(EditSearchSellEditCart(id: productsId, isAdd: false));
  }

  void editProduct(int productsId) {
    cartSellEditSearch.any(
      (item) => item.getProductModel.productModel.productsId == productsId,
    )
        ? deleteProduct(productsId)
        : addProduct(productsId);
  }
}

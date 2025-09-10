import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/model/inventory%20adjustment%20models/inventory_adjustment_data_model.dart';
import 'package:equatable/equatable.dart';

part 'edit_search_inventory_adjustment_cart_state.dart';

class EditSearchInventoryAdjustmentCartCubit
    extends SafeCubit<EditSearchInventoryAdjustmentCartState> {
  EditSearchInventoryAdjustmentCartCubit()
      : super(const EditSearchInventoryAdjustmentCart(id: -10, isAdd: false));
  void addProduct(int productsId) {
    InventoryAdjustmentDataModel inventoryAdjustmentDataModel =
        searchInventoryAdjustmentData.firstWhere(
      (item) => item.productModel.productsId == productsId,
    );
    cartInventoryAdjustmentSearch.add(inventoryAdjustmentDataModel);
    emit(EditSearchInventoryAdjustmentCart(id: productsId, isAdd: true));
  }

  void deleteProduct(int productsId) {
    cartInventoryAdjustmentSearch.removeWhere(
      (item) => item.productModel.productsId == productsId,
    );
    emit(EditSearchInventoryAdjustmentCart(id: productsId, isAdd: false));
  }

  void editProduct(int productsId) {
    cartInventoryAdjustmentSearch.any(
      (item) => item.productModel.productsId == productsId,
    )
        ? deleteProduct(productsId)
        : addProduct(productsId);
  }

  @override
  Future<void> close() {
    cartInventoryAdjustmentSearch.clear();
    searchInventoryAdjustmentData.clear();
    return super.close();
  }
}

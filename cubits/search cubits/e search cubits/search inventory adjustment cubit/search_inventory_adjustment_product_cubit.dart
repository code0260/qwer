import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/repo/search%20repo/search%20product%20repo/search_product_repo.dart';
import 'package:almonazim/data/model/inventory%20adjustment%20models/inventory_adjustment_data_model.dart';
import 'package:almonazim/data/model/product%20models/product_model.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'search_inventory_adjustment_product_state.dart';

class SearchInventoryAdjustmentProductCubit
    extends SafeCubit<SearchInventoryAdjustmentProductState> {
  SearchInventoryAdjustmentProductCubit(this.searchRepo)
      : super(SearchInventoryAdjustmentProductInitial());
  SearchProductRepo searchRepo;

  Future<void> searchInventoryAdjustmentProduct(String searchQuery) async {
    searchInventoryAdjustmentData.clear();
    emit(SearchInventoryAdjustmentProductLoading());
    Either<Failure, List<InventoryAdjustmentDataModel>> result;
    result =
        await searchRepo.getInventoryAdjustmentProductsBySearch(searchQuery);
    result.fold((failure) {
      emit(SearchInventoryAdjustmentProductFailure(failure.errMessage));
    }, (inventoryAdjustmentItems) {
      List<ProductModel> cleanProduct = [];
      setProducts(inventoryAdjustmentItems, cleanProduct);
      emit(SearchInventoryAdjustmentProductSuccess(products: cleanProduct));
    });
  }

  void setProducts(List<InventoryAdjustmentDataModel> inventoryAdjustmentItems,
      List<ProductModel> cleanProduct) {
    for (final item in inventoryAdjustmentItems) {
      cleanProduct.add(item.productModel);
    }
    for (final entry in cartInventoryAdjustmentHome) {
      cleanProduct.removeWhere(
        (productModel) =>
            productModel.productsId == entry.productModel.productsId,
      );
    }
  }
}

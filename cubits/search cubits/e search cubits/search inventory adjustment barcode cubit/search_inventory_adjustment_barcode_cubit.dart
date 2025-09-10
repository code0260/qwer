import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/core/helper/functions/custom%20dialogs/show_same_inventory_adjustment_barcode_product_dialog.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/repo/search%20repo/search%20product%20repo/search_product_repo.dart';
import 'package:almonazim/data/model/inventory%20adjustment%20models/inventory_adjustment_data_model.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'search_inventory_adjustment_barcode_state.dart';

class SearchInventoryAdjustmentBarcodeCubit
    extends SafeCubit<SearchInventoryAdjustmentBarcodeState> {
  SearchInventoryAdjustmentBarcodeCubit(this.searchRepo)
      : super(SearchInventoryAdjustmentBarcodeInitial());
  SearchProductRepo searchRepo;

  Future<void> searchInventoryAdjustmentBarcode(String barcode) async {
    settingSearchData();
    Either<Failure, List<InventoryAdjustmentDataModel>> result;
    result =
        await searchRepo.getInventoryAdjustmentBarcodeProductsBySearch(barcode);

    result.fold((failure) {
      emit(SearchInventoryAdjustmentBarcodeFailure(failure.errMessage));
    }, (items) async {
      InventoryAdjustmentDataModel? selected = items.length == 1
          ? items[0]
          : await showSameInventoryAdjustmentBarcodeProductDialog(items);
      if (selected == null) {
        emit(const SearchInventoryAdjustmentBarcodeFailure(
            'لم يتم اختيار المنتج'));
        return;
      }
      cartInventoryAdjustmentHome.add(selected);
      emit(const SearchInventoryAdjustmentBarcodeSuccess());
    });
  }

  Future<void> go(String barcode) async {
    emit(SearchInventoryAdjustmentBarcodeLoading());
    int? productId;
    productId = checkBarcode(barcode, productId);
    if (productId != null) {
      emit(SearchInventoryAdjustmentBarcodeSuccess(productId: productId));
    } else {
      searchInventoryAdjustmentBarcode(barcode);
    }
  }

  int? checkBarcode(String barcode, int? productId) {
    for (final item in cartInventoryAdjustmentHome) {
      if (item.productModel.productsBarcode == barcode) {
        productId = item.productModel.productsId;
        if (item.inventoryAdjustmentItemInputModel
                .inventoryAdjustmentItemsCount ==
            null) {
          item.inventoryAdjustmentItemInputModel.inventoryAdjustmentItemsCount =
              1;
          item.inventoryAdjustmentItemInputModel
                  .inventoryAdjustmentItemsCountUnitId =
              item.productModel.productsBaseUnitId;
        } else {
          item.inventoryAdjustmentItemInputModel.inventoryAdjustmentItemsCount =
              item.inventoryAdjustmentItemInputModel
                      .inventoryAdjustmentItemsCount! +
                  1;
        }
      }
    }
    return productId;
  }

  void settingSearchData() {
    if (cartInventoryAdjustmentHome.isNotEmpty) {
      for (final entry in cartInventoryAdjustmentHome) {
        searchInventoryAdjustmentData.removeWhere(
          (searchedItem) =>
              searchedItem.productModel.productsId !=
              entry.productModel.productsId,
        );
      }
    } else {
      searchInventoryAdjustmentData.clear();
    }
  }
}

import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/core/helper/functions/custom%20dialogs/show_same_sell_barcode_product_dialog.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/locale/sqflite/store_products.dart';
import 'package:almonazim/data/data%20source/locale/store_work_offline.dart';
import 'package:almonazim/data/data%20source/repo/search%20repo/search%20product%20repo/search_product_repo.dart';
import 'package:almonazim/data/model/cart%20models/sell_item_model.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'search_sell_edit_barcode_state.dart';

class SearchSellEditBarcodeCubit extends SafeCubit<SearchSellEditBarcodeState> {
  SearchSellEditBarcodeCubit(this.searchRepo)
      : super(SearchSellEditBarcodeInitial());
  SearchProductRepo searchRepo;
  Future<void> searchSellEditBarcode(String barcode) async {
    settingSearchData();
    Either<Failure, List<SellItemModel>> result;
    if (StoreWorkOffline.getWorkOffline() == true) {
      result = await StoreProducts.searchSellBarcode(barcode);
    } else {
      result = await searchRepo.getSellBarcodeBySearch(barcode);
    }
    result.fold((failure) {
      emit(SearchSellEditBarcodeFailure(failure.errMessage));
    }, (items) async {
      SellItemModel? selected = items.length == 1
          ? items[0]
          : await showSameSellBarcodeProductDialog(items);
      if (selected == null) {
        emit(const SearchSellEditBarcodeFailure('لم يتم اختيار المنتج'));
        return;
      }
      cartSellEditHome.add(selected);
      emit(const SearchSellEditBarcodeSuccess());
    });
  }

  Future<void> go(String barcode) async {
    emit(SearchSellEditBarcodeLoading());
    int? productId;
    productId = checkBarcode(barcode, productId);
    if (productId != null) {
      emit(SearchSellEditBarcodeSuccess(productId: productId));
    } else {
      searchSellEditBarcode(barcode);
    }
  }

  int? checkBarcode(String barcode, int? productId) {
    for (final item in cartSellEditHome) {
      if (item.getProductModel.productModel.productsBarcode == barcode) {
        productId = item.getProductModel.productModel.productsId;
        item.productCount += 1;
      }
    }
    return productId;
  }

  void settingSearchData() {
    if (cartSellEditHome.isNotEmpty) {
      for (final entry in cartSellEditHome) {
        searchSellEditData.removeWhere(
          (searchedItem) =>
              searchedItem.getProductModel.productModel.productsId !=
              entry.getProductModel.productModel.productsId,
        );
      }
    } else {
      searchSellEditData.clear();
    }
  }
}

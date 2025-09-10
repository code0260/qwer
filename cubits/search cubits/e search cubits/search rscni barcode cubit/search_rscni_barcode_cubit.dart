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

part 'search_rscni_barcode_state.dart';

class SearchRSCNIBarcodeCubit extends SafeCubit<SearchRSCNIBarcodeState> {
  SearchRSCNIBarcodeCubit(this.searchRepo) : super(SearchRSCNIBarcodeInitial());
  SearchProductRepo searchRepo;
  Future<void> searchRSCNIBarcode(String barcode) async {
    settingSearchData();
    Either<Failure, List<SellItemModel>> result;
    if (StoreWorkOffline.getWorkOffline() == true) {
      result = await StoreProducts.searchSellBarcode(barcode);
    } else {
      result = await searchRepo.getRSCNIProductsBySearch(null, barcode);
    }
    result.fold((failure) {
      emit(SearchRSCNIBarcodeFailure(failure.errMessage));
    }, (items) async {
      SellItemModel? selected = items.length == 1
          ? items[0]
          : await showSameSellBarcodeProductDialog(items);
      if (selected == null) {
        emit(const SearchRSCNIBarcodeFailure('لم يتم اختيار المنتج'));
        return;
      }
      rSCNIHome.add(selected);
      emit(const SearchRSCNIBarcodeSuccess());
    });
  }

  Future<void> go(String barcode) async {
    emit(SearchRSCNIBarcodeLoading());
    int? productId;
    productId = checkBarcode(barcode, productId);
    if (productId != null) {
      emit(SearchRSCNIBarcodeSuccess(productId: productId));
    } else {
      searchRSCNIBarcode(barcode);
    }
  }

  int? checkBarcode(String barcode, int? productId) {
    for (final item in rSCNIHome) {
      if (item.getProductModel.productModel.productsBarcode == barcode) {
        productId = item.getProductModel.productModel.productsId;
        item.productCount += 1;
      }
    }
    return productId;
  }

  void settingSearchData() {
    if (rSCNIHome.isNotEmpty) {
      for (final entry in rSCNIHome) {
        searchRSCNIData.removeWhere(
          (searchedItem) =>
              searchedItem.getProductModel.productModel.productsId !=
              entry.getProductModel.productModel.productsId,
        );
      }
    } else {
      searchRSCNIData.clear();
    }
  }
}

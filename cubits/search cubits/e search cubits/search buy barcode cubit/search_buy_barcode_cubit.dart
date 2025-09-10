import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/core/helper/functions/custom%20dialogs/show_same_buy_barcode_product_dialog.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/locale/sqflite/store_products.dart';
import 'package:almonazim/data/data%20source/locale/store_work_offline.dart';
import 'package:almonazim/data/data%20source/repo/search%20repo/search%20product%20repo/search_product_repo.dart';
import 'package:almonazim/data/model/cart%20models/buy_item_model.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'search_buy_barcode_state.dart';

class SearchBuyBarcodeCubit extends SafeCubit<SearchBuyBarcodeState> {
  SearchBuyBarcodeCubit(this.searchRepo) : super(SearchBuyBarcodeInitial());
  SearchProductRepo searchRepo;
  Future<void> searchBuyBarcode(String barcode) async {
    settingSearchData();
    Either<Failure, List<BuyItemModel>> result;
    if (StoreWorkOffline.getWorkOffline() == true) {
      result = await StoreProducts.searchBuyBarcode(barcode);
    } else {
      result = await searchRepo.getBuyBarcodeBySearch(barcode);
    }
    result.fold((failure) {
      emit(SearchBuyBarcodeFailure(failure.errMessage));
    }, (items) async {
      BuyItemModel? selected = items.length == 1
          ? items[0]
          : await showSameBuyBarcodeProductDialog(items);
      if (selected == null) {
        emit(const SearchBuyBarcodeFailure('لم يتم اختيار المنتج'));
        return;
      }
      cartBuyHome.add(selected);
      emit(const SearchBuyBarcodeSuccess());
    });
  }

  Future<void> go(String barcode) async {
    emit(SearchBuyBarcodeLoading());
    int? productId;
    productId = checkBarcode(barcode, productId);
    if (productId != null) {
      emit(SearchBuyBarcodeSuccess(productId: productId));
    } else {
      searchBuyBarcode(barcode);
    }
  }

  int? checkBarcode(String barcode, int? productId) {
    for (final item in cartBuyHome) {
      if (item.productModel.productsBarcode == barcode) {
        productId = item.productModel.productsId;
        if (item.batchModel.batchesProductsTotalCount == null) {
          item.batchModel.batchesProductsTotalCount = 1;
          item.batchModel.batchesCountUnitId =
              item.productModel.productsBaseUnitId;
        } else {
          item.batchModel.batchesProductsTotalCount =
              item.batchModel.batchesProductsTotalCount! + 1;
        }
      }
    }
    return productId;
  }

  void settingSearchData() {
    if (cartBuyHome.isNotEmpty) {
      for (final entry in cartBuyHome) {
        searchBuyData.removeWhere(
          (searchedItem) =>
              searchedItem.productModel.productsId !=
              entry.productModel.productsId,
        );
      }
    } else {
      searchBuyData.clear();
    }
  }
}

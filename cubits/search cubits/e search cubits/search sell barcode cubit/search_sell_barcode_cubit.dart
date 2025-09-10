import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/core/helper/functions/custom%20dialogs/show_same_sell_barcode_product_dialog.dart';
import 'package:almonazim/core/helper/functions/is_bigger_than_remaining.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/locale/sqflite/store_products.dart';
import 'package:almonazim/data/data%20source/locale/store_work_offline.dart';
import 'package:almonazim/data/data%20source/repo/search%20repo/search%20product%20repo/search_product_repo.dart';
import 'package:almonazim/data/model/cart%20models/sell_item_model.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'search_sell_barcode_state.dart';

class SearchSellBarcodeCubit extends SafeCubit<SearchSellBarcodeState> {
  SearchSellBarcodeCubit(this.searchRepo) : super(SearchSellBarcodeInitial());
  SearchProductRepo searchRepo;
  Future<void> searchSellBarcode(String barcode) async {
    settingSearchData();
    Either<Failure, List<SellItemModel>> result;
    if (StoreWorkOffline.getWorkOffline() == true) {
      result = await StoreProducts.searchSellBarcode(barcode);
    } else {
      result = await searchRepo.getSellBarcodeBySearch(barcode);
    }
    result.fold((failure) {
      emit(SearchSellBarcodeFailure(failure.errMessage));
    }, (items) async {
      SellItemModel? selected = items.length == 1
          ? items[0]
          : await showSameSellBarcodeProductDialog(items);
      if (selected == null) {
        emit(const SearchSellBarcodeFailure('لم يتم اختيار المنتج'));
        return;
      }
      cartSellHome.add(selected);
      emit(const SearchSellBarcodeSuccess());
    });
  }

  Future<void> go(String barcode, double currentUnitConversion) async {
    emit(SearchSellBarcodeLoading());
    int? productId;
    productId = checkBarcode(barcode, productId, currentUnitConversion);
    if (productId != 0 && productId != null) {
      emit(SearchSellBarcodeSuccess(productId: productId));
    } else if (productId == 0) {
      emit(const SearchSellBarcodeFailure('لا يوجد كمية كافية في هذا المكان'));
    } else if (productId == null) {
      searchSellBarcode(barcode);
    }
  }

  int? checkBarcode(
      String barcode, int? productId, double currentUnitConversion) {
    double count = 1;
    for (final item in cartSellHome) {
      if (item.getProductModel.productModel.productsBarcode == barcode) {
        productId = item.getProductModel.productModel.productsId!;
        double currentTotalCount = item.productCount + count;
        if (StoreWorkOffline.getWorkOffline() == false) {
          if (isBiggerThanRemaining(productId, currentTotalCount,
              currentUnitConversion.toDouble(), cartSellHome,
              useAllExistedPlaces: true)) {
            return 0;
          } else {
            item.productCount = currentTotalCount;
            count = currentTotalCount;
            break;
          }
        } else {
          item.productCount = currentTotalCount;
          count = currentTotalCount;
          break;
        }
      }
    }
    return productId;
  }

  void settingSearchData() {
    if (cartSellHome.isNotEmpty) {
      for (final entry in cartSellHome) {
        searchSellData.removeWhere(
          (searchedItem) =>
              searchedItem.getProductModel.productModel.productsId !=
              entry.getProductModel.productModel.productsId,
        );
      }
    } else {
      searchSellData.clear();
    }
  }
}

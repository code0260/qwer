import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/locale/sqflite/store_products.dart';
import 'package:almonazim/data/data%20source/locale/store_work_offline.dart';
import 'package:almonazim/data/data%20source/repo/search%20repo/search%20product%20repo/search_product_repo.dart';
import 'package:almonazim/data/model/cart%20models/buy_item_model.dart';
import 'package:almonazim/data/model/product%20models/product_model.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'search_buy_product_state.dart';

class SearchBuyProductCubit extends SafeCubit<SearchBuyProductState> {
  SearchBuyProductCubit(this.searchRepo) : super(SearchBuyProductInitial());
  SearchProductRepo searchRepo;
  Future<void> searchBuyProduct(String searchQuery) async {
    settingSearchData();
    emit(SearchBuyProductLoading());
    Either<Failure, List<BuyItemModel>> result;
    if (StoreWorkOffline.getWorkOffline() == true) {
      result = await StoreProducts.searchBuyProducts(searchQuery);
    } else {
      result = await searchRepo.getBuyProductsBySearch(searchQuery);
    }
    result.fold((failure) {
      emit(SearchBuyProductFailure(failure.errMessage));
    }, (buyItems) {
      List<ProductModel> cleanProduct = [];
      setProducts(buyItems, cleanProduct);
      emit(SearchBuyProductSuccess(products: cleanProduct));
    });
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

  void setProducts(
      List<BuyItemModel> buyItems, List<ProductModel> cleanProduct) {
    for (final item in buyItems) {
      cleanProduct.add(item.productModel);
    }
    for (final entry in cartBuyHome) {
      cleanProduct.removeWhere(
        (productModel) =>
            productModel.productsId == entry.productModel.productsId,
      );
    }
  }
}

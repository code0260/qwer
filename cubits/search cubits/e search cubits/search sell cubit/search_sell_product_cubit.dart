import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/locale/sqflite/store_products.dart';
import 'package:almonazim/data/data%20source/locale/store_work_offline.dart';
import 'package:almonazim/data/data%20source/repo/search%20repo/search%20product%20repo/search_product_repo.dart';
import 'package:almonazim/data/model/product%20models/get_product_model.dart';
import 'package:almonazim/data/model/cart%20models/sell_item_model.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'search_sell_product_state.dart';

class SearchSellProductCubit extends SafeCubit<SearchSellProductState> {
  SearchSellProductCubit(this.searchRepo) : super(SearchSellProductInitial());
  SearchProductRepo searchRepo;
  Future<void> searchSellProduct(String searchQuery) async {
    searchSellData.clear();
    emit(SearchSellProductLoading());
    Either<Failure, List<SellItemModel>> result;
    if (StoreWorkOffline.getWorkOffline() == true) {
      result = await StoreProducts.searchSellProducts(searchQuery);
    } else {
      result = await searchRepo.getSellProductsBySearch(searchQuery);
    }
    result.fold((failure) {
      emit(SearchSellProductFailure(failure.errMessage));
    }, (sellItems) {
      List<GetProductModel> cleanProduct = [];
      setProducts(sellItems, cleanProduct);
      emit(SearchSellProductSuccess(products: cleanProduct));
    });
  }

  void setProducts(
      List<SellItemModel> sellItems, List<GetProductModel> cleanProduct) {
    for (final item in sellItems) {
      cleanProduct.add(item.getProductModel);
    }
    for (final entry in cartSellHome) {
      cleanProduct.removeWhere(
        (getProductModel) =>
            getProductModel.productModel.productsId ==
            entry.getProductModel.productModel.productsId,
      );
    }
  }
}

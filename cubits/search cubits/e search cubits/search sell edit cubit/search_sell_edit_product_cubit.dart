import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/repo/search%20repo/search%20product%20repo/search_product_repo.dart';
import 'package:almonazim/data/model/product%20models/get_product_model.dart';
import 'package:almonazim/data/model/cart%20models/sell_item_model.dart';
import 'package:equatable/equatable.dart';

part 'search_sell_edit_product_state.dart';

class SearchSellEditProductCubit extends SafeCubit<SearchSellEditProductState> {
  SearchSellEditProductCubit(this.searchRepo)
      : super(SearchSellEditProductInitial());
  SearchProductRepo searchRepo;
  Future<void> searchSellEditProduct(String searchQuery) async {
    searchSellEditData.clear();
    emit(SearchSellEditProductLoading());
    var result = await searchRepo.getSellEditProductsBySearch(searchQuery);
    result.fold((failure) {
      emit(SearchSellEditProductFailure(failure.errMessage));
    }, (sellItems) {
      List<GetProductModel> cleanProduct = [];
      setProducts(sellItems, cleanProduct);
      emit(SearchSellEditProductSuccess(products: cleanProduct));
    });
  }

  void setProducts(
      List<SellItemModel> sellItems, List<GetProductModel> cleanProduct) {
    for (final item in sellItems) {
      cleanProduct.add(item.getProductModel);
    }
    for (final entry in cartSellEditHome) {
      cleanProduct.removeWhere(
        (getProductModel) =>
            getProductModel.productModel.productsId ==
                entry.getProductModel.productModel.productsId ||
            getProductModel.prices.isEmpty,
      );
    }
  }
}

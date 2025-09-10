import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/repo/search%20repo/search%20product%20repo/search_product_repo.dart';
import 'package:almonazim/data/model/cart%20models/buy_item_model.dart';
import 'package:almonazim/data/model/product%20models/product_model.dart';
import 'package:equatable/equatable.dart';

part 'search_buy_edit_product_state.dart';

class SearchBuyEditProductCubit extends SafeCubit<SearchBuyEditProductState> {
  SearchBuyEditProductCubit(this.searchRepo)
      : super(SearchBuyEditProductInitial());
  SearchProductRepo searchRepo;
  Future<void> searchBuyEditProduct(String searchQuery) async {
    settingSearchData();
    emit(SearchBuyEditProductLoading());
    var result = await searchRepo.getBuyEditProductsBySearch(searchQuery);
    result.fold((failure) {
      emit(SearchBuyEditProductFailure(failure.errMessage));
    }, (buyItems) {
      List<ProductModel> cleanProduct = [];
      setProducts(buyItems, cleanProduct);
      emit(SearchBuyEditProductSuccess(products: cleanProduct));
    });
  }

  void settingSearchData() {
    if (cartBuyEditHome.isNotEmpty) {
      for (final entry in cartBuyEditHome) {
        searchBuyEditData.removeWhere(
          (searchedItem) =>
              searchedItem.productModel.productsId !=
              entry.productModel.productsId,
        );
      }
    } else {
      searchBuyEditData.clear();
    }
  }

  void setProducts(
      List<BuyItemModel> buyItems, List<ProductModel> cleanProduct) {
    for (final item in buyItems) {
      cleanProduct.add(item.productModel);
    }
    for (final entry in cartBuyEditHome) {
      cleanProduct.removeWhere(
        (productModel) =>
            productModel.productsId == entry.productModel.productsId,
      );
    }
  }
}

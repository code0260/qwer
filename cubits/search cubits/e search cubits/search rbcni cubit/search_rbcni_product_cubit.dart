import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/repo/search%20repo/search%20product%20repo/search_product_repo.dart';
import 'package:almonazim/data/model/cart%20models/buy_item_model.dart';
import 'package:almonazim/data/model/product%20models/product_model.dart';
import 'package:equatable/equatable.dart';

part 'search_rbcni_product_state.dart';

class SearchRBCNIProductCubit extends SafeCubit<SearchRBCNIProductState> {
  SearchRBCNIProductCubit(this.searchRepo) : super(SearchRBCNIProductInitial());
  SearchProductRepo searchRepo;
  Future<void> searchRBCNIProduct(String searchQuery) async {
    settingSearchData();
    emit(SearchRBCNIProductLoading());
    var result = await searchRepo.getRBCNIProductsBySearch(searchQuery);
    result.fold((failure) {
      emit(SearchRBCNIProductFailure(failure.errMessage));
    }, (buyItems) {
      List<ProductModel> cleanProduct = [];
      setProducts(buyItems, cleanProduct);
      emit(SearchRBCNIProductSuccess(products: cleanProduct));
    });
  }

  void settingSearchData() {
    if (rBCNIHome.isNotEmpty) {
      for (final entry in rBCNIHome) {
        searchRBCNIData.removeWhere(
          (searchedItem) =>
              searchedItem.productModel.productsId !=
              entry.productModel.productsId,
        );
      }
    } else {
      searchRBCNIData.clear();
    }
  }

  void setProducts(
      List<BuyItemModel> buyItems, List<ProductModel> cleanProduct) {
    for (final item in buyItems) {
      cleanProduct.add(item.productModel);
    }
    for (final entry in rBCNIHome) {
      cleanProduct.removeWhere(
        (productModel) =>
            productModel.productsId == entry.productModel.productsId,
      );
    }
  }
}

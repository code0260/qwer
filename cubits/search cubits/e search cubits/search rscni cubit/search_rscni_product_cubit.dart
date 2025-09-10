import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/repo/search%20repo/search%20product%20repo/search_product_repo.dart';
import 'package:almonazim/data/model/cart%20models/sell_item_model.dart';
import 'package:almonazim/data/model/product%20models/get_product_model.dart';
import 'package:equatable/equatable.dart';

part 'search_rscni_product_state.dart';

class SearchRSCNIProductCubit extends SafeCubit<SearchRSCNIProductState> {
  SearchRSCNIProductCubit(this.searchRepo) : super(SearchRSCNIProductInitial());
  SearchProductRepo searchRepo;
  Future<void> searchRSCNIProduct(String searchQuery) async {
    settingSearchData();
    emit(SearchRSCNIProductLoading());
    var result = await searchRepo.getRSCNIProductsBySearch(searchQuery, null);
    result.fold((failure) {
      emit(SearchRSCNIProductFailure(failure.errMessage));
    }, (buyItems) {
      List<GetProductModel> cleanProduct = [];
      setProducts(buyItems, cleanProduct);
      emit(SearchRSCNIProductSuccess(products: cleanProduct));
    });
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

  void setProducts(
      List<SellItemModel> buyItems, List<GetProductModel> cleanProduct) {
    for (final item in buyItems) {
      cleanProduct.add(item.getProductModel);
    }
    for (final entry in rSCNIHome) {
      cleanProduct.removeWhere(
        (getProductModel) =>
            getProductModel.productModel.productsId ==
            entry.getProductModel.productModel.productsId,
      );
    }
  }
}

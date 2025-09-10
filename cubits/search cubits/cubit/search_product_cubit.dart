import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/search%20repo/search%20product%20repo/search_product_repo.dart';
import 'package:almonazim/data/model/product%20models/product_input_model.dart';
import 'package:almonazim/data/model/product%20models/product_model.dart';
import 'package:equatable/equatable.dart';

part 'search_product_state.dart';

class SearchProductCubit extends SafeCubit<SearchProductState> {
  SearchProductCubit(this.searchRepo) : super(SearchProductInitial());
  SearchProductRepo searchRepo;
  ProductInputModel productInputModel = ProductInputModel();
  Future<void> searchProduct() async {
    emit(SearchProductLoading());
    var result = await searchRepo.getProducts(productInputModel);
    result.fold((failure) {
      emit(SearchProductFailure(failure.errMessage));
    }, (products) {
      emit(SearchProductSuccess(products: products));
    });
  }
}

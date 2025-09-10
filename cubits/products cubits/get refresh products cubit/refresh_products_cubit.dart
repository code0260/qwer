import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/product%20repo/product_repo_imp.dart';
import 'package:equatable/equatable.dart';

part 'refresh_products_state.dart';

class RefreshProductCubit extends SafeCubit<RefreshProductState> {
  RefreshProductCubit(this.productRepo) : super(RefreshProductInitial());
  ProductsRepoImpl productRepo;
  Future<void> refreshProducts() async {
    emit(RefreshProductLoading());
    var result = await productRepo.refreshProducts();
    result.fold((failure) {
      emit(RefreshProductFailure(failure.errMessage));
    }, (_) {
      emit(RefreshProductSuccess());
    });
  }
}

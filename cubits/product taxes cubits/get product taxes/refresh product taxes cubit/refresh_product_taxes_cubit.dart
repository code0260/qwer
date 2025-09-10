import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/product%20taxes%20repo/product_taxes_repo_imp.dart';
import 'package:equatable/equatable.dart';

part 'refresh_product_taxes_state.dart';

class RefreshProductTaxesCubit extends SafeCubit<RefreshProductTaxesState> {
  RefreshProductTaxesCubit(this.productTaxesRepo)
      : super(RefreshProductTaxesInitial());
  ProductTaxesRepoImpl productTaxesRepo;
  Future<void> refreshProductTaxes() async {
    emit(RefreshProductTaxesLoading());
    var result = await productTaxesRepo.getAllProductTaxes();
    result.fold((failure) {
      emit(RefreshProductTaxesFailure(failure.errMessage));
    }, (_) {
      emit(RefreshProductTaxesSuccess());
    });
  }
}

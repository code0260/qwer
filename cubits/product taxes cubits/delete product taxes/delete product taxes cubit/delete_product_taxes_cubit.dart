import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/product%20taxes%20repo/product_taxes_repo_imp.dart';
import 'package:equatable/equatable.dart';

part 'delete_product_taxes_state.dart';

class DeleteProductTaxCubit extends SafeCubit<DeleteProductTaxState> {
  DeleteProductTaxCubit(this.productTaxesRepo)
      : super(DeleteProductTaxInitial());
  ProductTaxesRepoImpl productTaxesRepo;
  Future<void> deleteProductTax(int productsTaxesId) async {
    emit(DeleteProductTaxLoading());
    var result = await productTaxesRepo.deleteProductTax(productsTaxesId);
    result.fold((failure) {
      emit(DeleteProductTaxFailure(errorMessage: failure.errMessage));
    }, (message) {
      emit(DeleteProductTaxSuccess());
    });
  }
}

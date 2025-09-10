import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/product%20taxes%20repo/product_taxes_repo_imp.dart';
import 'package:almonazim/data/model/taxes%20models/product_tax_model.dart';
import 'package:equatable/equatable.dart';

part 'get_product_taxes_state.dart';

class GetProductTaxesCubit extends SafeCubit<GetProductTaxesState> {
  GetProductTaxesCubit(this.taxRepo) : super(GetProductTaxesInitial());
  ProductTaxesRepoImpl taxRepo;
  Future<void> getProductTaxes({int? productsId}) async {
    emit(GetProductTaxesLoading());
    var result = await taxRepo.getProductTaxes(productsId);
    result.fold((failure) {
      emit(GetProductTaxesFailure(failure.errMessage));
    }, (taxes) {
      emit(GetProductTaxesSuccess(taxes: taxes));
    });
  }
}

import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/product%20taxes%20repo/product_taxes_repo.dart';
import 'package:almonazim/data/model/taxes%20models/product_taxes_input_model.dart';
import 'package:equatable/equatable.dart';

part 'edit_product_tax_state.dart';

class EditProductTaxCubit extends SafeCubit<EditProductTaxState> {
  EditProductTaxCubit(this.taxRepo) : super(EditProductTaxInitial());
  ProductTaxesRepo taxRepo;
  ProductTaxesInputModel taxInputModel = ProductTaxesInputModel();
  Future<void> editProductTax() async {
    emit(EditProductTaxLoading());
    var result = await taxRepo.editProductTax(taxInputModel);
    result.fold((failure) {
      emit(EditProductTaxFailure(failure.errMessage));
    }, (_) {
      emit(EditProductTaxSuccess());
    });
  }

  String? get validateProductTaxDataMessage {
    if (taxInputModel.productTaxesApplicationLevel == null ||
        taxInputModel.productTaxesApplicationLevel!.isEmpty) {
      return "الرجاء اختيار مستوى تطبيق الضريبة";
    } else if (taxInputModel.productTaxesOrder == null) {
      return "الرجاء إدخال ترتيب الضريبة";
    } else {
      return null; // All fields are valid
    }
  }
}

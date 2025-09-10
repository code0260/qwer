import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/product%20taxes%20repo/product_taxes_repo.dart';
import 'package:almonazim/data/model/taxes%20models/product_taxes_input_model.dart';
import 'package:equatable/equatable.dart';

part 'add_product_tax_state.dart';

class AddProductTaxCubit extends SafeCubit<AddProductTaxState> {
  AddProductTaxCubit(this.taxRepo) : super(AddProductTaxInitial());
  ProductTaxesRepo taxRepo;
  ProductTaxesInputModel taxInputModel = ProductTaxesInputModel();
  Future<void> addProductTax() async {
    emit(AddProductTaxLoading());
    var result = await taxRepo.addProductTax(taxInputModel);
    result.fold((failure) {
      emit(AddProductTaxFailure(failure.errMessage));
    }, (_) {
      emit(const AddProductTaxSuccess());
    });
  }

  String? get validateProductTaxDataMessage {
    if (taxInputModel.productTaxesTaxId == null) {
      return "الرجاء اختيار الضريبة";
    } else if (taxInputModel.productTaxesApplicationLevel == null ||
        taxInputModel.productTaxesApplicationLevel!.isEmpty) {
      return "الرجاء اختيار مستوى تطبيق الضريبة";
    } else if (taxInputModel.productTaxesOrder == null) {
      return "الرجاء إدخال ترتيب الضريبة";
    } else {
      return null; // All fields are valid
    }
  }
}

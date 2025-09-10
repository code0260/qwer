import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/product%20repo/product_repo_imp.dart';
import 'package:almonazim/data/model/product%20models/product_input_model.dart';
import 'package:equatable/equatable.dart';

part 'edit_product_state.dart';

class EditProductCubit extends SafeCubit<EditProductState> {
  EditProductCubit(this.productRepo) : super(EditProductInitial());
  ProductsRepoImpl productRepo;

  ProductInputModel productInputModel = ProductInputModel();

  Future<void> editProduct() async {
    emit(EditProductLoading());
    var result = await productRepo.editProduct(productInputModel);
    result.fold((failure) {
      emit(EditProductFailure(errorMessage: failure.errMessage));
    }, (_) {
      emit(const EditProductSuccess());
    });
  }

  String? get validateDataMessage {
    if (productInputModel.productsName == null ||
        productInputModel.productsName!.isEmpty) {
      return "الرجاء إدخال اسم المنتج";
    } else if (productInputModel.productsCategories == null) {
      return "الرجاء اختيار فئة المنتج";
    } else {
      return null;
    }
  }
}

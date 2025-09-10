import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/product%20place%20repo/product_place_repo.dart';
import 'package:almonazim/data/model/place%20models/product_place_input_model.dart';
import 'package:almonazim/data/model/product%20place%20models/edit_product_count_model.dart';
import 'package:equatable/equatable.dart';

part 'edit_product_count_state.dart';

class EditProductCountCubit extends SafeCubit<EditProductCountState> {
  EditProductCountCubit(this.productPlaceRepo)
      : super(EditProductCountInitial());
  ProductPlaceRepo productPlaceRepo;
  EditProductCountModel editProductCountModel = EditProductCountModel(
    productPlaceModel: ProductPlaceInputModel(),
  );
  Future<void> editProductCount() async {
    emit(EditProductCountLoading());
    var result = await productPlaceRepo.editProductCount(editProductCountModel);
    result.fold((failure) {
      emit(EditProductCountFailure(failure.errMessage));
    }, (_) {
      emit(const EditProductCountSuccess());
    });
  }

  String? get validateDataMessage {
    if (editProductCountModel.productPlaceModel.productPlacesProductsId ==
        null) {
      return "الرجاء اختيار المنتج";
    } else if (editProductCountModel.productPlaceModel.productPlacesCount ==
            null ||
        editProductCountModel.productPlaceModel.productPlacesCount! < 0) {
      return "الرجاء إدخال كمية المنتج بشكل صحيح";
    } else if (editProductCountModel
            .productPlaceModel.productPlacesCountUnitId ==
        null) {
      return "الرجاء اختيار وحدة قياس الكمية";
    } else if (editProductCountModel.reason == null ||
        editProductCountModel.reason!.isEmpty) {
      return "الرجاء اخيار السبب";
    } else {
      return null;
    }
  }
}

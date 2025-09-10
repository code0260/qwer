import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/inventory%20repo/inventory_repo_imp.dart';
import 'package:almonazim/data/model/inventory%20models/stock_input_model.dart';
import 'package:equatable/equatable.dart';

part 'edit_reorder_point _state.dart';

class EditReorderPointCubit extends SafeCubit<EditReorderPointState> {
  EditReorderPointCubit(this.inventoryRepo) : super(EditReorderPointInitial());
  InventoryRepoImpl inventoryRepo;
  StockInputModel stockInputModel = StockInputModel();

  Future<void> editReorderPoint() async {
    emit(EditReorderPointLoading());
    var result = await inventoryRepo.editReorderPoint(stockInputModel);
    result.fold((failure) {
      emit(EditReorderPointFailure(failure.errMessage));
    }, (_) {
      emit(EditReorderPointSuccess());
    });
  }

  String? get validateReorderPointDataMessage {
    if (stockInputModel.stockReorderPoint == null) {
      return "الرجاء إدخال الكمية";
    } else if (stockInputModel.stockReorderPointUnitId == null) {
      return "الرجاء اختيار الواحدة";
    } else {
      return null; // All fields are valid
    }
  }
}

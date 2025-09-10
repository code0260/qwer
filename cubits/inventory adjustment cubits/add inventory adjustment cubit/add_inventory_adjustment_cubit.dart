import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/inventory%20adjustment%20repo/inventory_adjustment_repo_imp.dart';
import 'package:almonazim/data/model/inventory%20adjustment%20models/inventory_adjustment_all_data_model.dart';
import 'package:equatable/equatable.dart';

part 'add_inventory_adjustment_state.dart';

class AddInventoryAdjustmentCubit
    extends SafeCubit<AddInventoryAdjustmentState> {
  AddInventoryAdjustmentCubit(this.accountRepo)
      : super(AddInventoryAdjustmentInitial());
  InventoryAdjustmentRepoImpl accountRepo;

  Future<void> addInventoryAdjustment(
      InventoryAdjustmentAllDataModel inventoryAdjustmentAllDataModel) async {
    emit(AddInventoryAdjustmentLoading());
    var result = await accountRepo
        .addInventoryAdjustment(inventoryAdjustmentAllDataModel);
    result.fold((failure) {
      emit(AddInventoryAdjustmentFailure(failure.errMessage));
    }, (_) {
      emit(const AddInventoryAdjustmentSuccess());
    });
  }
}

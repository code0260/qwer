import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/inventory%20adjustment%20repo/inventory_adjustment_repo_imp.dart';
import 'package:almonazim/data/model/inventory%20adjustment%20models/get_inventory_adjustment_input_model.dart';
import 'package:almonazim/data/model/inventory%20adjustment%20models/inventory_adjustment_model.dart';
import 'package:equatable/equatable.dart';

part 'get_inventory_adjustment_state.dart';

class GetInventoryAdjustmentCubit
    extends SafeCubit<GetInventoryAdjustmentState> {
  GetInventoryAdjustmentCubit(this.invoiceRepo)
      : super(GetInventoryAdjustmentInitial());
  InventoryAdjustmentRepoImpl invoiceRepo;
  GetInventoryAdjustmentInputModel filterModel =
      GetInventoryAdjustmentInputModel(
          startDate: DateTime.now().subtract(const Duration(days: 30)),
          endDate: DateTime.now());

  Future<void> getInventoryAdjustment() async {
    emit(GetInventoryAdjustmentLoading());
    var result = await invoiceRepo.getInventoryAdjustment(filterModel);
    result.fold((failure) {
      emit(GetInventoryAdjustmentFailure(failure.errMessage));
    }, (invoices) {
      emit(GetInventoryAdjustmentSuccess(inventoryAdjustments: invoices));
    });
  }

  Future<void> refreshInventoryAdjustments() async {
    emit(GetInventoryAdjustmentLoading());
    filterModel = GetInventoryAdjustmentInputModel(
      startDate: DateTime.now().subtract(const Duration(days: 1)),
      endDate: DateTime.now(),
    );
    var result = await invoiceRepo.getInventoryAdjustment(filterModel);
    result.fold((failure) {
      emit(GetInventoryAdjustmentFailure(failure.errMessage));
    }, (invoices) {
      emit(GetInventoryAdjustmentSuccess(inventoryAdjustments: invoices));
    });
  }

  Future<void> getInventoryAdjustmentByNumber(
      String inventoryAdjustmentNumber) async {
    emit(GetInventoryAdjustmentLoading());
    var result = await invoiceRepo
        .getInventoryAdjustmentByNumber(inventoryAdjustmentNumber);
    result.fold((failure) {
      emit(GetInventoryAdjustmentFailure(failure.errMessage));
    }, (invoices) {
      emit(GetInventoryAdjustmentSuccess(inventoryAdjustments: invoices));
    });
  }
}

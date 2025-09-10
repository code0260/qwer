import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/inventory%20adjustment%20repo/inventory_adjustment_repo_imp.dart';
import 'package:almonazim/data/model/inventory%20adjustment%20models/get_inventory_adjustment_items_model.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'get_inventory_adjustment_items_state.dart';

class GetInventoryAdjustmentItemsCubit
    extends SafeCubit<GetInventoryAdjustmentItemsState> {
  GetInventoryAdjustmentItemsCubit(this.invoiceItemsRepo)
      : super(GetInventoryAdjustmentItemsInitial());
  InventoryAdjustmentRepoImpl invoiceItemsRepo;

  Future<void> getInventoryAdjustmentItems(int inventoryAdjustmentId) async {
    emit(GetInventoryAdjustmentItemsLoading());
    Either<Failure, GetInventoryAdjustmentItemModel> result;
    result = await invoiceItemsRepo
        .getInventoryAdjustmentItems(inventoryAdjustmentId);

    result.fold((failure) {
      emit(GetInventoryAdjustmentItemsFailure(failure.errMessage));
    }, (getInventoryAdjustmentItemModel) {
      emit(GetInventoryAdjustmentItemsSuccess(
          getInventoryAdjustmentItemModel: getInventoryAdjustmentItemModel));
    });
  }
}

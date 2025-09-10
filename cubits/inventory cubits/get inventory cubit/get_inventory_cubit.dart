import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/inventory%20repo/inventory_repo_imp.dart';
import 'package:almonazim/data/model/inventory%20models/stock_model.dart';
import 'package:equatable/equatable.dart';

part 'get_inventory_state.dart';

class GetInventoryCubit extends SafeCubit<GetInventoryState> {
  GetInventoryCubit(this.inventoryRepo) : super(GetInventoryInitial());
  InventoryRepoImpl inventoryRepo;
  Future<void> getInventoryInfo(int productsId, int buildingsId) async {
    emit(GetInventoryLoading());
    var result = await inventoryRepo.getInventoryInfo(productsId, buildingsId);
    result.fold((failure) {
      emit(GetInventoryFailure(failure.errMessage));
    }, (StockModel stockModel) {
      emit(GetInventorySuccess(stockModel: stockModel));
    });
  }
}

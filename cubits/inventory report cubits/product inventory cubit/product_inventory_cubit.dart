import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/core/helper/functions/product%20inventory%20reprot/save_product_inventory_report_and_open.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/report%20repos/inventory%20report%20repo/inventory_report_repo.dart';
import 'package:almonazim/data/model/inventory%20report%20models/product%20profit%20models/get_product_inventory_model.dart';
import 'package:equatable/equatable.dart';

part 'product_inventory_state.dart';

class ProductInventoryCubit extends SafeCubit<ProductInventoryState> {
  ProductInventoryCubit(this.profitRepo) : super(ProductInventoryInitial());
  InventoryReportRepo profitRepo;
  GetProductInventoryModel getProductInventoryModel = GetProductInventoryModel(
    fileType: ReportFileType.pdf,
  );
  Future<void> createProductInventory() async {
    try {
      emit(ProductInventoryLoading());
      var result =
          await profitRepo.getProductInventory(getProductInventoryModel);
      result.fold((failure) {
        emit(ProductInventoryFailure(errorMessage: failure.errMessage));
      }, (bytes) async {
        await saveInventoryReportAndOpen(bytes, getProductInventoryModel);
        emit(ProductInventorySuccess());
      });
    } on Exception catch (e) {
      emit(ProductInventoryFailure(errorMessage: e.toString()));
    }
  }
}

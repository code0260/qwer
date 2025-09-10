import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/core/helper/functions/product%20profit%20report/save_product_profit_report_and_open.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/report%20repos/profit%20report%20repo/profit_repo.dart';
import 'package:almonazim/data/model/profit%20report%20models/product%20profit%20models/get_product_profit_model.dart';
import 'package:equatable/equatable.dart';

part 'product_profit_state.dart';

class ProductProfitCubit extends SafeCubit<ProductProfitState> {
  ProductProfitCubit(this.profitRepo) : super(ProductProfitInitial());
  ProfitRepo profitRepo;
  GetProductProfitModel getProductProfitModel = GetProductProfitModel(
      fileType: ReportFileType.pdf,
      startDate: DateTime.now().subtract(const Duration(days: 30)),
      endDate: DateTime.now());

  Future<void> createProductProfit({bool autoOpen = true}) async {
    try {
      emit(ProductProfitLoading());
      var result = await profitRepo.getProductProfit(getProductProfitModel);
      result.fold((failure) {
        emit(ProductProfitFailure(errorMessage: failure.errMessage));
      }, (bytes) async {
        String path = await saveProductProfitReport(
            bytes, getProductProfitModel,
            autoOpen: autoOpen);
        emit(ProductProfitSuccess(path: path));
      });
    } on Exception catch (e) {
      emit(ProductProfitFailure(errorMessage: e.toString()));
    }
  }
}

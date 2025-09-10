import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/sells%20repo/sells_repo_imp.dart';
import 'package:almonazim/data/model/sells%20models/sells_info_input_model.dart';
import 'package:almonazim/data/model/sells%20models/sells_info_model.dart';
import 'package:equatable/equatable.dart';

part 'get_sells_state.dart';

class GetSellsCubit extends SafeCubit<GetSellsState> {
  GetSellsCubit(this.sellsRepo) : super(GetSellsInitial());
  SellsRepoImpl sellsRepo;
  SellsInfoInputModel sellsInfoInputModel = SellsInfoInputModel();
  Future<void> getSellsInfo() async {
    emit(GetSellsLoading());
    var result = await sellsRepo.getSellsInfo(sellsInfoInputModel);
    result.fold((failure) {
      emit(GetSellsFailure(failure.errMessage));
    }, (sellsInfoInputModel) {
      emit(GetSellsSuccess(sellsInfoModel: sellsInfoInputModel));
    });
  }

  // void giveModelData({
  //   int? productsId,
  //   DateTime? startDate,
  //   DateTime? endDate,
  // }) {
  //   sellsInfoInputModel = SellsInfoInputModel(
  //       productsId: productsId ?? sellsInfoInputModel.productsId,
  //       startDate: startDate ?? sellsInfoInputModel.startDate,
  //       endDate: endDate ?? sellsInfoInputModel.endDate);
  // }
}

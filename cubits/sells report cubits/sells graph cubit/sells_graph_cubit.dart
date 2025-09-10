import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/report%20repos/sales%20report%20repo/sales_report_repo.dart';
import 'package:almonazim/data/model/report%20models/sells%20reports%20models/sell_graph_model.dart';
import 'package:almonazim/data/model/sells%20models/sells_info_input_model.dart';
import 'package:equatable/equatable.dart';

part 'sells_graph_state.dart';

class SellsGraphCubit extends SafeCubit<SellsGraphState> {
  SellsGraphCubit(this.salesReportRepo) : super(SellsGraphInitial());
  SalesReportRepo salesReportRepo;
  PeriodType periodType = PeriodType.month;
  SellsInfoInputModel sellsInfoInputModel = SellsInfoInputModel(
      endDate: DateTime.now().add(const Duration(days: 1)),
      startDate: DateTime.now().subtract(const Duration(days: 30)));

  Future<void> getSellsGraph() async {
    emit(SellsGraphLoading());
    var result = await salesReportRepo.getSellsGraph(sellsInfoInputModel);
    result.fold((failure) {
      emit(SellsGraphFailure(failure.errMessage));
    }, (sells) {
      emit(SellsGraphSuccess(sells: sells));
    });
  }

  void setStartDateBasedOnPeriodType() {
    sellsInfoInputModel.endDate = DateTime.now().add(const Duration(days: 1));
    if (periodType == PeriodType.day) {
      sellsInfoInputModel.startDate =
          DateTime.now().subtract(const Duration(days: 1));
    } else if (periodType == PeriodType.week) {
      sellsInfoInputModel.startDate =
          DateTime.now().subtract(const Duration(days: 7));
    } else if (periodType == PeriodType.last30Days) {
      sellsInfoInputModel.startDate =
          DateTime.now().subtract(const Duration(days: 30));
    } else if (periodType == PeriodType.month) {
      var now = DateTime.now();
      DateTime(now.year, now.month, 1);
      sellsInfoInputModel.startDate = DateTime(now.year, now.month, 1);
    }
  }
}

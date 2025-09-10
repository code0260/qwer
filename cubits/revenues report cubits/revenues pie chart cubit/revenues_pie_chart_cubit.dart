import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/report%20repos/revenues%20report%20repos/revenues%20chart%20repo/revenues_chart_repo.dart';
import 'package:almonazim/data/model/report%20models/revenues%20report%20models/revenue_pie_chart_model.dart';
import 'package:almonazim/data/model/revenues%20models/revenues_input_model.dart';
import 'package:equatable/equatable.dart';

part 'revenues_pie_chart_state.dart';

class RevenuesPieChartCubit extends SafeCubit<RevenuesPieChartState> {
  RevenuesPieChartCubit(this.revenueChartRepo)
      : super(RevenuesPieChartInitial());
  RevenuesChartRepo revenueChartRepo;
  PeriodType periodType = PeriodType.month;
  RevenueInputModel revenueInputModel = RevenueInputModel(
      startDate: DateTime.now().subtract(const Duration(days: 30)));
  Future<void> getRevenuesPieChart() async {
    emit(RevenuesPieChartLoading());
    var result = await revenueChartRepo.getRevenuePieChart(revenueInputModel);
    result.fold((failure) {
      emit(RevenuesPieChartFailure(failure.errMessage));
    }, (revenues) {
      emit(RevenuesPieChartSuccess(revenueChart: revenues));
    });
  }

  void setStartDateBasedOnPeriodType() {
    if (periodType == PeriodType.day) {
      revenueInputModel.startDate =
          DateTime.now().subtract(const Duration(days: 1));
    } else if (periodType == PeriodType.week) {
      revenueInputModel.startDate =
          DateTime.now().subtract(const Duration(days: 7));
    } else if (periodType == PeriodType.month) {
      revenueInputModel.startDate =
          DateTime.now().subtract(const Duration(days: 30));
    }
  }
}

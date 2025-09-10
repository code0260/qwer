import 'package:almonazim/core/api/api_service.dart';
import 'package:almonazim/core/constant/app_links.dart';
import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data/data%20source/repo/report%20repos/revenues%20report%20repos/revenues%20chart%20repo/revenues_chart_repo.dart';
import 'package:almonazim/data/model/report%20models/revenues%20report%20models/revenue_pie_chart_model.dart';
import 'package:almonazim/data/model/revenues%20models/revenues_input_model.dart';
import 'package:dartz/dartz.dart';

class RevenuesChartRepoImpl implements RevenuesChartRepo {
  final ApiService apiService;
  RevenuesChartRepoImpl(this.apiService);

  @override
  Future<Either<Failure, List<RevenuePieChartModel>>> getRevenuePieChart(
      RevenueInputModel revenueInputModel) async {
    final result = await apiService.post(
        formDataIsEnabled: true,
        url: AppLinks.revenuesPieChartLink,
        data: revenueInputModel.toMap());

    return result.fold(
      (failure) => left(failure),
      (response) {
        List<RevenuePieChartModel> revenues = [];
        for (final revenue in response["data"]) {
          revenues.add(RevenuePieChartModel.fromMap(revenue));
        }
        return right(revenues);
      },
    );
  }
}

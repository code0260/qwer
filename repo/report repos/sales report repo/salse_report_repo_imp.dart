import 'package:almonazim/core/api/api_service.dart';
import 'package:almonazim/core/constant/app_links.dart';
import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data/data%20source/repo/report%20repos/sales%20report%20repo/sales_report_repo.dart';
import 'package:almonazim/data/model/report%20models/sells%20reports%20models/sell_graph_model.dart';
import 'package:almonazim/data/model/sells%20models/sells_info_input_model.dart';
import 'package:dartz/dartz.dart';

class SalesReportRepoImpl implements SalesReportRepo {
  final ApiService apiService;
  SalesReportRepoImpl(this.apiService);

  @override
  Future<Either<Failure, List<SellsGraphModel>>> getSellsGraph(
      SellsInfoInputModel sellsInfoInputModel) async {
    final result = await apiService.post(
        formDataIsEnabled: false,
        url: AppLinks.getSellsGraphLink,
        data: sellsInfoInputModel.toMap());

    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(SellsGraphModel.fromJsonList(response["data"]));
      },
    );
  }
}

import 'package:almonazim/core/api/api_service.dart';
import 'package:almonazim/core/constant/app_links.dart';
import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data/data%20source/repo/report%20repos/client%20report%20repos/client%20report%20repo/client_report_repo.dart';
import 'package:almonazim/data/model/client%20models/client_debt_report_input_model.dart';
import 'package:almonazim/data/model/client%20models/client_input_model.dart';
import 'package:almonazim/data/model/report%20models/client%20report%20models/client_account_statement_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class ClientReportRepoImpl implements ClientReportRepo {
  final ApiService apiService;
  ClientReportRepoImpl(this.apiService);

  @override
  Future<Either<Failure, ClientAccountStatementModel>>
      getClientAccountStatements(ClientInputModel clientModel) async {
    final result = await apiService.post(
      url: AppLinks.clientAccountStatementLink,
      formDataIsEnabled: false,
      data: clientModel.toMap(),
    );

    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(ClientAccountStatementModel.fromJson(response["data"]));
      },
    );
  }

  @override
  Future<Either<Failure, List<int>>> getClientDebtReport(
      ClientDebtReportInputModel clientDebtReportInputModel) async {
    // print(getProductInventoryModel.toMap());
    final result = await apiService.post(
        formDataIsEnabled: false,
        responseType: ResponseType.bytes,
        url: AppLinks.clientDebtReportLink,
        data: clientDebtReportInputModel.toMap());

    return result.fold(
      (failure) => left(failure),
      (response) async {
        return right(response);
      },
    );
    // return left(ServerFailure('te'));
  }
}

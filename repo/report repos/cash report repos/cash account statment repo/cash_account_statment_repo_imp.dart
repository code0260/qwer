import 'package:almonazim/core/api/api_service.dart';
import 'package:almonazim/core/constant/app_links.dart';
import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data/data%20source/repo/report%20repos/cash%20report%20repos/cash%20account%20statment%20repo/cash_account_statment_repo.dart';
import 'package:almonazim/data/model/cash%20models/cash_input_model.dart';
import 'package:almonazim/data/model/report%20models/cash%20report%20models/cash_account_statement_model.dart';
import 'package:dartz/dartz.dart';

class CashAccountStatementRepoImpl implements CashAccountStatementRepo {
  final ApiService apiService;
  CashAccountStatementRepoImpl(this.apiService);

  @override
  Future<Either<Failure, CashAccountStatementModel>> getCashAccountStatements(
      CashInputModel cashModel) async {
    final result = await apiService.post(
      url: AppLinks.cashAccountStatementLink,
      formDataIsEnabled: false,
      data: cashModel.toMap(),
    );

    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(CashAccountStatementModel.fromJson(response["data"]));
      },
    );
  }
}

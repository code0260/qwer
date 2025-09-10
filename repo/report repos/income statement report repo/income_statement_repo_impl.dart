import 'package:almonazim/core/api/api_service.dart';
import 'package:almonazim/core/constant/app_links.dart';
import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data/data%20source/repo/report%20repos/income%20statement%20report%20repo/income_statement_repo.dart';
import 'package:almonazim/data/model/report%20models/income%20statement%20report%20models/income_statement_input_model.dart';
import 'package:almonazim/data/model/report%20models/income%20statement%20report%20models/income_statement_line_model.dart';
import 'package:dartz/dartz.dart';

class IncomeStatementRepoImpl implements IncomeStatementRepo {
  final ApiService apiService;
  IncomeStatementRepoImpl(this.apiService);

  @override
  Future<Either<Failure, List<IncomeStatementLineModel>>> getIncomeStatement(
      IncomeStatementInputModel incomeStatementInputModel) async {
    final result = await apiService.post(
        formDataIsEnabled: false,
        url: AppLinks.incomeStatementLink,
        data: incomeStatementInputModel.toMap());

    return result.fold(
      (failure) => left(failure),
      (response) {
        List<IncomeStatementLineModel> incomeStatements = [];
        for (final incomeStatement in response["data"]) {
          incomeStatements
              .add(IncomeStatementLineModel.fromJson(incomeStatement));
        }
        return right(incomeStatements);
      },
    );
  }
}

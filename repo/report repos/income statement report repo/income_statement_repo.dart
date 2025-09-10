import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data/model/report%20models/income%20statement%20report%20models/income_statement_input_model.dart';
import 'package:almonazim/data/model/report%20models/income%20statement%20report%20models/income_statement_line_model.dart';
import 'package:dartz/dartz.dart';

abstract class IncomeStatementRepo {
  Future<Either<Failure, List<IncomeStatementLineModel>>> getIncomeStatement(
      IncomeStatementInputModel incomeStatementInputModel);
}

import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data/model/client%20models/client_debt_report_input_model.dart';
import 'package:almonazim/data/model/client%20models/client_input_model.dart';
import 'package:almonazim/data/model/report%20models/client%20report%20models/client_account_statement_model.dart';
import 'package:dartz/dartz.dart';

abstract class ClientReportRepo {
  Future<Either<Failure, ClientAccountStatementModel>>
      getClientAccountStatements(ClientInputModel clientModel);
  Future<Either<Failure, List<int>>> getClientDebtReport(
      ClientDebtReportInputModel clientDebtReportInputModel);
}

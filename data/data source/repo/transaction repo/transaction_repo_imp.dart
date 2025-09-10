import 'package:almonazim/core/api/api_service.dart';
import 'package:almonazim/core/constant/app_links.dart';
import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data/data%20source/repo/transaction%20repo/transaction_repo.dart';
import 'package:almonazim/data/model/account%20models/account_input_model.dart';
import 'package:almonazim/data/model/transaction%20models/add_transaction_model.dart';
import 'package:almonazim/data/model/transaction%20models/general%20ledger/general_ledger_model.dart';
import 'package:almonazim/data/model/transaction%20models/transaction_input_model.dart';
import 'package:almonazim/data/model/transaction%20models/transaction_line_model.dart';
import 'package:dartz/dartz.dart';

import '../../../model/transaction models/transaction_model.dart';

class TransactionRepoImpl implements TransactionRepo {
  final ApiService apiService;
  TransactionRepoImpl(this.apiService);
  @override
  Future<Either<Failure, List<TransactionModel>>> getTransactions(
      TransactionInputModel transactionInputModel) async {
    final result = await apiService.post(
        url: AppLinks.getTransactionsByRequestLink,
        formDataIsEnabled: false,
        data: transactionInputModel.toJson());

    return result.fold(
      (failure) => left(failure),
      (response) {
        List<TransactionModel> transactionsLocale = [];
        for (final transaction in response["data"]) {
          transactionsLocale.add(TransactionModel.fromJson(transaction));
        }
        return right(transactionsLocale);
      },
    );
  }

  @override
  Future<Either<Failure, List<TransactionLineModel>>> getTransactionLines(
      int transactionId) async {
    final requestData = {
      "transaction_id": transactionId,
    };

    final result = await apiService.post(
      url: AppLinks.getTransactionsLinesLink,
      data: requestData,
    );

    return result.fold(
      (failure) => left(failure),
      (response) {
        List<TransactionLineModel> lines = [];
        for (final transaction in response["data"]) {
          lines.add(TransactionLineModel.fromJson(transaction));
        }
        return right(lines);
      },
    );
  }

  @override
  Future<Either<Failure, GeneralLedgerModel>> getGeneralLedger(
      AccountInputModel accountInputModel) async {
    final result = await apiService.post(
      formDataIsEnabled: false,
      url: AppLinks.getGeneralLedgerLink,
      data: accountInputModel.toMap(),
    );

    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(GeneralLedgerModel.fromJson(response["data"]));
      },
    );
  }

  @override
  Future<Either<Failure, void>> addTransaction(
      AddTransactionModel addTransactionModel) async {
    final result = await apiService.post(
      url: AppLinks.addOneTransactionLink,
      formDataIsEnabled: false,
      data: addTransactionModel.toJson(),
    );

    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(null);
      },
    );
  }

  @override
  Future<Either<Failure, void>> reverseTransaction(int transactionId) async {
    final result = await apiService.post(
      url: AppLinks.reverseTransactionLink,
      formDataIsEnabled: true,
      data: {"transaction_id": transactionId},
    );

    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(null);
      },
    );
  }
}

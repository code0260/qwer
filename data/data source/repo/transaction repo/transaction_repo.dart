import 'package:almonazim/data/model/account%20models/account_input_model.dart';
import 'package:almonazim/data/model/transaction%20models/add_transaction_model.dart';
import 'package:almonazim/data/model/transaction%20models/general%20ledger/general_ledger_model.dart';
import 'package:almonazim/data/model/transaction%20models/transaction_input_model.dart';
import 'package:almonazim/data/model/transaction%20models/transaction_line_model.dart';
import 'package:almonazim/data/model/transaction%20models/transaction_model.dart';
import 'package:dartz/dartz.dart';
import 'package:almonazim/core/errors/failures.dart';

abstract class TransactionRepo {
  Future<Either<Failure, List<TransactionModel>>> getTransactions(
      TransactionInputModel transactionInputModel);
  Future<Either<Failure, List<TransactionLineModel>>> getTransactionLines(
      int transactionId);
  Future<Either<Failure, GeneralLedgerModel>> getGeneralLedger(
      AccountInputModel accountInputModel);
  Future<Either<Failure, void>> addTransaction(
      AddTransactionModel addTransactionModel);
  Future<Either<Failure, void>> reverseTransaction(int transactionId);
}

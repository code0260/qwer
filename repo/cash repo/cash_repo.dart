import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data/model/cash%20models/cash_input_model.dart';
import 'package:almonazim/data/model/cash%20models/edit_cash_model.dart';
import 'package:almonazim/data/model/cash%20models/get_all_cash_model.dart';
import 'package:almonazim/data/model/cash%20models/transfer_model.dart';
import 'package:dartz/dartz.dart';

abstract class CashRepo {
  Future<Either<Failure, void>> addCash(List<CashInputModel> cashModels);
  Future<Either<Failure, void>> editCash(EditCashModel editCashModel);
  Future<Either<Failure, GetAllCashModel>> getCash(
      CashInputModel cashInputModel);

  Future<Either<Failure, void>> transferCash(TransferModel transferModel);
}

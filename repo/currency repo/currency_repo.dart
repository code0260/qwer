import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data/model/currency%20models/currency_input_model.dart';
import 'package:almonazim/data/model/currency%20models/currency_model.dart';
import 'package:dartz/dartz.dart';

abstract class CurrencyRepo {
  Future<Either<Failure, List<CurrencyModel>>> getCurrencies();
  Future<Either<Failure, List<CurrencyModel>>> getBusinessCurrencies();
  Future<Either<Failure, void>> addCurrency(
      CurrencyInputModel currencyInputModel);
  Future<Either<Failure, void>> editCurrency(
      CurrencyInputModel currencyInputModel);
  Future<Either<Failure, void>> editMultipleCurrency(
      List<CurrencyInputModel> currencies);
}

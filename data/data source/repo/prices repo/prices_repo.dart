import 'package:almonazim/data/model/price%20models/all_prices_model.dart';
import 'package:almonazim/data/model/price%20models/prices_input_model.dart';
import 'package:dartz/dartz.dart';
import 'package:almonazim/core/errors/failures.dart';

abstract class PricesRepo {
  Future<Either<Failure, AllPricesModel>> getPricesInfo(
      PriceInputModel priceInputModel);
  Future<Either<Failure, void>> getSellPrices();

  Future<Either<Failure, void>> importPrices(String filePath);
  Future<Either<Failure, void>> addPrice(PriceInputModel priceInputModel);
  Future<Either<Failure, Map>> getRelatedPricesIds(
      List<PriceInputModel> prices);
}

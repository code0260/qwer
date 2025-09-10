import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data/model/inventory%20models/stock_input_model.dart';
import 'package:almonazim/data/model/inventory%20models/stock_model.dart';
import 'package:dartz/dartz.dart';

abstract class InventoryRepo {
  Future<Either<Failure, StockModel>> getInventoryInfo(
      int productsId, int buildingsId);

  Future<Either<Failure, void>> editReorderPoint(
      StockInputModel stockInputModel);
}

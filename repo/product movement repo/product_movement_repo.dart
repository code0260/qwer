import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data/model/product%20movement/move_product_model.dart';
import 'package:dartz/dartz.dart';

abstract class ProductMovementRepo {
  Future<Either<Failure, void>> moveProduct(MoveProductModel moveProductModel);
}

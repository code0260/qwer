import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data/model/product%20statement%20models/product_statement_input_model.dart';
import 'package:almonazim/data/model/product%20statement%20models/product_statement_model.dart';
import 'package:dartz/dartz.dart';

abstract class ProductStatementRepo {
  Future<Either<Failure, ProductStatementModel>> getProductStatements(
      ProductStatementInputModel productStatementInputModel);
}

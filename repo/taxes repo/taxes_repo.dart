import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data/model/taxes%20models/taxes_input_model.dart';
import 'package:almonazim/data/model/taxes%20models/taxes_model.dart';
import 'package:dartz/dartz.dart';

abstract class TaxesRepo {
  Future<Either<Failure, List<TaxesModel>>> getTaxes();
  Future<Either<Failure, void>> importTaxes(String filePath);
  Future<Either<Failure, void>> addTax(TaxesInputModel clientInputModel);
  Future<Either<Failure, void>> editTax(TaxesInputModel clientInputModel);
}

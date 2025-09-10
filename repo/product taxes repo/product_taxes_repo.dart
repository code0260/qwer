import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data/model/taxes%20models/product_tax_model.dart';
import 'package:almonazim/data/model/taxes%20models/product_taxes_input_model.dart';
import 'package:dartz/dartz.dart';

abstract class ProductTaxesRepo {
  Future<Either<Failure, List<ProductTaxModel>>> getProductTaxes(
      int? productsId);
  Future<Either<Failure, List<ProductTaxModel>>> getAllProductTaxes();

  Future<Either<Failure, void>> importProductTaxes(String filePath);
  Future<Either<Failure, void>> addProductTax(
      ProductTaxesInputModel clientInputModel);
  Future<Either<Failure, void>> editProductTax(
      ProductTaxesInputModel clientInputModel);
  //$ delete
  Future<Either<Failure, void>> deleteProductTax(int productsTaxesId);
}

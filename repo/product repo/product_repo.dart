import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data/model/product%20models/add_product_model.dart';
import 'package:almonazim/data/model/product%20models/product_input_model.dart';
import 'package:almonazim/data/model/product%20models/product_model.dart';
import 'package:dartz/dartz.dart';

abstract class ProductsRepo {
  Future<Either<Failure, List<ProductModel>>> getProducts(
      int category, int requestNumber);
  Future<Either<Failure, void>> importProducts(String filePath);
  Future<Either<Failure, void>> refreshProducts();

  Future<Either<Failure, void>> addProduct(AddProductModel addProductModel);
  Future<Either<Failure, void>> editProduct(
      ProductInputModel productInputModel);
  Future<Either<Failure, Map>> addMultipleProduct(
      List<ProductInputModel> products);
}

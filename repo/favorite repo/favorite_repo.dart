import 'package:almonazim/data/model/product%20models/product_model.dart';
import 'package:dartz/dartz.dart';
import 'package:almonazim/core/errors/failures.dart';

abstract class FavoriteRepo {
  Future<Either<Failure, List<ProductModel>>> getFavorite(bool isWantedMore);
  Future<Either<Failure, Map>> deleteFavorite(ProductModel productModel);
  Future<Either<Failure, Map>> addFavorite(ProductModel productModel);
}

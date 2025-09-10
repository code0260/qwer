import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data/model/place%20models/place_input_model.dart';
import 'package:almonazim/data/model/place%20models/product_place_details_input_model.dart';
import 'package:almonazim/data/model/product%20place%20models/edit_product_count_model.dart';
import 'package:almonazim/data/model/product%20place%20models/product_place_details_model.dart';
import 'package:dartz/dartz.dart';

abstract class ProductPlaceRepo {
  Future<Either<Failure, List<ProductPlaceDetailsModel>>>
      getProductPlacesDetails(int productsId, int buildingsId);
  Future<Either<Failure, void>> importProductPlaces(String filePath);
  Future<Either<Failure, void>> addProductPlace(
      ProductPlaceDetailsInputModel productPlaceDetailsInputModel);
  Future<Either<Failure, void>> editProductCount(
      EditProductCountModel editProductCountModel);
  Future<Either<Failure, ProductPlaceDetailsModel>> getOneProductPlacesDetails(
      int productsId, PlaceInputModel placeModel);
}

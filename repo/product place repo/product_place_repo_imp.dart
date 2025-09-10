import 'package:almonazim/core/api/api_service.dart';
import 'package:almonazim/core/constant/app_links.dart';
import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/core/helper/functions/place%20functions/prepare_add_product_place.dart';
import 'package:almonazim/core/helper/functions/product%20functions/prepare%20edit%20product%20count/prepare_edit_product_count.dart';
import 'package:almonazim/data/data%20source/locale/store_insert_date_steps.dart';
import 'package:almonazim/data/data%20source/repo/product%20place%20repo/product_place_repo.dart';
import 'package:almonazim/data/model/place%20models/place_input_model.dart';
import 'package:almonazim/data/model/place%20models/product_place_details_input_model.dart';
import 'package:almonazim/data/model/product%20place%20models/edit_product_count_model.dart';
import 'package:almonazim/data/model/product%20place%20models/product_place_details_model.dart';
import 'package:dartz/dartz.dart';

class ProductPlaceRepoImpl implements ProductPlaceRepo {
  final ApiService apiService;

  ProductPlaceRepoImpl(this.apiService);

  @override
  Future<Either<Failure, List<ProductPlaceDetailsModel>>>
      getProductPlacesDetails(int productsId, int buildingsId) async {
    final requestData = {
      "products_id": productsId,
      "buildings_id": buildingsId,
    };

    final result = await apiService.post(
      url: AppLinks.getProductPlacesDetails,
      data: requestData,
    );

    return result.fold(
      (failure) => left(failure),
      (response) {
        final List<ProductPlaceDetailsModel> productPlaceDetails =
            response["data"]
                .map<ProductPlaceDetailsModel>(
                  (detail) => ProductPlaceDetailsModel.fromJson(detail),
                )
                .toList();

        return right(productPlaceDetails);
      },
    );
  }

  @override
  Future<Either<Failure, ProductPlaceDetailsModel>> getOneProductPlacesDetails(
      int productsId, PlaceInputModel placeModel) async {
    final requestData = {
      "products_id": productsId,
      "place": placeModel.toMapEvenNull(),
    };

    final result = await apiService.post(
      url: AppLinks.getOneProductPlacesDetails,
      formDataIsEnabled: false,
      data: requestData,
    );

    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(ProductPlaceDetailsModel.fromJson(response["data"]));
      },
    );
  }

  @override
  Future<Either<Failure, void>> importProductPlaces(String filePath) async {
    final result = await apiService.uploadFile(
        url: AppLinks.importProductPlaces,
        requestName: "product_places_excel_file",
        filePath: filePath);

    return result.fold(
      (failure) => left(failure),
      (response) {
        StoreInsertDateSteps.addStep("7");
        return right(null);
      },
    );
  }

  @override
  Future<Either<Failure, void>> addProductPlace(
      ProductPlaceDetailsInputModel productPlaceDetailsInputModel) async {
    // print(prepareAddProductPlace(productPlaceDetailsInputModel));
    final result = await apiService.post(
        url: AppLinks.addProductPlace,
        formDataIsEnabled: false,
        data: prepareAddProductPlace(productPlaceDetailsInputModel));

    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(null);
      },
    );
    // return right(null);
  }

  @override
  Future<Either<Failure, void>> editProductCount(
      EditProductCountModel editProductCountModel) async {
    // print(prepareEditProductCount(editProductCountModel));
    final result = await apiService.post(
        url: AppLinks.editProductCount,
        formDataIsEnabled: false,
        data: prepareEditProductCount(editProductCountModel));

    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(null);
      },
    );
    // return right(null);
  }
}

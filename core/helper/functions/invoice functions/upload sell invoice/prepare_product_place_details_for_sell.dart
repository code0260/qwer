import 'dart:math';

import 'package:almonazim/core/helper/functions/init_get_it.dart';
import 'package:almonazim/data/data%20source/locale/store_count_invoice.dart';
import 'package:almonazim/data/data%20source/repo/unite%20repo/unite_repo_imp.dart';
import 'package:almonazim/data/model/cart%20models/sell_item_model.dart';
import 'package:almonazim/data/model/unit_model.dart';

List<Map<dynamic, dynamic>> prepareProductPlaceDetailsForSell(
    SellItemModel sellItemModel, List<double> countForEach) {
  List<Map<dynamic, dynamic>> productPlaceDetails = [];
  // sending data to subtract the total amount
  double remainingBatchQuantity = sellItemModel.productCount;
  double remainingProductPlacesQuantity = sellItemModel.productCount;

  for (int i = 0; i < sellItemModel.chosenPlaceModels.length; i++) {
    Map productPlaceDetail = {};
    double itemConversion =
        (sellItemModel.getProductModel.productModel.unitsBaseConversion! *
                (sellItemModel.productConversion ?? 1))
            .roundToDouble(); //! be careful about this.
    if (remainingBatchQuantity > 0) {
      //$ batch
      double batchesOriginalRemaining = sellItemModel
              .chosenPlaceModels[i].batchModel.batchesProductsRemainingCount ??
          StoreCountInvoice.getCountInvoice().toDouble();
      double batchConversion =
          sellItemModel.chosenPlaceModels[i].batchModel.unitsConversionFactor ??
              1.0;
      double availableBatchQuantity =
          batchesOriginalRemaining * (batchConversion / itemConversion);
      double usedBatchQuantity =
          min(availableBatchQuantity, remainingBatchQuantity);
      double decrementBatchQuantity =
          usedBatchQuantity * (itemConversion / batchConversion);
      double newRemainingBatchCount =
          batchesOriginalRemaining - decrementBatchQuantity;
      productPlaceDetail["batches_id"] =
          sellItemModel.chosenPlaceModels[i].batchModel.batchesId;
      productPlaceDetail["batches_products_remaining_count"] =
          newRemainingBatchCount;
      remainingBatchQuantity -= usedBatchQuantity;
    }
    if (remainingProductPlacesQuantity > 0) {
      //$ product places
      double productPlacesOriginalRemaining = sellItemModel
          .chosenPlaceModels[i].productPlaceModel.productPlacesCount!;
      double productPlaceConversion = getIt
          .get<UnitRepoImpl>()
          .completeUnitModel(UnitModel(
              unitsId: sellItemModel.chosenPlaceModels[i].productPlaceModel
                  .productPlacesCountUnitId!))
          .unitsConversionFactor!
          .toDouble();
      double availableProductPlaceQuantity = productPlacesOriginalRemaining *
          (productPlaceConversion / itemConversion);
      double usedProductPlacesQuantity =
          min(availableProductPlaceQuantity, remainingProductPlacesQuantity);
      double decrementProductPlaceQuantity =
          usedProductPlacesQuantity * (itemConversion / productPlaceConversion);
      countForEach.add(decrementProductPlaceQuantity * productPlaceConversion);
      double newRemainingProductPlacesCount =
          productPlacesOriginalRemaining - decrementProductPlaceQuantity;

      productPlaceDetail["product_places_id"] =
          sellItemModel.chosenPlaceModels[i].productPlaceModel.productPlacesId;
      productPlaceDetail["product_places_places_id"] = sellItemModel
          .chosenPlaceModels[i].productPlaceModel.productPlacesPlacesId;
      // productPlaceDetail["product_places_products_id"] = sellItemModel
      //     .chosenPlaceModels[i].productPlaceModel.productPlacesProductsId;
      productPlaceDetail["product_places_count"] =
          newRemainingProductPlacesCount;
      remainingProductPlacesQuantity -= usedProductPlacesQuantity;
    }
    if (productPlaceDetail.isNotEmpty) {
      productPlaceDetails.add(productPlaceDetail);
    }
  }

  return productPlaceDetails;
}

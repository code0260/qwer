import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/core/helper/functions/currency%20functions/convert_amount.dart';
import 'package:almonazim/data/data%20source/locale/sqflite/store_batches.dart';
import 'package:almonazim/data/model/cart%20models/sell_item_model.dart';

Future<double> getLatestUnitCost(SellItemModel sellItemModel) async {
  double cost = 0;
  if (sellItemModel.getProductModel.productModel.productsType ==
      ProductType.service.name) {
    return cost;
  }
  if (sellItemModel.chosenPlaceModels.last.batchModel.batchesProductUnitCost !=
      null) {
    cost = convertAmount(
        sellItemModel.chosenPlaceModels.last.batchModel.batchesProductUnitCost!,
        sellItemModel
            .chosenPlaceModels.last.batchModel.batchesProductsCurrencyId!,
        sellItemModel.currencyId!);
  } else {
    var r = await StoreBatches.getProductBatches(
        sellItemModel.getProductModel.productModel.productsId!);
    r.fold(
      (l) {},
      (r) {
        cost = convertAmount(r.first.batchesProductsBuyPrice!,
            r.first.batchesProductsCurrencyId!, sellItemModel.currencyId!);
      },
    );
  }

  return cost;
}

import 'package:almonazim/core/helper/functions/currency%20functions/convert_amount.dart';
import 'package:almonazim/data/model/cart%20models/sell_item_model.dart';

double? getAverageUnitCost(SellItemModel sellItemModel) {
  double? cost;
  for (final item in sellItemModel.chosenPlaceModels) {
    if (item.batchModel.batchesProductUnitCost != null) {
      cost ??= 0;
      cost += convertAmount(
          item.batchModel.batchesProductUnitCost!,
          item.batchModel.batchesProductsCurrencyId!,
          sellItemModel.currencyId!);
    }
  }
  if (cost != null) {
    return cost / sellItemModel.chosenPlaceModels.length;
  } else {
    return null;
  }
}

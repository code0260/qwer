import 'package:almonazim/core/helper/functions/currency%20functions/prepare_buy_price_currency.dart';
import 'package:almonazim/data/model/cart%20models/buy_item_model.dart';

List<BuyItemModel> prepareBuyPriceIdAndCurrency(List<BuyItemModel> cartBuyHome,
    int index, double newBuyPrice, num? originalBuyPrice, int originalPriceId) {
  if (newBuyPrice != originalBuyPrice) {
    cartBuyHome[index].batchModel.batchesProductsPricesId = 0;
  } else {
    cartBuyHome[index].batchModel.batchesProductsPricesId = originalPriceId;
  }
  return prepareBuyPriceCurrency(cartBuyHome, index) ?? cartBuyHome;
}

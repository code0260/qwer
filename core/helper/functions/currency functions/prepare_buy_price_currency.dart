import 'package:almonazim/data.dart';
import 'package:almonazim/data/model/cart%20models/buy_item_model.dart';

List<BuyItemModel>? prepareBuyPriceCurrency(
    List<BuyItemModel> cartBuyHome, int index) {
  if (cartBuyHome[index].batchModel.batchesProductsBuyPrice == null) {
    return null;
  }
  if (cartBuyHome[index].batchModel.batchesProductsCurrencyId == null) {
    cartBuyHome[index].batchModel.batchesProductsCurrencyId =
        currentCurrencyModel.businessCurrencyId;
    return null;
  }
  if (cartBuyHome[index].batchModel.batchesProductsCurrencyId ==
      currentCurrencyModel.businessCurrencyId) {
    return null;
  } else {
    var oldCurrencyModel = currencies.firstWhere((element) =>
        element.businessCurrencyId ==
        cartBuyHome[index].batchModel.batchesProductsCurrencyId);
    var newConversion = (currentCurrencyModel.businessCurrencyManualExchange ??
        currentCurrencyModel.currenciesExchangeRateToDollar!);
    var oldConversion = (oldCurrencyModel.businessCurrencyManualExchange ??
        oldCurrencyModel.currenciesExchangeRateToDollar!);
    var totalConversion = newConversion / oldConversion;
    double newConvertedPrice =
        cartBuyHome[index].batchModel.batchesProductsBuyPrice! *
            totalConversion;
    cartBuyHome[index].batchModel.batchesProductsBuyPrice = newConvertedPrice;
    cartBuyHome[index].batchModel.batchesProductsCurrencyId =
        currentCurrencyModel.businessCurrencyId;
  }
  return cartBuyHome;
}

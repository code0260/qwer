import 'package:almonazim/data.dart';
import 'package:almonazim/data/model/cart%20models/sell_item_model.dart';

List<SellItemModel>? prepareSellPriceCurrency(
    List<SellItemModel> cartSellHome, int index) {
  if (cartSellHome[index].currencyId == null) {
    cartSellHome[index].currencyId = currentCurrencyModel.businessCurrencyId;
    return null;
  }
  if (cartSellHome[index].currencyId ==
      currentCurrencyModel.businessCurrencyId) {
    return null;
  } else {
    var oldCurrencyModel = currencies.firstWhere((element) =>
        element.businessCurrencyId == cartSellHome[index].currencyId);
    var newConversion = (currentCurrencyModel.businessCurrencyManualExchange ??
        currentCurrencyModel.currenciesExchangeRateToDollar!);
    var oldConversion = (oldCurrencyModel.businessCurrencyManualExchange ??
        oldCurrencyModel.currenciesExchangeRateToDollar!);
    var totalConversion = newConversion / oldConversion;
    var unit = (cartSellHome[index].editedPriceModel.pricesUnitPrice ??
            cartSellHome[index]
                .getProductModel
                .chosenPriceModel
                .pricesUnitPrice) ??
        0;
    double newConvertedPrice = unit * totalConversion;
    cartSellHome[index].editedPriceModel.pricesUnitPrice = newConvertedPrice;
    cartSellHome[index].currencyId = currentCurrencyModel.businessCurrencyId;
  }
  return cartSellHome;
}

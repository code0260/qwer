import 'package:almonazim/core/extension/double_extension.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/model/currency%20models/currency_model.dart';

double? prepareInvoiceCurrency(double amount) {
  if (currentCurrencyModel.businessCurrencyIsBase == 1) {
    return null;
  } else {
    CurrencyModel baseCurrency =
        currencies.firstWhere((element) => element.businessCurrencyIsBase == 1);
    var newConversion = (currentCurrencyModel.businessCurrencyManualExchange ??
        currentCurrencyModel.currenciesExchangeRateToDollar!);
    var oldConversion = (baseCurrency.businessCurrencyManualExchange ??
        baseCurrency.currenciesExchangeRateToDollar!);
    var totalConversion = oldConversion / newConversion;
    double newConvertedPrice = amount * totalConversion;
    return newConvertedPrice
        .roundToNearest(baseCurrency.businessCurrencyNearFactor!);
  }
}

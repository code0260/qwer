import 'package:almonazim/core/extension/double_extension.dart';
import 'package:almonazim/data.dart';

double convertAmount(
    double amount, int amountCurrencyId, int wantedCurrencyId) {
  //$ model
  var oldCurrencyModel = currencies
      .firstWhere((element) => element.businessCurrencyId == amountCurrencyId);
  var newCurrencyModel = currencies
      .firstWhere((element) => element.businessCurrencyId == wantedCurrencyId);
  //$ conversion
  var newConversion = (newCurrencyModel.businessCurrencyManualExchange ??
      newCurrencyModel.currenciesExchangeRateToDollar!);
  var oldConversion = (oldCurrencyModel.businessCurrencyManualExchange ??
      oldCurrencyModel.currenciesExchangeRateToDollar!);
  var totalConversion = newConversion / oldConversion;
  return (amount * totalConversion)
      .roundToNearest(newCurrencyModel.businessCurrencyNearFactor!);
}

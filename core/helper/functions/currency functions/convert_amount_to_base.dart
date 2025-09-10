import 'package:almonazim/core/extension/double_extension.dart';
import 'package:almonazim/data.dart';

double convertAmountToBase(double amount, int amountCurrencyId) {
  //$ model
  var oldCurrencyModel = currencies
      .firstWhere((element) => element.businessCurrencyId == amountCurrencyId);
  var newCurrencyModel =
      currencies.firstWhere((element) => element.businessCurrencyIsBase == 1);
  //$ conversion
  var newConversion = (newCurrencyModel.businessCurrencyManualExchange ??
      newCurrencyModel.businessCurrencyManualExchange ??
      newCurrencyModel.currenciesExchangeRateToDollar!);
  var oldConversion = (oldCurrencyModel.businessCurrencyManualExchange ??
      oldCurrencyModel.currenciesExchangeRateToDollar!);
  var totalConversion = newConversion / oldConversion;
  return (amount * totalConversion)
      .roundToNearest(newCurrencyModel.businessCurrencyNearFactor!);
}

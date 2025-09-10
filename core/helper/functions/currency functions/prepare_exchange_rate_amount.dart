import 'package:almonazim/core/extension/double_extension.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/model/currency%20models/currency_model.dart';

double prepareExchangeRateAmount(
    double totalAmount,
    double? totalAmountInBase,
    double amount,
    double? amountInBase,
    int currencyId,
    String type,
    String typeOfType) {
  if (totalAmountInBase != null) {
    double originalExchangeRate = totalAmountInBase / totalAmount;
    CurrencyModel baseModel =
        currencies.firstWhere((element) => element.businessCurrencyIsBase == 1);
    //$ amounts
    double currentPaymentAmountInBase = amountInBase ??
        amount; // if the payment is in any currency that will return InBase not null, if the currency is base currency the amount will be in base

    double originalPaymentAmountInBase = amount * originalExchangeRate;

    //$ no exchange rate changes
    if (originalPaymentAmountInBase
            .roundToNearest(baseModel.businessCurrencyNearFactor!) ==
        currentPaymentAmountInBase
            .roundToNearest(baseModel.businessCurrencyNearFactor!)) {
      return 0;
    }

    if ((type == "expense" && typeOfType == "prepaid") ||
        (type == "revenue" && typeOfType == "due")) {
      if (currentPaymentAmountInBase > originalPaymentAmountInBase) {
        double amountGained =
            (currentPaymentAmountInBase) - (originalPaymentAmountInBase);
        return amountGained
            .roundToNearest(baseModel.businessCurrencyNearFactor!);
      } else {
        double amountLost =
            (originalPaymentAmountInBase) - (currentPaymentAmountInBase);
        //? the number is in minus
        return -amountLost
            .roundToNearest(baseModel.businessCurrencyNearFactor!);
      }
    } else {
      if (currentPaymentAmountInBase < originalPaymentAmountInBase) {
        double amountGained =
            (originalPaymentAmountInBase) - (currentPaymentAmountInBase);
        return amountGained
            .roundToNearest(baseModel.businessCurrencyNearFactor!);
      } else {
        double amountLost =
            (currentPaymentAmountInBase) - (originalPaymentAmountInBase);
        //? the number is in minus
        return -amountLost
            .roundToNearest(baseModel.businessCurrencyNearFactor!);
      }
    }
  }
  return 0;
}

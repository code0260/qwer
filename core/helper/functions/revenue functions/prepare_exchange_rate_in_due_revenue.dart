import 'package:almonazim/core/extension/double_extension.dart';
import 'package:almonazim/core/helper/functions/currency%20functions/convert_amount.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/model/currency%20models/currency_model.dart';
import 'package:almonazim/data/model/revenues%20models/revenues_input_model.dart';
import 'package:almonazim/data/model/revenues%20models/revenues_model.dart';

double prepareExchangeRateInDueRevenue(
    RevenueInputModel revenueInputModel, RevenuesModel revenuesModel) {
  if (revenuesModel.revenuesAmountInBase != null) {
    double originalExchangeRate =
        revenuesModel.revenuesAmountInBase! / revenuesModel.revenuesAmount!;
    CurrencyModel baseModel =
        currencies.firstWhere((element) => element.businessCurrencyIsBase == 1);
    //$ amounts
    double currentPaymentAmountInBase = revenueInputModel.paidThisTimeInBase ??
        revenueInputModel
            .paidThisTime!; // if the payment is in any currency that will return InBase not null, if the currency is base currency the amount will be in base

    double originalPaymentAmountInBase = convertAmount(
            revenueInputModel.paidThisTime!,
            revenueInputModel.paidThisTimeCurrencyId!,
            revenuesModel.revenuesAmountCurrencyId!) *
        originalExchangeRate;

    //$ no exchange rate changes
    if (originalPaymentAmountInBase
            .roundToNearest(baseModel.businessCurrencyNearFactor!) ==
        currentPaymentAmountInBase
            .roundToNearest(baseModel.businessCurrencyNearFactor!)) {
      return 0;
    }

    if (currentPaymentAmountInBase > originalPaymentAmountInBase) {
      //* gain because I owe the debt of the revenue
      double amountGained =
          (currentPaymentAmountInBase) - (originalPaymentAmountInBase);
      return amountGained.roundToNearest(baseModel.businessCurrencyNearFactor!);
    } else {
      //* loss because I owe the debt of the revenue
      double amountLost =
          (originalPaymentAmountInBase) - (currentPaymentAmountInBase);
      //? the number is in minus
      return -amountLost.roundToNearest(baseModel.businessCurrencyNearFactor!);
    }
  }
  return 0;
}

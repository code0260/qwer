import 'package:almonazim/core/extension/double_extension.dart';
import 'package:almonazim/core/helper/functions/currency%20functions/convert_amount.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/model/currency%20models/currency_model.dart';
import 'package:almonazim/data/model/debt%20models/debt_model.dart';
import 'package:almonazim/data/model/debt%20models/debt_payment_input_model.dart';

double prepareExchangeRateInPay(
    DebtPaymentInputModel debtInputModel, DebtModel debtModel) {
  if (debtModel.debtsTotalAmountInBase != null) {
    double originalExchangeRate =
        debtModel.debtsTotalAmountInBase! / debtModel.debtsTotalAmount!;
    CurrencyModel baseModel =
        currencies.firstWhere((element) => element.businessCurrencyIsBase == 1);
    //$ amounts
    double currentPaymentAmountInBase = debtInputModel
            .debtPaymentsAmountInBase ??
        debtInputModel
            .debtPaymentsAmount!; // if the payment is in any currency that will return InBase not null, if the currency is base currency the amount will be in base

    double originalPaymentAmountInBase = convertAmount(
            debtInputModel.debtPaymentsAmount!,
            debtInputModel.debtPaymentsAmountCurrencyId!,
            debtModel.debtsAmountCurrencyId!) *
        originalExchangeRate;

    //$ no exchange rate changes
    if (originalPaymentAmountInBase
            .roundToNearest(baseModel.businessCurrencyNearFactor!) ==
        currentPaymentAmountInBase
            .roundToNearest(baseModel.businessCurrencyNearFactor!)) {
      return 0;
    }

    if (currentPaymentAmountInBase < originalPaymentAmountInBase) {
      //* gain because I pay the debt
      double amountGained =
          (originalPaymentAmountInBase) - (currentPaymentAmountInBase);
      return amountGained.roundToNearest(baseModel.businessCurrencyNearFactor!);
    } else {
      //* loss because I pay the debt
      double amountLost =
          (currentPaymentAmountInBase) - (originalPaymentAmountInBase);
      //? the number is in minus
      return -amountLost.roundToNearest(baseModel.businessCurrencyNearFactor!);
    }
  }
  return 0;
}

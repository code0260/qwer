import 'package:almonazim/core/extension/double_extension.dart';
import 'package:almonazim/core/helper/functions/currency%20functions/convert_amount.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/model/currency%20models/currency_model.dart';
import 'package:almonazim/data/model/expenses%20models/expenses_input_model.dart';
import 'package:almonazim/data/model/expenses%20models/expenses_model.dart';

double prepareExchangeRateInDueExpense(
    ExpenseInputModel expenseInputModel, ExpensesModel expensesModel) {
  if (expensesModel.expensesAmountInBase != null) {
    double originalExchangeRate =
        expensesModel.expensesAmountInBase! / expensesModel.expensesAmount!;
    CurrencyModel baseModel =
        currencies.firstWhere((element) => element.businessCurrencyIsBase == 1);
    //$ amounts
    double currentPaymentAmountInBase = expenseInputModel.paidThisTimeInBase ??
        expenseInputModel
            .paidThisTime!; // if the payment is in any currency that will return InBase not null, if the currency is base currency the amount will be in base

    double originalPaymentAmountInBase = convertAmount(
            expenseInputModel.paidThisTime!,
            expenseInputModel.paidThisTimeCurrencyId!,
            expensesModel.expensesAmountCurrencyId!) *
        originalExchangeRate;

    //$ no exchange rate changes
    if (originalPaymentAmountInBase
            .roundToNearest(baseModel.businessCurrencyNearFactor!) ==
        currentPaymentAmountInBase
            .roundToNearest(baseModel.businessCurrencyNearFactor!)) {
      return 0;
    }

    if (currentPaymentAmountInBase < originalPaymentAmountInBase) {
      //* gain because I pay the debt the expense
      double amountGained =
          (originalPaymentAmountInBase) - (currentPaymentAmountInBase);
      return amountGained.roundToNearest(baseModel.businessCurrencyNearFactor!);
    } else {
      //* loss because I pay the debt the expense
      double amountLost =
          (currentPaymentAmountInBase) - (originalPaymentAmountInBase);
      //? the number is in minus
      return -amountLost.roundToNearest(baseModel.businessCurrencyNearFactor!);
    }
  }
  return 0;
}

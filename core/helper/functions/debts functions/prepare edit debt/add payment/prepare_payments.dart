import 'dart:math';

import 'package:almonazim/core/helper/functions/currency%20functions/convert_amount.dart';
import 'package:almonazim/core/helper/functions/currency%20functions/convert_amount_to_base.dart';
import 'package:almonazim/core/helper/functions/debts%20functions/prepare%20edit%20debt/add%20payment/prepare_debt_payment.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/model/debt%20models/add_payments_model.dart';
import 'package:almonazim/data/model/debt%20models/debt_payment_input_model.dart';

List<Map> preparePayments(AddPaymentsModel addPaymentsModel) {
  List<Map> payments = [];
  // 1) convert the user's payment to base units
  final basePaymentAmount = convertAmountToBase(
    addPaymentsModel.paymentsAmount!,
    addPaymentsModel.paymentsAmountCurrencyId!,
  );
  double remainingBase = basePaymentAmount;

  for (final debt in addPaymentsModel.debts) {
    if (remainingBase <= 0) break;

    // how much is still owed on this debt, in base
    final owedBase = convertAmountToBase(
        debt.debtsTotalAmount! - debt.debtsPaidAmount!,
        debt.debtsAmountCurrencyId!);

    if (owedBase <= 0) continue; // already fully paid

    // pay up to what's left of the user's payment
    final payBase = min(owedBase, remainingBase);

    // convert that payBase back into the debt's currency if needed
    var baseCurrencyId = currencies
        .firstWhere((element) => element.businessCurrencyIsBase == 1)
        .businessCurrencyId!;
    final payInDebtCurrency = convertAmount(
        payBase, baseCurrencyId, addPaymentsModel.paymentsAmountCurrencyId!);

    // prepare the cubit's input model
    DebtPaymentInputModel debtPaymentInputModel = DebtPaymentInputModel()
      ..debtPaymentsDebtsId = debt.debtsId
      ..debtPaymentsAmountCurrencyId = addPaymentsModel.paymentsAmountCurrencyId
      ..debtPaymentsNotes = addPaymentsModel.notes
      ..debtPaymentsDate = addPaymentsModel.date
      ..debtPaymentsAmount = payInDebtCurrency
      ..debtPaymentsAmountInBase = payInDebtCurrency == payBase ? null : payBase
      ..clientsId = debt.debtsClientsId
      ..clientsType = debt.clientsType
      ..clientsName = debt.clientsName
      ..debtType = debt.debtsPersonNameType;

    // now send it
    payments.add(prepareDebtPayment(debtPaymentInputModel, debt));
    // deduct from the remaining budget
    remainingBase -= payBase;
  }

  if (remainingBase > 0) {
    //$ creating a debt with the amount paid as 'cash advance'
  }
  return payments;
}

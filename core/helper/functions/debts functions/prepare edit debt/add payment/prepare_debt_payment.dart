import 'package:almonazim/core/helper/functions/debts%20functions/prepare%20edit%20debt/add%20payment/prepare_pay_debt.dart';
import 'package:almonazim/core/helper/functions/debts%20functions/prepare%20edit%20debt/add%20payment/prepare_receive_debt.dart';
import 'package:almonazim/data/model/debt%20models/debt_model.dart';
import 'package:almonazim/data/model/debt%20models/debt_payment_input_model.dart';

Map prepareDebtPayment(
    DebtPaymentInputModel debtPaymentInputModel, DebtModel debtModel) {
  if (debtPaymentInputModel.debtType == "Credit") {
    return preparePayDebt(debtPaymentInputModel, debtModel);
  } else {
    return prepareReceiveDebt(debtPaymentInputModel, debtModel);
  }
}

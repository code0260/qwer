import 'package:almonazim/core/helper/functions/debts%20functions/prepare%20edit%20debt/cancel%20payment/prepare_cancel_pay_debt.dart';
import 'package:almonazim/core/helper/functions/debts%20functions/prepare%20edit%20debt/cancel%20payment/prepare_cancel_receive_debt.dart';
import 'package:almonazim/data/model/debt%20models/debt_model.dart';
import 'package:almonazim/data/model/debt%20models/debt_payment_input_model.dart';

Map prepareCancelDebtPayment(
    DebtPaymentInputModel debtPaymentInputModel, DebtModel debtModel) {
  if (debtPaymentInputModel.debtType == "Credit") {
    return prepareCancelPayDebt(debtPaymentInputModel, debtModel);
  } else {
    return prepareCancelReceiveDebt(debtPaymentInputModel, debtModel);
  }
}

import 'package:almonazim/core/helper/functions/debts%20functions/prepare%20kill%20debt/prepare_kill_debit_debt.dart';
import 'package:almonazim/core/helper/functions/debts%20functions/prepare%20kill%20debt/prepare_kill_credit_debt.dart';
import 'package:almonazim/data/model/debt%20models/edit_debt_model.dart';

Map prepareKillDebt(EditDebtModel editDebtModel) {
  if (editDebtModel.debtsType == "Credit") {
    return prepareKillCreditDebt(editDebtModel);
  } else {
    return prepareKillDebitDebt(editDebtModel);
  }
}

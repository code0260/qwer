import 'package:almonazim/core/helper/functions/debts%20functions/prepare%20add%20debt/prepare_credit_debt.dart';
import 'package:almonazim/core/helper/functions/debts%20functions/prepare%20add%20debt/prepare_debit_debt.dart';
import 'package:almonazim/data/model/debt%20models/debt_input_model.dart';

Map prepareAddDebt(DebtInputModel debtInputModel) {
  if (debtInputModel.debtsEmployeesId != null ||
      debtInputModel.debtsPersonNameType == "Debit") {
    return prepareCreditDebt(debtInputModel);
  } else {
    return prepareDebitDebt(debtInputModel);
  }
}

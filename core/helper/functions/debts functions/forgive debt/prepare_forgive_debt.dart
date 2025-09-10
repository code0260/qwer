import 'package:almonazim/core/helper/functions/debts%20functions/forgive%20debt/prepare_forgive_credit_debt.dart';
import 'package:almonazim/core/helper/functions/debts%20functions/forgive%20debt/prepare_forgive_debit_debt.dart';
import 'package:almonazim/data/model/debt%20models/edit_debt_model.dart';

Map prepareForgiveDebt(EditDebtModel editDebtModel) {
  if (editDebtModel.debtsType == "Credit") {
    return prepareForgiveCreditDebt(editDebtModel);
  } else {
    return prepareForgiveDebitDebt(editDebtModel);
  }
}

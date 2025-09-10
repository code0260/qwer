import 'package:almonazim/core/helper/functions/debts%20functions/un%20forgive%20debt/prepare_un_forgive_credit_debt.dart';
import 'package:almonazim/core/helper/functions/debts%20functions/un%20forgive%20debt/prepare_un_forgive_debit_debt.dart';
import 'package:almonazim/data/model/debt%20models/edit_debt_model.dart';

Map prepareUnForgiveDebt(EditDebtModel editDebtModel) {
  if (editDebtModel.debtsType == "Credit") {
    return prepareUnForgiveCreditDebt(editDebtModel);
  } else {
    return prepareUnForgiveDebitDebt(editDebtModel);
  }
}

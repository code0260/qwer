import 'package:almonazim/core/helper/functions/debts%20functions/prepare%20resuscitate%20debt/prepare_resuscitate_debit_debt.dart';
import 'package:almonazim/core/helper/functions/debts%20functions/prepare%20resuscitate%20debt/prepare_resuscitate_credit_debt.dart';
import 'package:almonazim/data/model/debt%20models/edit_debt_model.dart';

Map prepareResuscitateDebt(EditDebtModel editDebtModel) {
  if (editDebtModel.debtsType == "Credit") {
    return prepareResuscitateCreditDebt(editDebtModel);
  } else {
    return prepareResuscitateDebitDebt(editDebtModel);
  }
}

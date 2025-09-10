import 'package:almonazim/core/helper/functions/cash%20functions/add%20cash/prepare_add_cash_transaction.dart';
import 'package:almonazim/data/model/cash%20models/cash_input_model.dart';

Map prepareAddInitialCash(List<CashInputModel> cashModels) {
  List data = [];
  for (final cashModel in cashModels) {
    if (cashModel.cashAmount != 0 &&
        cashModel.cashAmount != null &&
        cashModel.cashAmountCurrencyId != null) {
      var result = prepareAddCashTransaction(cashModel);
      data.add(result);
    }
  }
  return {"data": data};
}

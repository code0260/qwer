import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/core/helper/functions/cash%20functions/edit%20cash/prepare_edit_cash_damage.dart';
import 'package:almonazim/core/helper/functions/cash%20functions/edit%20cash/prepare_edit_cash_error_record.dart';
import 'package:almonazim/core/helper/functions/cash%20functions/edit%20cash/prepare_edit_cash_lost.dart';
import 'package:almonazim/core/helper/functions/cash%20functions/edit%20cash/prepare_edit_cash_theft.dart';
import 'package:almonazim/data/model/cash%20models/edit_cash_model.dart';

Map prepareEditCash(EditCashModel editCashModel) {
  Map data = {};
  if (editCashModel.reason == EditCountReason.errorRecord.name) {
    data = prepareEditCashErrorRecord(editCashModel);
  } else if (editCashModel.reason == EditCountReason.damage.name) {
    data = prepareEditCashDamage(editCashModel);
  } else if (editCashModel.reason == EditCountReason.theft.name) {
    data = prepareEditCashTheft(editCashModel);
  } else {
    data = prepareEditCashLost(editCashModel);
  }
  return data;
}

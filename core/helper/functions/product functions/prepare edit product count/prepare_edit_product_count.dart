import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/core/helper/functions/product%20functions/prepare%20edit%20product%20count/prepare_edit_damage.dart';
import 'package:almonazim/core/helper/functions/product%20functions/prepare%20edit%20product%20count/prepare_edit_error_record.dart';
import 'package:almonazim/core/helper/functions/product%20functions/prepare%20edit%20product%20count/prepare_edit_theft.dart';
import 'package:almonazim/data/model/product%20place%20models/edit_product_count_model.dart';

Map prepareEditProductCount(EditProductCountModel editProductCountModel) {
  if (editProductCountModel.reason == EditCountReason.errorRecord.name) {
    return prepareEditErrorRecord(editProductCountModel);
  } else if (editProductCountModel.reason == EditCountReason.damage.name) {
    return prepareEditDamage(editProductCountModel);
  } else {
    return prepareEditTheft(editProductCountModel);
  }
}

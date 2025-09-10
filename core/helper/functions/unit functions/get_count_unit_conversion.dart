import 'package:almonazim/core/helper/functions/init_get_it.dart';
import 'package:almonazim/data/data%20source/repo/unite%20repo/unite_repo_imp.dart';
import 'package:almonazim/data/model/unit_model.dart';

double getCountUnitConversion(int unitId) {
  double conversion = getIt
      .get<UnitRepoImpl>()
      .completeUnitModel(UnitModel(unitsId: unitId))
      .unitsConversionFactor!;
  return conversion;
}

import 'package:almonazim/core/helper/functions/init_get_it.dart';
import 'package:almonazim/data/data%20source/repo/unite%20repo/unite_repo_imp.dart';
import 'package:almonazim/data/model/unit_model.dart';

double convertCountToBase(double originalCount, int originalCountUnitId) {
  double originalConversion = getIt
      .get<UnitRepoImpl>()
      .completeUnitModel(UnitModel(unitsId: originalCountUnitId))
      .unitsConversionFactor!;
  double newConversion = getIt
      .get<UnitRepoImpl>()
      .getBaseUnitForGroupByUnitId(originalCountUnitId)
      .unitsConversionFactor!;

  return originalCount * (originalConversion / newConversion);
}

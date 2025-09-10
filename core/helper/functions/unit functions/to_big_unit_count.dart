import 'package:almonazim/core/helper/functions/init_get_it.dart';
import 'package:almonazim/core/helper/functions/unit%20functions/fit_big_unit_count.dart';
import 'package:almonazim/data/data%20source/repo/unite%20repo/unite_repo_imp.dart';
import 'package:almonazim/data/model/unit_model.dart';

String toBigUnitCount(double originalCount, int smallUnitId) {
  var unitRepoImpl = getIt.get<UnitRepoImpl>();

  UnitModel bigUnitModel = unitRepoImpl.getBiggestUnitBySmallId(smallUnitId);

  return fitBigUnitCount(originalCount / bigUnitModel.unitsConversionFactor!,
      bigUnitModel.unitsId!,
      smallUnitId: smallUnitId);
}

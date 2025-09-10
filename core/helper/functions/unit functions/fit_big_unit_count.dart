import 'package:almonazim/core/extension/string_extensions.dart';
import 'package:almonazim/core/helper/functions/init_get_it.dart';
import 'package:almonazim/data/data%20source/repo/unite%20repo/unite_repo_imp.dart';
import 'package:almonazim/data/model/unit_model.dart';

String fitBigUnitCount(double originalCount, int bigUnitId,
    {int? smallUnitId}) {
  // Get an instance of the UnitRepoImpl
  var unitRepoImpl = getIt.get<UnitRepoImpl>();

  // Retrieve the conversion factor for the big unit
  double unitsConversion = unitRepoImpl
      .completeUnitModel(UnitModel(unitsId: bigUnitId))
      .unitsConversionFactor!
      .toDouble();

  // Split the original count into integer and fractional parts
  List<String> count = originalCount.toString().split(".");
  int bigUnitCount = count.first.toInt();
  double smallUnitCountBefore = "0.${count[1]}".toDouble();

  // Convert the fractional part to the equivalent count in the big unit
  int smallUnitCountAfterConversion =
      (smallUnitCountBefore * unitsConversion).round();

  // Get the symbols for the big and small units
  String bigUnitSymbol = unitRepoImpl
      .completeUnitModel(UnitModel(unitsId: bigUnitId))
      .unitsSymbol!;

  String smallUnitSymbol = unitRepoImpl
      .completeUnitModel(UnitModel(
          unitsId: smallUnitId ??
              getIt
                  .get<UnitRepoImpl>()
                  .getSmallUnitByBiggestId(bigUnitId)
                  .unitsId!))
      .unitsSymbol!;

  // Construct the final result based on differentPrepaidExpense scenarios
  String finalResult;
  if (smallUnitCountAfterConversion == 0) {
    if (unitsConversion != 1) {
      finalResult =
          "$bigUnitCount $bigUnitSymbol = ${(originalCount * unitsConversion).round()} $smallUnitSymbol";
    } else {
      finalResult = "$bigUnitCount $bigUnitSymbol ";
    }
  } else {
    if (bigUnitCount != 0) {
      finalResult =
          "$bigUnitCount $bigUnitSymbol و $smallUnitCountAfterConversion $smallUnitSymbol = ${(originalCount * unitsConversion).round()} $smallUnitSymbol";
    } else {
      finalResult = "$smallUnitCountAfterConversion $smallUnitSymbol";
    }
  }

  return finalResult;
}

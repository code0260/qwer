import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data.dart';
import 'package:get/get.dart';

class EditUnitSymbolCubit extends SafeCubit<String> {
  EditUnitSymbolCubit() : super("");

  void editUnitSymbol({required UnitGroup unitGroup}) {
    if (units[unitGroup] == null) {
      units[unitGroup] = [];
    }
    String unitSymbol = units[unitGroup]!
            .firstWhereOrNull(
                (unitModelFromList) => unitModelFromList.unitsIsBaseUnit == 1)
            ?.unitsSymbol ??
        "";
    emit(unitSymbol);
    // } else {
    //   emit("قطعة");
    // }
  }
}

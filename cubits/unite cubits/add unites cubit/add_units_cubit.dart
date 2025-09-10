import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/core/extension/enum_extension.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/locale/sqflite/store_units.dart';
import 'package:almonazim/data/data%20source/locale/store_work_offline.dart';
import 'package:almonazim/data/data%20source/repo/unite%20repo/unite_repo_imp.dart';
import 'package:almonazim/data/model/unit_model.dart';
import 'package:almonazim/data/model/user%20models/store_user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'add_units_state.dart';

class AddUnitCubit extends SafeCubit<AddUnitState> {
  AddUnitCubit(this.unitRepo) : super(AddUnitInitial());
  UnitRepoImpl unitRepo;
  UnitModel unitModel = const UnitModel(unitsConversionFactor: 1);
  Future<void> addUnit() async {
    emit(AddUnitLoading());
    Either<Failure, dynamic> result;
    if (StoreWorkOffline.getWorkOffline() == true) {
      unitModel = unitModel.copyWith(
        unitsOnline: 0,
        unitsBusinessId: StoreUserModel.instance.businessId!,
      );
      result = await StoreUnits.insertUnit(unitModel.toServer());
    } else {
      result = await unitRepo.addUnit(unitModel);
    }

    result.fold((failure) {
      emit(AddUnitFailure(failure.errMessage));
    }, (units) {
      emit(AddUnitSuccess());
    });
  }

  String? get validateDataExistence {
    if (unitModel.unitsName == null) {
      return "الرجاء إدخال اسم الواحدة ";
    } else if (unitModel.unitsSymbol == null) {
      return "الرجاء ادخال رمز الواحدة";
    } else if (unitModel.unitsConversionFactor == null) {
      return "الرجاء ادخال قيمة الواحدة";
    } else if (unitModel.unitsGroup == null) {
      return "الرجاء ادخال فئة الواحدة";
    } else {
      return validateData;
    }
  }

  String? get validateData {
    List<UnitModel> unitsToValidate =
        units[unitModel.unitsGroupEn!.toUnitGroup()]!;
    for (final unit in unitsToValidate) {
      if (unit.unitsName == unitModel.unitsName) {
        return "اسم الواحدة مستخدم بالفعل";
      } else if (unit.unitsSymbol == unitModel.unitsSymbol) {
        return "رمز الواحدة مستخدم بالفعل";
      } else if (unit.unitsConversionFactor!.toDouble() ==
          unitModel.unitsConversionFactor!.toDouble()) {
        return "قيمة الواحدة موجودة بالفعل";
      }
    }
    return null;
  }

  void giveUnitModelData({
    int? unitsId,
    int? unitsBusinessId,
    int? unitsIsBaseUnit,
    String? unitsName,
    double? unitsConversionFactor,
    String? unitsGroup,
    String? unitsGroupEn,
    String? unitsSymbol,
  }) {
    unitModel = unitModel.copyWith(
        unitsId: unitsId ?? unitModel.unitsId,
        unitsBusinessId: unitsBusinessId ?? unitModel.unitsBusinessId,
        unitsName: unitsName ?? unitModel.unitsName,
        unitsIsBaseUnit: unitsIsBaseUnit ?? unitModel.unitsIsBaseUnit,
        unitsConversionFactor:
            unitsConversionFactor ?? unitModel.unitsConversionFactor,
        unitsGroup: unitsGroup ?? unitModel.unitsGroup,
        unitsGroupEn: unitsGroupEn ?? unitModel.unitsGroupEn,
        unitsSymbol: unitsSymbol ?? unitModel.unitsSymbol);
  }
}

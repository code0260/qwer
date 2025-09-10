import 'package:almonazim/core/extension/enum_extension.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/repo/unite%20repo/unite_repo_imp.dart';
import 'package:almonazim/data/model/unit_model.dart';
import 'package:equatable/equatable.dart';

part 'edit_units_state.dart';

class EditUnitCubit extends SafeCubit<EditUnitState> {
  EditUnitCubit(this.unitRepo) : super(EditUnitInitial());
  UnitRepoImpl unitRepo;
  UnitModel newUnitModel = const UnitModel();
  Future<void> editUnit() async {
    emit(EditUnitLoading());
    var result = await unitRepo.editUnit(newUnitModel);
    result.fold((failure) {
      emit(EditUnitFailure(failure.errMessage));
    }, (units) {
      emit(EditUnitSuccess());
    });
  }

  String? get validateDataExistence {
    if (newUnitModel.unitsName == null) {
      return "الرجاء إدخال اسم الواحدة ";
    } else if (newUnitModel.unitsSymbol == null) {
      return "الرجاء ادخال رمز الواحدة";
    } else if (newUnitModel.unitsConversionFactor == null) {
      return "الرجاء ادخال قيمة الواحدة";
    } else if (newUnitModel.unitsGroup == null) {
      return "الرجاء ادخال فئة الواحدة";
    } else {
      return validateData;
    }
  }

  String? get validateData {
    List<UnitModel> unitsToValidate =
        units[newUnitModel.unitsGroupEn!.toUnitGroup()]!
            .where((unitModel) => unitModel.unitsBusinessId == null)
            .toList();
    //! do not use this way below because it removes from the main units map too!,
    // unitsToValidate // removing the created units for this business
    //     .removeWhere((unitModel) => unitModel.unitsBusinessId != null);
    for (final unit in unitsToValidate) {
      if (unit.unitsName == newUnitModel.unitsName) {
        return "اسم الواحدة مستخدم بالفعل";
      } else if (unit.unitsSymbol == newUnitModel.unitsSymbol) {
        return "رمز الواحدة مستخدم بالفعل";
      } else if (unit.unitsConversionFactor! ==
          newUnitModel.unitsConversionFactor!) {
        return "قيمة الواحدة موجودة بالفعل";
      }
    }
    return null;
  }

  void giveUnitModelData({
    int? unitsId,
    int? unitsBusinessId,
    String? unitsName,
    double? unitsConversionFactor,
    String? unitsGroup,
    String? unitsGroupEn,
    String? unitsSymbol,
  }) {
    newUnitModel = newUnitModel.copyWith(
      unitsId: unitsId,
      unitsBusinessId: unitsBusinessId,
      unitsName: unitsName,
      unitsConversionFactor: unitsConversionFactor,
      unitsGroup: unitsGroup,
      unitsGroupEn: unitsGroupEn,
      unitsSymbol: unitsSymbol,
    );
  }
}
